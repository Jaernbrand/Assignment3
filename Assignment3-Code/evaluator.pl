
evaluate(ParseTree, VariablesIn, Evaluation):-
	traverseTree(ParseTree, [], ToCalculate),
	calculate(ToCalculate, Evaluation).

traverseTree(Term, CalcIn, [Term | CalcIn]) :-
	functor(ParseTree, Name, 0).

traverseTree(Term, CalcIn, CalcOut) :-
	functor(Term, Name, Arity),
	visitChildren(Term, Arity, CalcIn, CalcOut).
	
visitChildren(Term, I, I, CalcIn, CalcOut):-
	traverseTree().

visitChildren(Term, ArgIndex, Arity, CalcIn, CalcOut) :-
	arg(ArgIndex, Term, ArgOut),
	traverseTree(ArgOut, CalcIn, CalcList),
	visitChildren(Term, , Arity, CalcList, CalcOut).
