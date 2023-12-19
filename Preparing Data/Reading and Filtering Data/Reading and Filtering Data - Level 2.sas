* libname out "/home/wpappas/EPG194/output"; *;

data out.fox;
	set PG1.NP_SPECIES;
	where Category = "Mammal" and Common_Names like "%Fox%" and Common_Names not like "%Squirrel%";
	drop Category Record_Status Occurrence Nativeness;
run;

proc sort data = out.fox;
	by Common_Names;
run;