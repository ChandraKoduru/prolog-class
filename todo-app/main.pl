:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_error)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_files)).
:- use_module(library(http/html_head)).
:- use_module(library(http/http_server_files)).
:- use_module(library(http/http_log)).
:- use_module(library(http/http_session)).
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
% :- html_resource(assets('bootstrap.css'), []).
% :- html_resource(assets('bootstrap.js'), []).

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

:- http_handler(root(.), home_page_handler, [id(home_page)]).

:- multifile user:body//2.
:- multifile user:head//2.

user:head(chandra_style, Header) -->
    html(head([yo("Chandra's TODO"), Header])).

user:body(chandra_style, Body) -->
    html([\stylesheets, 
          \scripts,
          body([class=['d-flex', 'flex-column', 'h-100']], 
              [\navbar,
               main([class=['flex-shrink-0'], role='main'], 
                    div([class='container'], Body)),
               \sticky_footer])]).

navbar -->
    html(header(nav([class=['navbar', 'navbar-expand', 'navbar-dark', 'fixed-top', 'bg-dark']],
            [div("Chandra's TODO")]))).
           
scripts --> html([ \html_requires(assets('bootstrap.js'))
                 ]).
stylesheets --> html([
                \html_requires(assets('bootstrap.css')),
                \html_requires(assets('sticky-footer-navbar.css'))]).

sticky_footer -->
    html(footer([class=['footer', 'mt-auto', 'py-3']],
                [div([class=['container']], 
                     span([class=['text-muted']], 
                          "Footer"))])).

home_page_handler(_Request):-
    user_id(UserId),
    % todo_api:load_user(UserId),
    userid_todos(UserId, Todos),
    http_log('UserId ~w', [UserId]),
    reply_html_page(
        chandra_style,
        [title('Chandra- ToDo Application')],
        [hi('Body'),
        p(['UserId ', UserId]),
        p('Oncemore - UserId ~w'-[UserId]),
        p('User Todos ~w'-[Todos]),
        a(href=location_by_id(delete_todo), 'Delete Todo')
        ]
    ).

:- http_handler(root(delete/TodoId), delete_todo(TodoId), [id(delete_todo)]).

delete_todo(TodoId, _Request):-
    reply_html_page(
        [title('Chandra- ToDo Application')],
        [h1(TodoId), h2("Deleted todo")]
    ).

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