
parse(ReturnNode, Lexemes, VariablesOut) :- assign(Lexemes, ReturnNode).

assign(Lexemes, [IdNode, AssignSignNode, ExprNode, AssignEndNode]) :- 
	id(Lexemes, IdNode, IdTail),
	assignSign(IdTail, AssignSignNode, SignTail), 
	expr(SignTail, ExprNode, ExprTail), 
	assignEnd(ExprTail, AssignEndNode).

assignSign([L | Lexemes], ['='], Lexemes) :-
	atom_codes(L, [C | Codes]), C == 61. % 61 = '=' 
assignEnd([L | Lexemes], [';']) :- 
	atom_codes(L, [C | Codes]), C == 59. % 59 = ';' 

expr(Lexemes, TermNode, TermTail) :- 
	term(Lexemes, TermNode, TermTail).

expr(Lexemes, [TermNode, OpNode, ExprNode], ExpreTail) :- 
	term(Lexemes, TermNode, TermTail),
	exprOperator(TermTail, OpNode, OpTail),
	expr(OpTail, ExprNode, ExprTail).

exprOperator([L | Lexemes], ['+'], Lexemes) :-
	atom_codes(L, [C | Codes]), C == 43. % 43 = '+' 
exprOperator([L | Lexemes], ['-'], Lexemes) :-
	atom_codes(L, [C | Codes]), C == 45. % 45 = '-' 

term(Lexemes, FactorNode, FactorTail) :- 
	factor(Lexemes, FactorNode, FactorTail).

term(Lexemes, [FactorNode, OpNode, TermNode], TermTail) :-
	factor(Lexemes, FactorNode, FactorTail),
	termOperator(FactorTail, OpNode, OpTail),
	term(OpTail, TermNode, TermTail).

termOperator([L | Lexemes], ['*'], Lexemes) :- 
	atom_codes(L, [C | Codes]), C == 42. % 42 = '*' 
termOperator([L | Lexemes], ['/'], Lexemes) :-
	atom_codes(L, [C | Codes]), C == 47. % 47 = '/' 

factor(Lexemes, IdNode, IntTail) :- 
	int(Lexemes, IdNode, IntTail).
factor(Lexemes, [LPNode,  ExprNode, RPNode], RightParTail) :- 
	leftParen(Lexemes, LPNode, LeftParTail),  
	expr(LeftParTail, ExprNode, ExprTail), 
	rightParen(ExprTail, RPNode, RightParTail).

leftParen([L | Lexemes], ['('], Lexemes) :- 
	atom_codes(L, [C | Codes]), C == 40. % 40 = '('
rightParen([L | Lexemes], [')'], Lexemes) :- 
	atom_codes(L, [C | Codes]), C == 41. % 41 = ')'

id([L | Lexemes], [L], Lexemes) :-
	validate_id(L).	

validate_id(L):-
	atom_codes(L, Code),
	valid_letter_range(Code).

valid_letter_range([]).
valid_letter_range([Code|Rest]):-
	Code >= 97,
	Code =< 122,
	valid_letter_range(Rest).



int([L|Lexemes], [L], Lexemes) :-
	validate_int(L).

validate_int(L):-
	number_codes(L, Code),
	valid_number_range(Code).

valid_number_range([]).
valid_number_range([Code|Rest]):-
	Code >= 48,
	Code =< 57,
	valid_number_range(Rest).
