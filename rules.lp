%rules
%
%{rule(1)}.
%{rule(2)}.
%{rule(3)}.
%{rule(4)}.
%{rule(5)}.


%constraints
% if R is preferred to R1 then the two of them cannot be used at the same time 
:- rule(R), rule(R1), prefer(R, R1). 

% at least one of the rule needs to be used 
:-  {rule(_)} 0. 

%
% defines the rule names 
%
rule_name(X) :- prefer(X,_).
rule_name(X) :- prefer(_,X).
%

% transitivity between preferences 

prefer(X,Y) :- prefer(X,Z), prefer(Z,Y), X!=Z, Z!=Y. 
incompatible(X,Y) :- rule_name(X), rule_name(Y), X!=Y, not prefer(X,Y), not prefer(Y,X).


%% computes the best rules that have not been used! 

not_best(R) :- prefer(X,R), not used(X).
best(R) :- not not_best(R), rule_name(R).

%
%% some of the best rules must be used if it has not been used before 

not_in_used(R):- best(R), not used(R), rule_name(R), not rule(R).
ok(R):- not_in_used(R), incompatible(R,R1), R!=R1, rule(R1). 
:- not_in_used(R), not ok(R).

%
%% minimize the set of used rules 

no(AR) :- AR = #count {N : rule(N)}.
#minimize {N  : no(N)}. 

%%#show not_best/1.
