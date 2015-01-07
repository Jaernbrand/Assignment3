
:- [parser2].

evaluate(ParseTree, In, Eval):-
	interpret(ParseTree, Eval, VariablesIn, VariablesOut).

interpret(assignment(Id, Op, Expr, End), [IdName, Eval | []]) --> 
	interpret(Id, IdName),
	[=],
	interpret(Expr, Eval),
	[;].

interpret(expression(Term), Eval) --> interpret(Term, Eval).

interpret(expression(Term, Op, Expr), Eval) --> 
	interpret(Term, Val1),
	interpret_add(Op),
	interpret(Expr, Val2),
	{Eval is Val1 + Val2}.

interpret(expression(Term, Op, Expr), Eval) --> 
	interpret(Term, Val1),
	interpret_sub(Op),
	interpret(Expr, Val2),
	{Eval is Val1 - Val2}.

interpret(term(Factor), Eval) --> interpret(Factor, Eval).

interpret(term(Factor, Op, Term), Eval) --> 
	interpret(Factor, Val1),
	interpret_mult(Op),
	interpret(Term, Val2),
	{Eval is Val1 * Val2}.

interpret(term(Factor, Op, Term), Eval) --> 
	interpret(Factor, Val1),
	interpret_div(Op),
	interpret(Term, Val2),
	{Eval is Val1 / Val2}.

interpret(factor(T), Eval) --> 
	interpret(T, Eval).

interpret(int(I), I) --> 
	[I],
	{number(I)}.

interpret(factor(LP, Expr, RP), Eval) -->
	['('],
	interpret(Expr, Eval),
	[')'].

interpret(ident(Id), Id) -->
	[Id].
	
interpret_sub(sub_op) -->
	[-].
	
interpret_add(add_op) -->
	[+].
	
interpret_div(div_op) -->
	[/].

interpret_mult(mult_op) -->
	[*].

interpret_lp(left_paren(P)) -->
	['('].

interpret_rp(right_paren(P)) -->
	[')'].