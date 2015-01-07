
evaluate(ParseTree, VariablesIn, ToCalculate/*Evaluation*/):-
	interpret(ParseTree, VariablesIn, ToCalculate)/*,
	calculate(ToCalculate, Evaluation)*/.

interpret(assign(Id, Op, Expr, End)) --> 
	interpret(Id)/*,
	[=],
	interpret(Expr),
	[;]*/.

interpret(expr(Term)) --> interpret(Term).

interpret(expr(Term, Op, Expr)) --> 
	interpret(Term),
	[+],
	interpret(Expr).

interpret(expr(Term, Op, Expr)) --> 
	interpret(Term),
	[-],
	interpret(Expr).

interpret(term(Factor)) --> interpret(Facor).

interpret(term(Factor, Op, Term)) --> 
	interpret(Factor),
	[*],
	interpret(Term).

interpret(term(Factor, Op, Term)) --> 
	interpret(Factor),
	[/],
	interpret(Term).

interpret(factor(T)) --> 
	[T],
	{number(T)}.

interpret(factor(LP, Expr, RP)) -->
	['('],
	interpret(Expr),
	[')'].

interpret(id(Id)) -->
	[Id].
