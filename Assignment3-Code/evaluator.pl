
:- [parser2].

evaluate(ParseTree, In, Eval):-
	interpret(ParseTree, Eval, VariablesIn, VariablesOut).

interpret(assign(Id, Op, Expr, End), [Id, Eval]) --> 
	interpret(Id),
	[=],
	%interpret(Op),
	interpret(Expr, Eval),
	[;].
	%interpret(End).

interpret(opAssign(Op)) --> [Op].
interpret(assignEnd(Op)) --> [Op].
interpret(exprOperator(Op)) --> [Op].
interpret(termOperator(Op)) --> [Op].
interpret(leftParen(Op)) --> [Op].
interpret(rightParen(Op)) --> [Op].

interpret(expr(Term), Eval) --> interpret(Term, Eval).

interpret(expr(Term, Op, Expr), Eval) --> 
	interpret(Term, Val1),
	interpret(add_op(Op)),
	%[+],
	interpret(Expr, Val2),
	{Eval is Val1 + Val2}.

interpret(expr(Term, Op, Expr), Eval) --> 
	interpret(Term, Val1),
	interpret(sub_op(Op)),
	%[-],
	interpret(Expr, Val2),
	{Eval is Val1 - Val2}.

interpret(term(Factor), Eval) --> interpret(Factor, Eval).

interpret(term(Factor, Op, Term), Eval) --> 
	interpret(Factor, Val1),
	interpret(mult_op(Op)),
	%[*],
	interpret(Term, Val2),
	{Eval is Val1 * Val2}.

interpret(term(Factor, Op, Term), Eval) --> 
	interpret(Factor, Val1),
	interpret(div_op(Op)),
	%[/],
	interpret(Term, Val2),
	{Eval is Val1 / Val2}.

interpret(factor(T), T) --> 
	%interpret(T).
	[T],
	{number(T)}.

interpret(int(I), I) --> 
	[I],
	{number(I)}.

interpret(factor(LP, Expr, RP), Eval) -->
	['('],
	%interpret(LP),
	interpret(Expr, Eval),
	%interpret(RP).
	[')'].

interpret(ident(Id)) -->
	[Id].
	
interpret(sub_op(SUB)) -->
	[SUB].
	
interpret(add_op(ADD)) -->
	[ADD].
	
interpret(div_op(DIV)) -->
	[DIV].

interpret(mult_op(MULT)) -->
	[MULT].
