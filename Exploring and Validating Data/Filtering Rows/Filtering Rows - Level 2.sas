libname pg1 base "/home/wpappas/EPG194/data";

* Step a. *;

proc freq data = pg1.np_species;
	tables Abundance Conservation_Status;
	where Species_ID like 'YOSE%' and Category = 'Mammal';
run;


* Step b. *;

proc print data = pg1.np_species;
	var Species_ID Category Scientific_Name Common_Names;
	where Species_ID like 'YOSE%' and Category = 'Mammal';
run;


* Step c. *;

%let ParkCode = YOSE;
%let SpeciesCat = Mammal;

proc freq data = pg1.np_species;
	tables Abundance Conservation_Status;
	where Species_ID like "&ParkCode%" and Category = "&SpeciesCat";
run;

proc print data = pg1.np_species;
	var Species_ID Category Scientific_Name Common_Names;
	where Species_ID like "&ParkCode%" and Category = "&SpeciesCat";
run;


* Step d. *;

%let ParkCode = ZION;
%let SpeciesCat = Bird;

proc freq data = pg1.np_species;
	tables Abundance Conservation_Status;
	where Species_ID like "&ParkCode%" and Category = "&SpeciesCat";
run;

proc print data = pg1.np_species;
	var Species_ID Category Scientific_Name Common_Names;
	where Species_ID like "&ParkCode%" and Category = "&SpeciesCat";
run;