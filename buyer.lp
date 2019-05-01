%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Buyer

%%prb

%%purchase
purchase:-product_A,quality,low_price.
%purchase:-product_A,not quality,low_price.

purchase:-product_B,low_price.
%purchase:-product_B,not quality,low_price.

purchase:-product_A,lowest_price.
%purchase:-product_A,not quality,lowest_price.

purchase:-product_B,lowest_price.
%purchase:-product_B,not quality,lowest_price.


not_student.
cash.


%%constraints
:-not purchase.
:-low_price,lowest_price.


%%preferences

prefer(6,7).
prefer(6,8).
prefer(7,8).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%pab

lowest_price:-rule(6).
app(6):-maker_C.
:-rule(6),not app(6).

lowest_price:-rule(7).
app(7):-maker_D.
:-rule(7),not app(7).

low_price:-rule(8).
app(8):-maker_C.
:-rule(8),not app(8).

%%Hb

%{quality}.
%{-quality}.
%{maker_C}.
%{maker_D}.
%{product_A}.
%{product_B}.
