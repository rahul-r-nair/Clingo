%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%prs

senior_customer :- senior.
student_customer :- student.
-quality:-product_B.
maker_C:-product_A.
maker_D:-product_B.
%bargain:-product_B.

%preference

prefer(1,2).
prefer(1,3).
prefer(1,4).
prefer(1,5).
prefer(2,5).
prefer(3,5).
prefer(4,5).


%price
sale:- product_A, high_price.
sale:- product_A, low_price.

sale:- product_B, high_price.
sale:- product_B, low_price.
sale:- product_B, lowest_price.


%constraints
:-high_price, low_price.
:-high_price, lowest_price.
:-low_price, lowest_price.
:-not sale.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%pas
high_price:-rule(1).


low_price:-rule(2).
app(2):- senior_customer.
:- rule(2), not app(2).


low_price:-rule(3).
app(3):- student_customer.
:- rule(3), not app(3).


low_price:-rule(4).
app(4):- bargain, cash.
:- rule(4), not app(4).


lowest_price:-rule(5).
app(5):- mail_list, cash.
:- rule(5), not app(5).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%app(2).
%product_A.
%product_B.

%%% high price 
%rule(1).

%%% low price 1 

%used(1).
%rule(2).
%senior.

%%% low price 2 
%
%used(1).
%used(2). 
%rule(3). 
%student.

%%% low price 3 

%used(1).
%used(2). 
%used(3).
%rule(4).
%cash.
 
%%% lowest price 

%used(1).  
%used(4).
%used(3).
%used(2).
%rule(5).

%mail_list.
%cash.



%{rule(1)}.
%{rule(2)}.
%{rule(3)}.
%{rule(4)}.
%{rule(5)}.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
%#show best/1.
%#show rule/1.
%#show used/1.
% 
