libname pg1 base "/home/wpappas/EPG194/data";

* Level 2: Importing Data from a CSV File*;
proc import datafile = "/home/wpappas/EPG194/data/np_traffic.csv"
			dbms = csv out = traffic replace;
guessingrows = max;
run;

proc contents data = work.traffic;
run;