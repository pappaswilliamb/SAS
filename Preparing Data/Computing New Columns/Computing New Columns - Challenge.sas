* libname pg1 base "/home/wpappas/EPG194/data" *;

data np_summary2;
	set pg1.np_summary;
	ParkType = scan(ParkName, -1);
	keep Reg Type ParkName ParkType;
run;