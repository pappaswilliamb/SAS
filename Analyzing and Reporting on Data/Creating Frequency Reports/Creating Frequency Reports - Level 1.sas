* libname pg1 base "/home/wpappas/EPG194/data";

* Part a;

title1 "Categories of Reported Species";

proc freq data = pg1.np_species order = freq;
	tables Category / nocum;
run;



* Part b;

ods graphics on;
ods noproctitle;

title1 "Categories of Reported Species";
title2 "in the Everglades";

proc freq data = pg1.np_species order = freq;
	tables Category / nocum plots = freqplot;
	where Species_ID like "EVER%" and Category ^= "Vascular Plant";
run;
title;
ods proctitle;