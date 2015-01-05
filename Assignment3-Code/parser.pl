
parse(Tree, Lexemes, VariablesOut) :- assign(Tree, Lexemes, VariablesOut).

assign(Tree, Lexemes, VariablesOut) :- 
	id(Tree, Lexemes), 
	eq(Tree, Lexemes), 
	expr(Tree, Lexemes, VariablesOut), 
	assignEnd(Tree, Lexemes).

assignToken(Tree, [L | Lexemes]) :- L '='.
assignEnd(Tree, [L | Lexemes]) :- L ';'.

expr(Tree, Lexemes, VariablesOut) :- term(Tree, Lexemes)
	term(Tree, Lexemes).

expr(Tree, Lexemes, VariablesOut) :- term(Tree, Lexemes)
	term(Tree, Lexemes),
	exprOperator(Tree, Lexemes),
	expr(Tree, Lexemes).

exprOperator(Tree, [L | Lexemes]) :- L '+'.
exprOperator(Tree, [L | Lexemes]) :- L '-'.

term(Tree, Lexemes) :- factor(Tree, Lexemes) :-
	factor(Tree, Lexemes).

term(Tree, Lexemes) :- factor(Tree, Lexemes) :-
	factor(Tree, Lexemes),
	termOperator(Tree, Lexemes),
	term(Tree, Lexemes).

termOperator(Tree, [L | Lexemes]) :- L '*'.
termOperator(Tree, [L | Lexemes]) :- L '/'.

factor(Tree, Lexemes) :- id(Tree, Lexemes).
factor(Tree, Lexemes) :- 
	leftParen(Lexemes),  
	expr(Tree, Lexemes), 
	rightParen(Lexemes).

leftParen(Tree, [L | Lexemes]) :- L '('.
rightParen(Tree, [L | Lexemes]) :- L ')'.

id(Tree, [L | Lexemes]) :- L 'a-z'.
int(Tree, [L | Lexemes]) :- L '0-9'.

