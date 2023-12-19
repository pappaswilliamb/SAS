libname pg1 base "/home/wpappas/EPG194/data";

* Level 2 *;

* Step a. *;
proc freq data = pg1.np_summary;
	tables Reg Type;
run;
*/ There are no invalid values for Reg.
The invalid values for Type include NPRE, PRESERVE, and RIVERWAYS. */;


* Step b. *;
proc univariate data = pg1.np_summary;
	var Acres;
run;
*/ Smallest Park: 0.35
* Largest Park: 6587071.39 */;


* Step c.*;
*/ Smallest Park: African Burial Ground National Monument
* Largest Park: Noatak National Preserve */;