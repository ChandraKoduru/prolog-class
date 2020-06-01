:- module(todo_api, 
    [init/0, new_user/1, remove_user/1, 
    userid_todos/2, userid_new_todo/3, userid_remove_todo/2
    ]).
:- dynamic(todo/3).
:- dynamic(todo_user_maxid/2).

init:-
    retractall(todo(_, _, _)),
    retractall(todo_user_maxid(_, _)),
    new_user(1).

% existing user
userid_next_todoid(UserId, TodoId):-
    todo_user_maxid(UserId, TodoId0), !,
    TodoId is TodoId0 + 1,
    retract(todo_user_maxid(UserId, TodoId0)),
    assert(todo_user_maxid(UserId, TodoId)).

userid_next_todoid(UserId, TodoId):-
    TodoId = 1,
    assert(todo_user_maxid(UserId, TodoId)).

% initializing a new user' data
new_user(UserId):-
    todo_user_maxid(UserId, _), 
    !, % A user with the given userid already exists
    fail. 
new_user(UserId):-
    userid_new_todo(UserId, "First", _),
    userid_new_todo(UserId, "Second", _).

remove_user(UserId):-
    retractall(todo(UserId, _, _)),
    retractall(todo_user_maxid(UserId, _)).

userid_todos(UserId, Todos):-
	findall(todo(UserId, TodoId, TodoText), todo(UserId, TodoId, TodoText), Todos).

userid_new_todo(UserId, TodoText, Todo):-
    userid_next_todoid(UserId, TodoId),
    Todo = todo(UserId, TodoId, TodoText),
	asserta(Todo).

userid_remove_todo(UserId, TodoId):-
	retract(todo(UserId, TodoId, _)).
