% Author: Steven Jiang
% Date: 11/11/2019
% Prolog Semester Homework Assignment

% medical_test(+PatientData, -ProbDPos1, -ProbDPos2, -ProbHNeg1, -ProbHNeg2, -Best)
% PatientData is a nonempty list of 4-element lists [PatientNum, HasDisease, PosOnTest1, PosOnTest2], where
  % PatientNum is the current patient number
  % HasDisease is 1 if the patient has the disease, else 0
  % PosOnTest1 is 1 if the patient patient tested positive on test 1, else 0
  % PosOnTest2 is 1 if the patient patient tested positive on test 2, else 0
% ProbDPos1 is P(D | Pos1)
% ProbDPos2 is P(D | Pos2)
% ProbHNeg1 is P(H | Neg1)
% ProbHNeg2 is P(H | Neg2)
% Best is one of {test1, test2, neither}, indicating which test is better.


medical_test(PatientData, ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Best) :-
  % Probability of P(D | Pos1)
  second_third_both1s(PatientData, A),
  count1s_third(PatientData, B),
  ProbDPos1 is A / B,
  
  % Probability of P(D | Pos2)
  second_fourth_both1s(PatientData, C),
  count1s_fourth(PatientData, D),
  ProbDPos2 is C / D,

  % Probability of P(H | Neg1)
  second_third_both0s(PatientData, E),
  count0s_third(PatientData, F),
  ProbHNeg1 is E / F,
  
  % Probability of P(H | Neg2)
  second_fourth_both0s(PatientData, G),
  count0s_fourth(PatientData, H),
  ProbHNeg2 is G / H,

  better_test(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Result),
  Best = Result.
  


% better_test(+L, -Best)
% Best is one of {test1, test2, neither}, indicating which test is better.

better_test(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Best) :-  
  ProbDPos1 > ProbDPos2,
  ProbHNeg1 > ProbHNeg2,
  
  Best = test1.
  
better_test(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Best) :-  
  ProbDPos1 < ProbDPos2,
  ProbHNeg1 < ProbHNeg2,
  
  Best = test2.
  
better_test(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Best) :-  
  ProbDPos1 >= ProbDPos2,
  ProbHNeg1 =< ProbHNeg2,
  
  Best = neither.
  
better_test(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Best) :-  
  ProbDPos1 =< ProbDPos2,
  ProbHNeg1 >= ProbHNeg2,
  
  Best = neither.
  


% second_third_both1s(+L, -Sum)
% Sum is the total occurrences of both HasDisease and PosOnTest1 being 1's.

second_third_both1s([ ], 0).
second_third_both1s([ [ _ , X , X , _ ] | T ], Sum) :-
  X = 1,
  second_third_both1s(T, TSum),
  Sum is 1 + TSum.
second_third_both1s([ [ _ , _ , _ , _ ] | T ], Sum) :-
  second_third_both1s(T, Sum).



% second_fourth_both1s(+L, -Sum)
% Sum is the total occurrences of both HasDisease and PosOnTest2 being 1's.

second_fourth_both1s([ ], 0).
second_fourth_both1s([ [ _ , X , _ , X ] | T ], Sum) :-
  X = 1,
  second_fourth_both1s(T, TSum),
  Sum is 1 + TSum.
second_fourth_both1s([ [ _ , _ , _ , _ ] | T ], Sum) :-
  second_fourth_both1s(T, Sum).



% second_third_both0s(+L, -Sum)
% Sum is the total occurrences of both HasDisease and PosOnTest1 being 0's.

second_third_both0s([ ], 0).
second_third_both0s([ [ _ , X , X , _ ] | T ], Sum) :-
  X = 0,
  second_third_both0s(T, TSum),
  Sum is 1 + TSum.
second_third_both0s([ [ _ , _ , _ , _ ] | T ], Sum) :-
  second_third_both0s(T, Sum).



% second_fourth_both0s(+L, -Sum)
% Sum is the total occurrences of both HasDisease and PosOnTest2 being 0's.

second_fourth_both0s([ ], 0).
second_fourth_both0s([ [ _ , X , _ , X ] | T ], Sum) :-
  X = 0,
  second_fourth_both0s(T, TSum),
  Sum is 1 + TSum.
second_fourth_both0s([ [ _ , _ , _ , _ ] | T ], Sum) :-
  second_fourth_both0s(T, Sum).



% count1s_third(+L, -Sum)
% Sum is total occurrences of 1s in Test1 column.

count1s_third([ ], 0).
count1s_third([ [ _ , _ , C , _ ] | T ], Sum) :- 
	C = 1,
	count1s_third(T, TSum),
	Sum is 1 + TSum.
count1s_third([ [ _ , _ , _ , _ ] | T ], Sum) :-
	count1s_third(T, Sum).



% count1s_fourth(+L, -Sum)
% Sum is the total occurrences of 1s in Test2 column.

count1s_fourth([ ], 0).
count1s_fourth([ [ _ , _ , _ , C ] | T ], Sum) :-
	C = 1,
	count1s_fourth(T, TSum),
	Sum is 1 + TSum.
count1s_fourth([ [ _ , _ , _ , _ ] | T ], Sum) :-
	count1s_fourth(T, Sum).



% count0s_third(+L, -Sum)
% Sum is total occurrences of 0s in Test1 column.

count0s_third([ ], 0).
count0s_third([ [ _ , _ , C , _ ] | T ], Sum) :-
  C = 0,
  count0s_third(T, TSum),
  Sum is 1 + TSum.
count0s_third([ [ _ , _ , _  , _ ] | T ], Sum) :-
  count0s_third(T, Sum).



% count0s_fourth(+L, -Sum)
% Sum is the total occurrences of 0s in Test2 column.

count0s_fourth([ ], 0).
count0s_fourth([ [ _ , _ , _ , C ] | T ], Sum) :-
  C = 0,
  count0s_fourth(T, TSum),
  Sum is 1 + TSum.
count0s_fourth([ [ _ , _ , _ , _ ] | T ], Sum) :-
  count0s_fourth(T, Sum).
