libname pg1 base "/home/wpappas/EPG194/data";

*Challenge: Importing Data with a Specific Delimeter *;
proc import datafile = "/home/wpappas/EPG194/data/np_traffic.dat"
			dbms = dlm out = traffic2 replace;
delimiter = '|';
guessingrows = max;
run;