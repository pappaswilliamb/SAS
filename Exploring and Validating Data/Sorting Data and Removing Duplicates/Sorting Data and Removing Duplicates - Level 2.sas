libname pg1 base "/home/wpappas/EPG194/data";


* Step a. *;
* Table opened *;


* Step b. *;

proc sort data = pg1.np_largeparks
		out = park_clean
		noduprecs
		dupout = park_dups;
	by _all_;
run;