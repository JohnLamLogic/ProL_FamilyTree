male(tim-ant).
male(jim-bat).
male(joe-ant).
male(mike-ant).
male(bill-bat).
male(matt-dog).
male(bob-ant).
male(jim-ant).
male(joe-dog).
male(bob-fig).
male(tim-fig).
male(tom-ink).
male(jim-ink).
male(rob-ink).
male(tim-ink).
male(prince-emu).
male(tye-emu).

female(jill-emu).
female(meg-gum).
female(pam-ant).
female(amy-bat).
female(mab-cat).
female(emma-ham).
female(ann-ant).
female(sal-dog).
female(moll-bat).
female(pat-hat).
female(mary-ant).
female(amy-ant).
female(jill-gorg).
female(mary-pop).
female(mary-emu).
female(dom-emu).
female(del-emu).

married(tim-ant, jill-emu).
married(jim-bat, meg-gum).
married(joe-ant, amy-bat).
married(mike-ant, mab-cat).
married(pam-ant, matt-dog).
married(bill-bat, emma-ham).
married(ann-ant, bob-fig).
married(bob-ant, tim-fig).
married(jim-ant, pat-hat).
married(moll-bat, tom-ink).
married(jim-ink, jill-gorg). %jim now married
married(rob-ink, mary-pop).

parent(del-emu, tye-emu).
parent(tye-emu, prince-emu).
parent(prince-emu, dom-emu).
parent(dom-emu, mary-emu).
parent(jill-emu, mary-emu).
parent(tim-ink, mary-pop).
parent(tim-ink, rob-ink).
parent(rob-ink, jill-gorg).
parent(rob-ink, jim-ink).
parent(joe-ant, tim-ant).
parent(joe-ant, jill-emu).
parent(mike-ant, tim-ant).
parent(mike-ant, jill-emu).
parent(pam-ant, tim-ant).
parent(pam-ant, jill-emu).
parent(amy-bat, jim-bat).
parent(amy-bat, meg-gum).
parent(bill-bat, jim-bat).
parent(bill-bat, meg-gum).
parent(ann-ant, joe-ant).
parent(ann-ant, amy-bat).
parent(bob-ant, joe-ant).
parent(bob-ant, amy-bat).
parent(jim-ant, joe-ant).
parent(jim-ant, amy-bat).
parent(joe-dog, pam-ant).
parent(joe-dog, matt-dog).
parent(sal-dog, pam-ant).
parent(sal-dog, matt-dog).
parent(moll-bat, bill-bat).
parent(moll-bat, emma-ham).
parent(mary-ant, jim-ant).
parent(mary-ant, pat-hat).
parent(amy-ant, jim-ant).
parent(amy-ant, pat-hat).
parent(jim-ink, moll-bat).
parent(jim-ink, tom-ink).

%Sibling relationships
sibling(X, Y) :- parent(X, P), parent(Y, P), X\=Y.
related(X, is-brother-of, Y) :- sibling(X, Y), male(X).
related(X, is-sister-of, Y) :- sibling(X, Y), female(X).


%Are married? Trivial but ya know 
related(X, is-married-to, Y) :- married(X, Y).

%Parent mother-father relationships
related(X, is-mother-of, Y) :- parent(Y, X), female(X).
related(X, is-father-of, Y) :- parent(Y, X), male(X).
related(X, is-son-of, Y) :- parent(X, Y), male(X).
related(X, is-daughter-of, Y) :- parent(X, Y), female(X).


%Aunt and uncle stuff
related(X, is-uncle-of, Y) :- parent(Y, P), sibling(X, P), male(X).
related(X, is-aunt-of, Y) :- parent(Y, P), sibling(X, P), female(X).
related(X, is-neice-of, Y) :- sibling(Y, Z), parent(X, Z), female(X).
related(X, is-nephew-of, Y) :- sibling(Y, Z), parent(X, Z), male(X).


%Grandparent stuff
related(X, is-grandparent-of, Y) :- parent(P, X), parent(Y, P).
related(X, is-grandma-of, Y) :- parent(P, X), parent(Y, P), female(X).
related(X, is-grandpa-of, Y) :- parent(P, X), parent(Y, P), male(X).
related(X, is-great-grandparent-of, Y) :- related(X, is-grandparent-of, P), parent(Y, P).

%Cousin Stuff but not n-th
related(X , is-cousin-of, Y) :- parent(X, P1), parent(Y, P2), sibling(P1, P2), X\=Y.

%Great Aunt and Uncle
related(X, is-great-aunt-of, Y) :- related(X, is-aunt-of, P), parent(Y, P).
related(X, is-great-uncle-of, Y) :- related(X, is-uncle-of, P), parent(Y, P).

%Ancestor
related(X, is-ancestor-of, Y) :- parent(Y, X).
related(X, is-ancestor-of, Y) :- parent(Y, Z), related(X, is-ancestor-of, Z).

%Blood check
related(X, share-common-ancestor, Y) :- related(A, is-ancestor-of, Y), related(A, is-ancestor-of, X), X\=Y.
related(X , is-blood-related-to, Y) :- related(X, is-ancestor-of, Y); related(Y, is-ancestor-of, X); related(X, share-common-ancestor, Y). 


%N-th Cousin (Way to mind boggaling)
related(X, is-nth-cousin-of(1), Y) :-related(X, is-cousin-of, Y).
related(X, is-nth-cousin-of(N), Y) :- N > 1, parent(X, P1), parent(Y, P2), N1 is N - 1, related(P1, is-nth-cousin-of(N1), P2), X \= Y.

related(X, is-nth-cousin-of(N, removed-up, 0), Y) :- related(X, is-nth-cousin-of(N), Y).
related(X, is-nth-cousin-of(N, removed-up, M), Y) :- M > 0, parent(X, PX), M1 is M - 1, related(PX, is-nth-cousin-of(N, removed-up, M1), Y), X \= Y.

related(X, is-nth-cousin-of(N, removed-down, 0), Y) :- related(X, is-nth-cousin-of(N), Y).
related(X, is-nth-cousin-of(N, removed-down, M), Y) :- M > 0, parent(Y, PY), M1 is M - 1, related(X, is-nth-cousin-of(N, removed-down, M1), PY), X \= Y.

%add something cool here
print_ancestor_chain(X) :- parent(X, P), write(X), write(' is the child of '), write(P), nl, print_ancestor_chain(P).
print_ancestor_chain(_).
