* libname pg1 base "/home/wpappas/EPG194/data" *;

data eu_occ_total;
	set pg1.eu_occ;
	Year = substr(YearMon, 1, 4);
	Month = substr(YearMon, 6, 2);
	ReportDate = mdy(Month, 1, Year);
	Total = sum(Hotel, ShortStay, Camp);
	format Hotel ShortStay Camp Total COMMA17. ReportDate MONYY7.;
	keep Country Hotel ShortStay Camp ReportDate Total;
run;