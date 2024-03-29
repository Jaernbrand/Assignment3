
parse(assignment(Ident, Op, Token, End)) --> 
	ident(Ident), 
	assign_op(Op), 
	expression(Token), 
	semicolon(End).

assign_op(assign_op) --> [=].

semicolon(semicolon) --> [;]. 

expression(expression(Token)) --> 
	term(Token).

expression(expression(TermToken, Op, ExprToken)) --> 
	term(TermToken),
	add_op(Op),
	expression(ExprToken).

expression(expression(TermToken, Op, ExprToken)) --> 
	term(TermToken),
	sub_op(Op),
	expression(ExprToken).

add_op(add_op) --> [+].
sub_op(sub_op) --> [-].

term(term(Token)) --> 
	factor(Token).

term(term(FactorToken, Op, TermToken)) --> 
	factor(FactorToken),
	mult_op(Op),
	term(TermToken).

term(term(FactorToken, Op, TermToken)) --> 
	factor(FactorToken),
	div_op(Op),
	term(TermToken).

mult_op(mult_op) --> [*]. 
div_op(div_op) --> [/].

factor(factor(N)) --> 
	int(N).
factor(factor(LP, Token, RP)) --> 
	left_paren(LP),  
	expression(Token), 
	right_paren(RP).

left_paren(left_paren) --> ['(']. 
right_paren(right_paren) --> [')']. 

ident(ident(Head), [Head | Tail], Tail) :- 
	validate_id(Head).	

validate_id(L):-
	atom_codes(L, Code),
	valid_letter_range(Code).

valid_letter_range([]).
valid_letter_range([Code|Rest]):-
	Code >= 97,
	Code =< 122,
	valid_letter_range(Rest).


int(int(N), [N | Tail], Tail) :-
	number(N).
