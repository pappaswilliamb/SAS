libname pg1 base "/home/wpappas/EPG194/data";


* Step a, b, and c *;

proc sort data = pg1.eu_occ (KEEP = Geo Country)
		out = countrylist
		nodupkey;
	by Geo Country;
run;