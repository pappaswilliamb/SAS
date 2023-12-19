libname pg1 base "/home/wpappas/EPG194/data";

* Step a. *;

proc univariate data = pg1.eu_occ;
	var Camp;
run;


* Step b. *;
ods trace on;
proc univariate data = pg1.eu_occ;
	var Camp;
run;
ods trace off;


* Step c. *;
* Extreme Observations Output Object: "ExtremeObs". *;


* Step d. *;
ods select ExtremeObs;
proc univariate data = pg1.eu_occ;
	var Camp;
run;


* Step e. *;
ods select ExtremeObs;
proc univariate data = pg1.eu_occ nextrobs=10;
	var camp;
run;
