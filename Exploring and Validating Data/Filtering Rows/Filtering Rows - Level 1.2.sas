libname pg1 base "/home/wpappas/EPG194/data";

* Step a.*;

proc print data = pg1.eu_occ;
	*Add a WHERE statement;
	where Hotel is missing and ShortStay is missing and Camp is missing;
run;
* There are 101 rows for which Hotel, ShortStay, and Camp are missing *;


* Step b. *;

proc print data = pg1.eu_occ;
	*Add a WHERE statement;
	where Hotel > 40000000;
run;
* July ad August are the months included in the report *;

