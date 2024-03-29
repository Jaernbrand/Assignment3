
parse(ReturnNode, Lexemes, AssignTail) :- 
	assign(Lexemes, ReturnNode, AssignTail),
	AssignTail == [].

assign(Lexemes, [assignment, IdNode, AssignSignNode, ExprNode, AssignEndNode], EndTail) :- 
	id(Lexemes, IdNode, IdTail),
	assign_op(IdTail, AssignSignNode, SignTail), 
	expr(SignTail, ExprNode, ExprTail), 
	semicolon(ExprTail, AssignEndNode, EndTail).

assign_op([L | Lexemes], ['='], Lexemes) :-
	atom(L),
	atom_codes(L, [C | Codes]), C == 61. % 61 = '=' 
semicolon([L | Lexemes], [';'], Lexemes) :- 
	atom(L),
	atom_codes(L, [C | Codes]), C == 59. % 59 = ';' 

expr(Lexemes, [TermNode], TermTail) :- 
	term(Lexemes, TermNode, TermTail).

expr(Lexemes, [TermNode, OpNode, ExprNode], ExprTail) :- 
	term(Lexemes, TermNode, TermTail),
	add_op(TermTail, OpNode, OpTail),
	expr(OpTail, ExprNode, ExprTail).

expr(Lexemes, [TermNode, OpNode, ExprNode], ExprTail) :- 
	term(Lexemes, TermNode, TermTail),
	sub_op(TermTail, OpNode, OpTail),
	expr(OpTail, ExprNode, ExprTail).

add_op([L | Lexemes], ['+'], Lexemes) :-
	atom(L), 
	atom_codes(L, [C | Codes]), C == 43. % 43 = '+' 
sub_op([L | Lexemes], ['-'], Lexemes) :-
	atom(L),
	atom_codes(L, [C | Codes]), C == 45. % 45 = '-' 

term(Lexemes, [FactorNode], FactorTail) :- 
	factor(Lexemes, FactorNode, FactorTail).

term(Lexemes, [FactorNode, OpNode, TermNode], TermTail) :-
	factor(Lexemes, FactorNode, FactorTail),
	termOperator(FactorTail, OpNode, OpTail),
	term(OpTail, TermNode, TermTail).

termOperator([L | Lexemes], ['*'], Lexemes) :- 
	atom(L), 
	atom_codes(L, [C | Codes]), C == 42. % 42 = '*' 
termOperator([L | Lexemes], ['/'], Lexemes) :-
	atom(L),
	atom_codes(L, [C | Codes]), C == 47. % 47 = '/' 

factor(Lexemes, [IntNode], IntTail) :- 
	int(Lexemes, IntNode, IntTail).
factor(Lexemes, [LPNode,  ExprNode, RPNode], RightParTail) :- 
	leftParen(Lexemes, LPNode, LeftParTail),  
	expr(LeftParTail, ExprNode, ExprTail), 
	rightParen(ExprTail, RPNode, RightParTail).

leftParen([L | Lexemes], ['('], Lexemes) :- 
	 atom(L), atom_codes(L, [C | Codes]), C == 40. % 40 = '('
rightParen([L | Lexemes], [')'], Lexemes) :- 
	atom(L), atom_codes(L, [C | Codes]), C == 41. % 41 = ')'

id([L | Lexemes], L, Lexemes) :-
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
	number(L),
	number_codes(L, Code),
	valid_number_range(Code).

valid_number_range([]).
valid_number_range([Code|Rest]):-
	Code >= 48,
	Code =< 57,
	valid_number_range(Rest).
