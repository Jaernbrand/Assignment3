
:- [parser2].

evaluate(ParseTree, In, Eval):-
	interpret(ParseTree, Eval, VariablesIn, VariablesOut).

interpret(assign(Id, Op, Expr, End), [IdName, Eval | []]) --> 
	interpret(Id, IdName),
	interpret_assign_op(Op),
	interpret(Expr, Eval),
	interpret_semicolon(End).

interpret(expr(Term), Eval) --> interpret(Term, Eval).

interpret(expr(Term, Op, Expr), Eval) --> 
	interpret(Term, Val1),
	interpret_add(Op),
	interpret(Expr, Val2),
	{Eval is Val1 + Val2}.

interpret(expr(Term, Op, Expr), Eval) --> 
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

interpret(factor(T), T) --> 
	%interpret(T).
	[T],
	{number(T)}.

interpret(int(I), I) --> 
	[I],
	{number(I)}.

interpret(factor(LP, Expr, RP), Eval) -->
	interpret_lp(LP),
	interpret(Expr, Eval),
	interpret_rp(RP).

interpret(ident(Id), Id) -->
	[Id].

interpret_assign_op(assign_op(Op)) -->
	[Op].

interpret_semicolon(semicolon(Semi)) -->
	[Semi].
	
interpret_sub(sub_op(SUB)) -->
	[SUB].
	
interpret_add(add_op(ADD)) -->
	[ADD].
	
interpret_div(div_op(DIV)) -->
	[DIV].

interpret_mult(mult_op(MULT)) -->
	[MULT].

interpret_lp(left_paren(P)) -->
	['('].

interpret_rp(right_paren(P)) -->
	[')'].

