/* to avoid introducing modules, I'm not putting this in a module.
 * Not a good production practice to have code not in modules.
 *
 * Instead, I've tried to make my names unlikely to collide with
 * yours.
 *
 * comments are like in C
 * Or start with %
 * slash** or %% or %! starts the autodocs thing
 */
female(annie).
female(rosie).
female(esther).
female(mildred).
male(don).
male(randy).
male(mike).
male(dicky).
male(george).
male(elmer).
male(karl).
male(don_shelton).

parent_of(rosie, annie).
parent_of(rosie, randy).
parent_of(rosie, mike).
parent_of(don, annie).
parent_of(don, randy).
parent_of(don, mike).
parent_of(george, rosie).
parent_of(esther, rosie).
parent_of(elmer, don).
parent_of(mildred, don).
parent_of(esther, dicky).
parent_of(karl, dicky).
parent_of(don_shelton, dicky).

grandfather_of(Grandpa, Child) :-
    male(Grandpa),
    parent_of(Grandpa, DadOrMom),
    parent_of(DadOrMom, Child).

brother_of(Brother, Person) :-
    male(Brother),
    parent_of(Parent, Person),
    parent_of(Parent, Brother).

ancestor_of(Ancestor, Person) :-
    parent_of(Ancestor, Person).
ancestor_of(Ancestor, Person) :-
    parent_of(Ancestor, X),
    ancestor_of(X, Person).

