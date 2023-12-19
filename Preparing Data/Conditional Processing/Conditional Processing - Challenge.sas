* libname pg1 base "/home/wpappas/EPG194/data";

data parks monuments;
	set pg1.np_summary;
 	where Type in ('NM', 'NP');
 	Campers = sum(OtherCamping, TentCampers, RVCampers, BackcountryCampers);
 	format Campers COMMA17.;
 	length ParkType $ 8;
 	select (Type);
		when ('NP') do;
 			ParkType = 'Park';
 			output parks;
 		end;

 		otherwise do;
 			ParkType = 'Monument';
 			output monuments;
 		end;
	end;
 	keep Reg ParkName DayVisits OtherLodging Campers ParkType;
run;