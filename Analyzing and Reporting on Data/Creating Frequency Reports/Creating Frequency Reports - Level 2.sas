* libname pg1 base "/home/wpappas/EPG194/data";

* Parts a & b;

title1 "Park Types by Region";

proc freq data = pg1.np_codelookup order = freq;
	tables Type*Region / nocol;
	where Type not like "%Other%";
run;

/* The top three park types based on total frequency count are
National Historic Site, National Monument, and National Park. */


* Part c ;

title1 "Selected Park Types by Region";

ods graphics on;

proc freq data = pg1.np_codelookup order = freq;
	tables Type*Region / nocol crosslist plots = freqplot(groupby = row
           scale = grouppercent orient = horizontal);
	where Type in ("National Historic Site", "National Monument",
          "National Park");
run;
title;
