:- module(todo_api, [init/0, 
    new_session/1, remove_session/1, 
    sessionid_todos/2, sessionid_new_todo/3, sessionid_remove_todo/2
    ]).
:- dynamic(todo/3).
:- dynamic(todo_session_maxid/2).

init:-
    retractall(todo(_, _, _)),
    retractall(todo_session_maxid(_, _)),
    new_session(1).

% existing session
sessionid_next_todoid(SessionId, TodoId):-
    todo_session_maxid(SessionId, TodoId0), !,
    TodoId is TodoId0 + 1,
    retract(todo_session_maxid(SessionId, TodoId0)),
    assert(todo_session_maxid(SessionId, TodoId)).

sessionid_next_todoid(SessionId, TodoId):-
    TodoId = 1,
    assert(todo_session_maxid(SessionId, TodoId)).

% initializing a new session' data
new_session(SessionId):-
    todo_session_maxid(SessionId, _), 
    !, % A session with the given sessionid already exists
    fail. 
new_session(SessionId):-
    sessionid_new_todo(SessionId, "First", _),
    sessionid_new_todo(SessionId, "Second", _).

remove_session(SessionId):-
    retractall(todo(SessionId, _, _)),
    retractall(todo_session_maxid(SessionId, _)).

sessionid_todos(SessionId, Todos):-
	findall(todo(SessionId, TodoId, TodoText), todo(SessionId, TodoId, TodoText), Todos).

sessionid_new_todo(SessionId, TodoText, Todo):-
    sessionid_next_todoid(SessionId, TodoId),
    Todo = todo(SessionId, TodoId, TodoText),
	asserta(Todo).

sessionid_remove_todo(SessionId, TodoId):-
	retract(todo(SessionId, TodoId, _)).
