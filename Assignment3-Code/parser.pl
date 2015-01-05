
parse(Tree, Lexemes, VariablesOut) :- assign(Tree, Lexemes).

assign(Tree, Lexemes) :- 
	id(Tree, Lexemes), 
	assignSign(Tree, Lexemes), 
	expr(Tree, Lexemes), 
	assignEnd(Tree, Lexemes).

assignSign(Tree, [L | Lexemes]) :-
	atom_codes(L, [C | Codes]), C == 61. % 61 = '=' 
assignEnd(Tree, [L | Lexemes]) :- 
	atom_codes(L, [C | Codes]), C == 59. % 59 = ';' 

expr(Tree, Lexemes) :- term(Tree, Lexemes)
	term(Tree, Lexemes).

expr(Tree, Lexemes) :- term(Tree, Lexemes)
	term(Tree, Lexemes),
	exprOperator(Tree, Lexemes),
	expr(Tree, Lexemes).

exprOperator(Tree, [L | Lexemes]) :-
	atom_codes(L, [C | Codes]), C == 43. % 43 = '+' 
exprOperator(Tree, [L | Lexemes]) :-
	atom_codes(L, [C | Codes]), C == 45. % 45 = '-' 

term(Tree, Lexemes) :- factor(Tree, Lexemes) :-
	factor(Tree, Lexemes).

term(Tree, Lexemes) :- factor(Tree, Lexemes) :-
	factor(Tree, Lexemes),
	termOperator(Tree, Lexemes),
	term(Tree, Lexemes).

termOperator(Tree, [L | Lexemes]) :- 
	atom_codes(L, [C | Codes]), C == 42. % 42 = '*' 
termOperator(Tree, [L | Lexemes]) :-
	atom_codes(L, [C | Codes]), C == 47. % 47 = '/' 

factor(Tree, Lexemes) :- id(Tree, Lexemes).
factor(Tree, Lexemes) :- 
	leftParen(Lexemes),  
	expr(Tree, Lexemes), 
	rightParen(Lexemes).

leftParen(Tree, [L | Lexemes]) :- 
	atom_codes(L, [C | Codes]), C == 40. % 40 = '('
rightParen(Tree, [L | Lexemes]) :- 
	atom_codes(L, [C | Codes]), C == 41. % 41 = ')'

id(Tree, [L | Lexemes]) :-
	validate_id([L]).	

validate_id([L]):-
	atom_codes(L, Code),
	valid_letter_range(Code).

valid_letter_range([]).
valid_letter_range([Code|Rest]):-
	Code >= 97,
	Code =< 122,
	valid_letter_range(Rest).


int(Tree, [L | Lexemes]) /*:- L '0-9'*/.

