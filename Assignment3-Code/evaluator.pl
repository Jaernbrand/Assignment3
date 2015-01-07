
:- [parser2].

evaluate(ParseTree, ToCalculate, VariablesIn /*Evaluation*/):-
	interpret(ParseTree, VariablesIn, ToCalculate)/*,
	calculate(ToCalculate, Evaluation)*/.

interpret(assign(Id, Op, Expr, End)) --> 
	interpret(Id),
	%[=],
	interpret(Op)%,
	%interpret(Expr),
	%[;].
	/*interpret(End)*/.

interpret(opAssign(Op)) --> [Op].
interpret(assignEnd(Op)) --> [Op].
interpret(exprOperator(Op)) --> [Op].
interpret(termOperator(Op)) --> [Op].
interpret(leftParen(Op)) --> [Op].
interpret(rightParen(Op)) --> [Op].

interpret(expr(Term)) --> interpret(Term).

interpret(expr(Term, Op, Expr)) --> 
	interpret(Term),
	%[+],
	interpret(Op),
	interpret(Expr).
/*
interpret(expr(Term, Op, Expr)) --> 
	interpret(Term),
	[-],
	interpret(Expr).
*/
interpret(term(Factor)) --> interpret(Factor).

interpret(term(Factor, Op, Term)) --> 
	interpret(Factor),
	%[*],
	interpret(Op),
	interpret(Term).
/*
interpret(term(Factor, Op, Term)) --> 
	interpret(Factor),
	[/],
	interpret(Term).
*/
interpret(factor(T)) --> 
	interpret(T).
	%[T],
	%{number(T)}.

interpret(int(I)) --> 
	[I],
	{number(I)}.

interpret(factor(LP, Expr, RP)) -->
	%['('],
	interpret(LP),
	interpret(Expr),
	interpret(RP).
	%[')'].

interpret(ident(Id)) -->
	[Id].
