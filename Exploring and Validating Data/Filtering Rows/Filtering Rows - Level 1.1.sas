***********************************************************;
*  LESSON 3, PRACTICE 4                                   *;
*  a) Add a WHERE statement to print only the rows where  *;
*     ParkName includes Preserve.                         *;
*  b) Submit the program and verify the generated output. *;
*     Which codes are used for Preserves?                 *;
***********************************************************;

libname pg1 base "/home/wpappas/EPG194/data";

* Step a. *;

proc print data=pg1.np_summary;
	var Type ParkName;
	*Add a WHERE statement;
	where ParkName like '%Preserve';
run;


* Step b. *;
* PRE, PRESERVE, and NPRE are the codes used for preserves *;