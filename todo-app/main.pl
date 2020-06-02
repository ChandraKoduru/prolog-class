:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_error)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_files)).
:- use_module(library(http/html_head)).
:- use_module(library(http/http_server_files)).
:- use_module(library(http/http_log)).
:- use_module(library(http/http_session)).
:- use_module(library(http/http_client)).
:- use_module(todo_api).

:- multifile http:location/3.
:- multifile user:file_search_path/2.
:- dynamic http:location/3.

http:location(assets, root(assets), []).

user:file_search_path(bootstrap, './assets/bootstrap-4.5.0-dist').
user:file_search_path(assets, bootstrap(css)).
user:file_search_path(assets, bootstrap(js)).
user:file_search_path(assets, './assets/other_resources').

%  Asset dependency management
:- html_resource(assets('sticky-footer-navbar.css'), [requires(assets('bootstrap.css'))]).
:- html_resource(assets('bootstrap.bundle.js'), [requires(assets('jquery-3.5.1.js'))]).
:- html_resource(assets('bootstrap.js'), [requires(assets('jquery-3.5.1.js'))]).

% :- http_handler(assets(css), serve_files_in_directory(css), [prefix]).
% :- http_handler(assets(js), serve_files_in_directory(js), [prefix]).
%
% Following are ways to serve static files
% :- http_handler(assets(.), serve_assets, [prefix]).
% serve_assets(Request) :-
	 % http_reply_from_files(assets, [], Request).
% serve_assets(Request) :-
	  % http_404([], Request).

:- http_handler(assets(.), serve_files_in_directory(assets), [prefix, id(assets)]).

:- multifile user:body//2.
:- multifile user:head//2.

user:head(chandra_style, Header) -->
    html(head([meta([name='viewport', 
                     content=['width=device-width,', 'initial-scale=1,', 'shrink-to-fit=no']], []),
               yo("Chandra's TODO"), Header])).

user:body(chandra_style, Body) -->
    html([\stylesheets, 
          \scripts,
          body([class=['d-flex', 'flex-column', 'h-100']], 
              [\navbar,
               main([class=['flex-shrink-0'], role='main'], 
                    div([class='container'], Body)),
               \sticky_footer])]).

navbar -->
    html(header(nav([class=['navbar', 'navbar-expand', 'navbar-light', 'fixed-top', 'bg-light']],
            [div([a([href="/"], "Chandra's TODO")])]))).
           
scripts --> html([ \html_requires(assets('bootstrap.bundle.js'))
                 ]).
stylesheets --> html([
                \html_requires(assets('bootstrap.css')),
                \html_requires(assets('sticky-footer-navbar.css'))]).

sticky_footer -->
    html(footer([class=['footer', 'mt-auto', 'py-3']],
                [div([class=['container']], 
                     span([class=['text-muted']], 
                          "Footer"))])).


todo_li_item(todo(_, TodoId, TodoText), O):-
    O = li([class=['list-group-item']], 
           [TodoText,span([]," "),a(href=location_by_id(delete_todo)+TodoId, "Remove")]).

todo_ul_items(TodoItems)--> 
    {
        maplist(todo_li_item, TodoItems, LiItems)
    },
    html(ul([class=['list-group']], LiItems)).

:- http_handler(root(.), home_page_handler, [id(home_page)]).

home_page_handler(Request):-
    user_id(UserId),
    % todo_api:new_user(UserId),
    http_log('UserId ~w', [UserId]),
    render_body(Request).

:- http_handler(root(add), add_todo, [id(add_todo)]).

data_to_todotext(['='(todo_text, TodoText)|_], TodoText):- !.
data_to_todotext([_|R], TodoText):-
    data_to_todotext(R, TodoText).

add_todo(Request):-
    member(method(post), Request), !,
    http_read_data(Request, Data, []),
    (data_to_todotext(Data, TodoText); TodoText=""), % default case
    http_log("~nData: ~w ~n~n", [Data]),
    http_log("~nTodoText: ~w ~n~n", [TodoText]),
    user_id(UserId),
    http_log('UserId ~w', [UserId]),
    userid_new_todo(UserId, TodoText, _),
        % format('Content-type: text/html~n~n', []),
	% format('<p>', []),
        % portray_clause(Data),
	% format('</p><p>========~n', []),
	% portray_clause(Request),
	% format('</p>').
    render_body(Request).

:- http_handler(root(delete/TodoId), delete_todo(TodoId), [id(delete_todo)]).

delete_todo(TodoId, Request):-
    user_id(UserId),
    atom_number(TodoId, TodoIdAsNumber),
    (userid_remove_todo(UserId, TodoIdAsNumber);true), % It is OK, if invoked on a deleted item.
    render_body(Request).

render_body(_Request):-
    user_id(UserId),
    userid_todos(UserId, Todos),
    % p(UserId),
    reply_html_page(
        chandra_style,
        [title('Todo-List')],
        [div([class='container'], 
             div([class='row'], 
               [
                div([class='col-8'], \todo_ul_items(Todos)),
                div([class='col-4'], \new_todo_form)
               ])
            )]
        % \new_todo_form,
        % \todo_ul_items(Todos)
        % ]
    ).

new_todo_form --> 
    html([form([action='/add', method='POST'], [
            div([class=['form-group']], 
               [label([for=todo_text],'Todo:'), input([name=todo_text, type=textarea]) ]),
            button([name=submit, type=submit,class=['btn', 'btn-primary']], "Submit")])]).
                   

a_handler(From, Request) :-
	member(request_uri(URI), Request),
	reply_html_page(
	   [title('Howdy')],
	   [h1('A Page'),
	    p('served from handler ~w'-[From]),
	    p('uri ~w'-[URI])]).

user_id(UserId):-
    http_session_data(user_id(UserId)),!.
user_id(UserId):-
    random(0, 10000000000000, UserId),
    http_session_assert(user_id(UserId)).

server_start(Port):-
	http_server(http_dispatch, [port(Port)]).

server_stop(Port):-
	http_stop_server(Port, []).
