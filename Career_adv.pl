run:-
	write('Hello, Please answer these questions'),nl,

	retractall(cgpa(_)),
	retractall(recommend(_)),
	retractall(mlp(_)),

	write('What was your CGPA in Mtech?'),nl,
	read(CGPA),
	assert(cgpa(CGPA)),

	write('What was your pointer in Machine Learning?'),nl,
	read(MLP),
	assert(mlp(MLP)),
	
	advice(_),
	preferences(List),nl,

	(isempty(List)
		->write('Sorry cannot recommend you anything' ),nl
		;write('Career options for you are :'),show(List)			
	),	
	clear.


advice('PhD') :- phd,fail.
advice('MBA') :- mba,fail.
advice('Job') :- job,fail.
advice('Opening up a Business') :- company,fail.
advice('Data Analyst Role') :- dataanalyst, fail.
advice('Data Scientist Role') :- datascientist,fail.
advice('Researcher Job'):- researcherJob,!.
advice('AI Researcher'):- air,!.
advice('Sorry, No Recommendation !').

preferences([Head|Tail]):- retract(recommend(Head)), preferences(Tail).
preferences([]).

show([Head|Tail]):- 
	format('~n ~w',[Head]),show(Tail).

show([]).

isempty([]).

phd :-
	retract(cgpa(A)),
	assert(cgpa(A)),
	(A > 7
		->true
		;fail
		),
	interest('Have you done Mtech Thesis ?'),
	interest('Have you done any project ?'),
	interest('Have you worked on any longer project ?'),
	assert(recommend('PhD')).

dataanalyst:-
	interest('Are you interested in Machine Learning ?'),
	retract(mlp(A)),
	assert(mlp(A)),
	(A > 7
		->true
		;fail
		),
	interest('Are you interested in Big Data ?'),
	interest('Are you good in maths ?'),
	assert(recommend('Data Analyst Role')).

datascientist:-
	retract(cgpa(A)),
	assert(cgpa(A)),
	(A > 7
		->true
		;fail
		),
	write('Have you worked on large datasets: '),
	read(Data),
	((Data == y ; Data == yes)
		->true
		;fail
		), 
	retract(mlp(B)),
	assert(mlp(B)),
	(B > 7
		->true
		;fail
		),
	interest('Are you interested in Machine Learning ?'),
	interest('Have you done any project ?'),
	interest('Are you good in maths ?'),
	assert(recommend('Data Scientist Role')).

company:-
	interest('Are you interested in business ?'),
	interest('Know something about finance ?'),
	interest('Have any business idea ?'),
	interest('Are you good at teamwork ?'),
	assert(recommend('Opening up a Business')).

air:-
	interest('Have you worked on AI systems ? '),
	write('What was your pointer in AI ?'),
	read(A),
	(A > 7
		->true
		;fail
	),
	interest('Are you interested in Machine Learning ?'),
	interest('Have you done any project ?'),
	assert(recommend('AI Researcher')).


researcherJob:-
	retract(cgpa(A)),
	assert(cgpa(A)),
	(A > 7
		->true
		;fail
		),
	write('Are you good in algorithms :'),
	read(Algo),
	((Algo == y ; Algo == yes)
		->true
		;fail
		),
	interest('Have you done any project ?'),
	interest('Are you good at teamwork ?'),
	interest('Are you good in maths ?'),
	interest('Have you worked on any longer project ?'),
	assert(recommend('Researcher Job')).

job:-
	interest('Have you done any project ?'),
	interest('Want to earn immediately ?'),
	interest('Are you good at teamwork ?'),
	assert(recommend('Job')).
	
mba:-
	interest('Are you good in english ?'),
	interest('Want to study finance ?'),
	interest('Have a good aptitide ?'),
	interest('Have you done any extra carricular activities'),
	assert(recommend('MBA')).

interest(In) :-
	(yes(In)
		->true 
		;(no(In)
			->fail 
			;ask(In))
	).

ask(Que) :-
	format('~w ?',[Que]),
	read(Ans),
	( (Ans == yes ; Ans == y)
		->assert(yes(Que)) 
		;assert(no(Que)), fail
		).

:- dynamic yes/1,no/1.


clear :- retract(yes(_)),fail.
clear :- retract(no(_)),fail.
clear.