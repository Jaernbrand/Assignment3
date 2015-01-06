
parse(ReturnNode, Lexemes, VariablesOut) :- assign(Lexemes, ReturnNode).

assign(Lexemes, [IdNode/*, AssignSignNode, ExprNode, AssignEndNode]) :- 
	id(Lexemes, IdNode), 
	%assignSign(Lexemes, AssignSignNode), 
	%expr(Lexemes, ExprNode), 
	/*assignEnd(Lexemes, AssignEndNode)*/.

assignSign([L | Lexemes], ['=']) :-
	atom_codes(L, [C | Codes]), C == 61. % 61 = '=' 
assignEnd([L | Lexemes], [';']) :- 
	atom_codes(L, [C | Codes]), C == 59. % 59 = ';' 

expr(Lexemes, TermNode) :- 
	term(Lexemes, TermNode).

expr(Lexemes, [TermNode, OpNode, ExprNode]) :- 
	term(Lexemes, TermNode),
	exprOperator(Lexemes, OpNode),
	expr(Lexemes, ExprNode).

exprOperator([L | Lexemes], ['+']) :-
	atom_codes(L, [C | Codes]), C == 43. % 43 = '+' 
exprOperator([L | Lexemes], ['-']) :-
	atom_codes(L, [C | Codes]), C == 45. % 45 = '-' 

term(Lexemes, FactorNode) :- 
	factor(Lexemes, FactorNode).

term(Lexemes, [FactorNode, OpNode, TermNode]) :-
	factor(Lexemes, FactorNode),
	termOperator(Lexemes, OpNode),
	term(Lexemes, TermNode).

termOperator([L | Lexemes], ['*']) :- 
	atom_codes(L, [C | Codes]), C == 42. % 42 = '*' 
termOperator([L | Lexemes], ['/']) :-
	atom_codes(L, [C | Codes]), C == 47. % 47 = '/' 

factor(Lexemes, IdNode) :- 
	int(Lexemes, IdNode).
factor(Lexemes, [LPNode,  ExprNode, RPNode]) :- 
	leftParen(Lexemes, LPNode),  
	expr(Lexemes, ExprNode), 
	rightParen(Lexemes, RPNode).

leftParen([L | Lexemes], ['(']) :- 
	atom_codes(L, [C | Codes]), C == 40. % 40 = '('
rightParen([L | Lexemes], [')']) :- 
	atom_codes(L, [C | Codes]), C == 41. % 41 = ')'

id([L | Lexemes], [L]) :-
	validate_id(L).	

validate_id(L):-
	atom_codes(L, Code),
	valid_letter_range(Code).

valid_letter_range([]).
valid_letter_range([Code|Rest]):-
	Code >= 97,
	Code =< 122,
	valid_letter_range(Rest).



int([L|Lexemes], [L]) :-
	validate_int(L).

validate_int(L):-
	number_codes(L, Code),
	valid_number_range(Code).

valid_number_range([]).
valid_number_range([Code|Rest]):-
	Code >= 48,
	Code =< 57,
	valid_number_range(Rest).
