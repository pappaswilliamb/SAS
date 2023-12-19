libname pg1 base "/home/wpappas/EPG194/data";

* Step a. *;
* Table opened *;


* Step b. *;

proc print data = pg1.np_traffic;
	var ParkName Location Count;
	where Count ^= 0 and Location like '%MAIN ENTRANCE%';
run;


* Step c. *;

proc print data = pg1.np_traffic;
	var ParkName Location Count;
	where Count ^= 0 and UPCASE(Location) like '%MAIN ENTRANCE%';
run;