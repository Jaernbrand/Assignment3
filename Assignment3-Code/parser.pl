
parse(ReturnNode, Lexemes, VariablesOut) :- assign(Lexemes, ReturnNode).

assign(Lexemes, [IdNode | AssignSignNode | ExprNode | AssignEndNode]) :- 
	id(Lexemes, IdNode), 
	assignSign(Lexemes, AssignSignNode), 
	expr(Lexemes, ExprNode), 
	assignEnd(Lexemes, AssignEndNode).

assignSign([L | Lexemes], ['=']) :-
	atom_codes(L, [C | Codes]), C == 61. % 61 = '=' 
assignEnd([L | Lexemes], [';']) :- 
	atom_codes(L, [C | Codes]), C == 59. % 59 = ';' 

expr(Lexemes, ReturnNode) :- term(Tree, Lexemes)
	term(Tree, Lexemes).

expr(Lexemes, ReturnNode) :- term(Tree, Lexemes)
	term(Tree, Lexemes),
	exprOperator(Tree, Lexemes),
	expr(Tree, Lexemes).

exprOperator([L | Lexemes], ReturnNode) :-
	atom_codes(L, [C | Codes]), C == 43. % 43 = '+' 
exprOperator([L | Lexemes], ReturnNode) :-
	atom_codes(L, [C | Codes]), C == 45. % 45 = '-' 

term(Lexemes, ReturnNode) :- factor(Tree, Lexemes) :-
	factor(Tree, Lexemes).

term(Lexemes, ReturnNode) :- factor(Tree, Lexemes) :-
	factor(Tree, Lexemes),
	termOperator(Tree, Lexemes),
	term(Tree, Lexemes).

termOperator([L | Lexemes], ReturnNode) :- 
	atom_codes(L, [C | Codes]), C == 42. % 42 = '*' 
termOperator([L | Lexemes], ReturnNode) :-
	atom_codes(L, [C | Codes]), C == 47. % 47 = '/' 

factor(Lexemes, RetrunNode) :- id(Tree, Lexemes).
factor(Lexemes, ReturnNode) :- 
	leftParen(Lexemes),  
	expr(Tree, Lexemes), 
	rightParen(Lexemes).

leftParen([L | Lexemes], ReturnNode) :- 
	atom_codes(L, [C | Codes]), C == 40. % 40 = '('
rightParen([L | Lexemes], ReturnNode) :- 
	atom_codes(L, [C | Codes]), C == 41. % 41 = ')'

id([L | Lexemes], ReturnNode) :-
	validate_id([L]).	

validate_id([L]):-
	atom_codes(L, Code),
	valid_letter_range(Code).

valid_letter_range([]).
valid_letter_range([Code|Rest]):-
	Code >= 97,
	Code =< 122,
	valid_letter_range(Rest).



int([L|Lexemes]) :-
	validate_int(L).

validate_int(L):-
	number_codes(L, Code),
	valid_number_range(Code).

valid_number_range([]).
valid_number_range([Code|Rest]):-
	Code >= 48,
	Code =< 57,
	valid_number_range(Rest).
