
%parse(assign()) --> assign().

parse(assign(Ident, Op, Token, End)) --> 
	id(Ident), 
	opAssign(Op), 
	expr(Token), 
	assignEnd(End).

opAssign('=') --> [=].

assignEnd(';') --> [;]. 

expr(expr(Token)) --> 
	term(Token).

expr(expr(TermToken, Op, ExprToken)) --> 
	term(TermToken),
	exprOperator(Op),
	expr(ExprToken).

exprOperator('+') --> [+].
exprOperator('-') --> [-].

term(term(Token)) --> 
	factor(Token).

term(term(FactorToken, Op, TermToken)) --> 
	factor(FactorToken),
	termOperator(Op),
	term(TermToken).

termOperator('*') --> [*]. 
termOperator('/') --> [/].

factor(factor(N)) --> 
	int(N).
factor(factor(LP, Token, RP)) --> 
	leftParen(LP),  
	expr(Token), 
	rightParen(RP).

leftParen('(') --> ['(']. 
rightParen(')') --> [')']. 

id(Ident, [Ident | Tail], Tail) :- 
	validate_id(Ident).	

validate_id(L):-
	atom_codes(L, Code),
	valid_letter_range(Code).

valid_letter_range([]).
valid_letter_range([Code|Rest]):-
	Code >= 97,
	Code =< 122,
	valid_letter_range(Rest).


int(N, [N | Tail], Tail) :-
	number(N).

validate_int(L):-
	number(L),
	number_codes(L, Code),
	valid_number_range(Code).

valid_number_range([]).
valid_number_range([Code|Rest]):-
	Code >= 48,
	Code =< 57,
	valid_number_range(Rest).
