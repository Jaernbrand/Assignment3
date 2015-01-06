
evaluate(ParseTree, VariablesIn, ToCalculate/*Evaluation*/):-
	traverseTree(ParseTree, [], ToCalculate)/*,
	calculate(ToCalculate, Evaluation)*/.

traverseTree(Term, CalcIn, [Term | CalcIn]) :-
	functor(Term, Name, 0).

traverseTree(Term, CalcIn, CalcOut) :-
	functor(Term, Name, Arity),
	Arity > 0,
	visitChildren(Term, 1, Arity, CalcIn, CalcOut).
	
visitChildren(Term, I, I, CalcIn, CalcOut):-
	arg(ArgIndex, Term, ArgOut),
	traverseTree(ArgOut, CalcIn, CalcOut).

visitChildren(Term, ArgIndex, Arity, CalcIn, CalcOut) :-
	arg(ArgIndex, Term, ArgOut),
	traverseTree(ArgOut, CalcIn, CalcList),
	NextIndex is ArgIndex + 1,
	visitChildren(Term, NextIndex, Arity, CalcList, CalcOut).
