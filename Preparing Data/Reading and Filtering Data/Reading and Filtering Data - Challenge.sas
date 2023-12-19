* Step a. *;

data Mammal;
	set PG1.NP_SPECIES;
	where Category = "Mammal";
	drop Abundance Seasonality Conservation_Status;
run;



* Step b. *;

proc freq data = Mammal;
	tables Record_Status;
run;

* There are 3489 approved species and 378 species in review. *;



* Step c. *;
%let Species = Bird;

data Mammal;
	set PG1.NP_SPECIES;
	where Category = "&Species";
	drop Abundance Seasonality Conservation_Status;
run;

proc freq data = Mammal;
	tables Record_Status;
run;