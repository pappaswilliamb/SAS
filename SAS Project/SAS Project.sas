* Create the Library;
LIBNAME SAS_PROJ BASE "/home/wpappas/DSA 8030/SAS Project";


* Import the CSV Files;
PROC IMPORT DATAFILE="/home/wpappas/DSA 8030/SAS Project/driver.csv" 
			DBMS=CSV OUT=SAS_PROJ.DRIVER REPLACE;
RUN;

PROC IMPORT DATAFILE="/home/wpappas/DSA 8030/SAS Project/manufacturer.csv" 
			DBMS=CSV OUT=SAS_PROJ.MANUFACTURER REPLACE;
RUN;

PROC IMPORT DATAFILE="/home/wpappas/DSA 8030/SAS Project/points.csv" 
			DBMS=CSV OUT=SAS_PROJ.POINTS REPLACE;
RUN;

PROC IMPORT DATAFILE="/home/wpappas/DSA 8030/SAS Project/race.csv" 
			DBMS=CSV OUT=SAS_PROJ.RACE REPLACE;
RUN;

PROC IMPORT DATAFILE="/home/wpappas/DSA 8030/SAS Project/sponsor.csv" 
			DBMS=CSV OUT=SAS_PROJ.SPONSOR REPLACE;
RUN;

PROC IMPORT DATAFILE="/home/wpappas/DSA 8030/SAS Project/team.csv" 
			DBMS=CSV OUT=SAS_PROJ.TEAM REPLACE;
RUN;


* Data Importation and Tidying;

* WATKINS_GLEN;
PROC SQL;
CREATE TABLE SAS_PROJ.WATKINS_GLEN AS
SELECT
		 RACE.car_number
		,DRIVER.driver
		,MANUFACTURER.manufacturer
		,TEAM.team
		,SPONSOR.sponsor
		,RACE.start
		,RACE.finish
		,POINTS.points
		,RACE.lap
		,RACE.lap_time
		,RACE.lap_speed
		,RACE.running_position
FROM SAS_PROJ.RACE AS RACE
LEFT JOIN SAS_PROJ.TEAM AS TEAM
	ON RACE.car_number = TEAM.car_number
LEFT JOIN SAS_PROJ.SPONSOR AS SPONSOR
	ON RACE.car_number = SPONSOR.car_number
LEFT JOIN SAS_PROJ.POINTS AS POINTS
	ON RACE.car_number = POINTS.car_number
LEFT JOIN SAS_PROJ.MANUFACTURER AS MANUFACTURER
	ON RACE.car_number = MANUFACTURER.car_number
LEFT JOIN SAS_PROJ.DRIVER AS DRIVER
	ON RACE.car_number = DRIVER.car_number
ORDER BY RACE.finish, RACE.lap;
QUIT;

* CORRELATION_DATA;
PROC MEANS DATA = SAS_PROJ.WATKINS_GLEN NOPRINT;
	VAR lap_speed;
	CLASS driver;
	OUTPUT OUT = SAS_PROJ.DRIVER_SPEED MEAN = Average_Speed;
RUN;

PROC MEANS DATA = SAS_PROJ.WATKINS_GLEN NOPRINT;
	VAR running_position;
	CLASS driver;
	OUTPUT OUT = SAS_PROJ.AVERAGE_RUNNING_POSITION MEAN = Average_Running_Position;
RUN;

PROC MEANS DATA = SAS_PROJ.WATKINS_GLEN NOPRINT;
	VAR points;
	CLASS driver;
	OUTPUT OUT = SAS_PROJ.DRIVER_POINTS MEAN = Points;
RUN;

PROC MEANS DATA = SAS_PROJ.WATKINS_GLEN NOPRINT;
	VAR start;
	CLASS driver;
	OUTPUT OUT = SAS_PROJ.DRIVER_START MEAN = Start;
RUN;

PROC MEANS DATA = SAS_PROJ.WATKINS_GLEN NOPRINT;
	VAR finish;
	CLASS driver;
	OUTPUT OUT = SAS_PROJ.DRIVER_FINISH MEAN = Finish;
RUN;

PROC SQL;
CREATE TABLE SAS_PROJ.CORRELATION_DATA AS
SELECT
		 SPEED.driver
		,SPEED.Average_Speed
		,POINTS.Points
		,START.Start
		,FINISH.Finish
		,RUNNING_POSITION.Average_Running_Position
FROM SAS_PROJ.DRIVER_SPEED AS SPEED
INNER JOIN SAS_PROJ.DRIVER_POINTS AS POINTS
	ON SPEED.driver = POINTS.driver
INNER JOIN SAS_PROJ.DRIVER_START AS START
	ON SPEED.driver = START.driver
INNER JOIN SAS_PROJ.DRIVER_FINISH AS FINISH
	ON SPEED.driver = FINISH.driver
INNER JOIN SAS_PROJ.AVERAGE_RUNNING_POSITION AS RUNNING_POSITION
	ON SPEED.driver = RUNNING_POSITION.driver
WHERE SPEED._FREQ_ <> 3330;
QUIT;


* Summary Statistics;
PROC UNIVARIATE DATA = SAS_PROJ.WATKINS_GLEN;
RUN;


* Box Plots;
PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HBOX car_number;
	TITLE 'Distribution of Car Number';
	LABEL car_number = 'Car Numbers';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HBOX start;
	TITLE 'Distribution of Starting Position';
	LABEL start = 'Starting Position';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HBOX finish;
	TITLE 'Distribution of Finishing Position';
	LABEL finish = 'Finishing Position';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HBOX points;
	TITLE 'Distribution of Points Earned';
	LABEL points = 'Points';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HBOX lap;
	TITLE 'Distribution of Laps';
	LABEL lap = 'Lap Number';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HBOX lap_time;
	TITLE 'Distribution of Lap Times';
	LABEL lap_time = 'Lap Time (in seconds)';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HBOX lap_speed;
	TITLE 'Distribution of Lap Speeds';
	LABEL lap_speed = 'Lap Speed (mph)';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HBOX running_position;
	TITLE 'Distribution of Running Position';
	LABEL running_position = 'Running Position';
RUN;


* Histograms;
PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HISTOGRAM car_number / SCALE = COUNT BINWIDTH = 10 NBINS = 10;
	TITLE 'Distribution of Car Number';
	LABEL car_number = 'Car Numbers';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HISTOGRAM start / SCALE = COUNT BINWIDTH = 2 NBINS = 19;
	TITLE 'Distribution of Starting Position';
	LABEL start = 'Starting Position';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HISTOGRAM finish / SCALE = COUNT BINWIDTH = 2 NBINS = 19;
	TITLE 'Distribution of Finishing Position';
	LABEL finish = 'Finishing Position';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HISTOGRAM points / SCALE = COUNT BINWIDTH = 5 NBINS = 12;
	TITLE 'Distribution of Points Earned';
	LABEL points = 'Points';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HISTOGRAM lap / SCALE = COUNT BINWIDTH = 5 NBINS = 18;
	TITLE 'Distribution of Laps';
	LABEL lap = 'Lap Number';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HISTOGRAM lap_time / SCALE = COUNT;
	TITLE 'Distribution of Lap Times';
	LABEL lap_time = 'Lap Time (in seconds)';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HISTOGRAM lap_speed / SCALE = COUNT;
	TITLE 'Distribution of Lap Speeds';
	LABEL lap_speed = 'Lap Speed (mph)';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HISTOGRAM running_position / SCALE = COUNT BINWIDTH = 2 NBINS = 19;
	TITLE 'Distribution of Running Position';
	LABEL running_position = 'Running Position';
RUN;


* Bar Charts;
PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HBAR manufacturer / STAT = PERCENT;
	TITLE 'Distribution of Manufacturers';
	LABEL manufacturer = 'Manufacturer';
RUN;

PROC SGPLOT DATA = SAS_PROJ.WATKINS_GLEN;
	HBAR team / CATEGORYORDER = RESPDESC STAT = PERCENT;
	TITLE 'Distribution of Teams';
	LABEL team = 'Team';
RUN;


* Correlations;
PROC CORR DATA = SAS_PROJ.CORRELATION_DATA;
	VAR Start Finish;
	TITLE 'Start vs. Finish';
RUN;

PROC CORR DATA = SAS_PROJ.CORRELATION_DATA;
	VAR Start Points;
	TITLE 'Start vs. Points';
RUN;

PROC CORR DATA = SAS_PROJ.CORRELATION_DATA;
	VAR Average_Speed Points;
	TITLE 'Average Speed vs. Points';
RUN;

PROC CORR DATA = SAS_PROJ.CORRELATION_DATA;
	VAR Average_Speed Finish;
	TITLE 'Average Speed vs. Finish';
RUN;

PROC CORR DATA = SAS_PROJ.CORRELATION_DATA;
	VAR Average_Running_Position Finish;
	TITLE 'Average Running Position vs. Finish';
RUN;

PROC CORR DATA = SAS_PROJ.CORRELATION_DATA;
	VAR Average_Running_Position Points;
	TITLE 'Average Running Position vs. Points';
RUN;


* Linear Models;
PROC REG DATA = SAS_PROJ.CORRELATION_DATA;
	MODEL Finish = Start;
	TITLE 'Start vs. Finish';
RUN;

PROC REG DATA = SAS_PROJ.CORRELATION_DATA;
	MODEL Points = Start;
	TITLE 'Start vs. Points';
RUN;

PROC REG DATA = SAS_PROJ.CORRELATION_DATA;
	MODEL Points = Average_Speed;
	TITLE 'Average Speed vs. Points';
RUN;

PROC REG DATA = SAS_PROJ.CORRELATION_DATA;
	MODEL Finish = Average_Speed;
	TITLE 'Average Speed vs. Finish';
RUN;

PROC REG DATA = SAS_PROJ.CORRELATION_DATA;
	MODEL Finish = Average_Running_Position;
	TITLE 'Average Running Position vs. Finish';
RUN;

PROC REG DATA = SAS_PROJ.CORRELATION_DATA;
	MODEL Points = Average_Running_Position;
	TITLE 'Average Running Position vs. Points';
RUN;


* Scatter Plots;
PROC SGPLOT DATA = SAS_PROJ.CORRELATION_DATA NOAUTOLEGEND;
	REG X = Start Y = Finish;
	TITLE 'Starting Position vs. Finishing Position';
	LABEL Start = 'Starting Position'
		  Finish = 'Finishing Position';
RUN;

PROC SGPLOT DATA = SAS_PROJ.CORRELATION_DATA NOAUTOLEGEND;
	REG X = Start Y = Points;
	TITLE 'Starting Position vs. Points Earned';
	LABEL Start = 'Starting Position'
		  Points = 'Points Earned';
RUN;

PROC SGPLOT DATA = SAS_PROJ.CORRELATION_DATA NOAUTOLEGEND;
	REG X = Average_Speed Y = Points;
	TITLE 'Average Speed vs. Points Earned';
	LABEL Average_Speed = 'Average Speed (mph)'
		  Points = 'Points Earned';
RUN;

PROC SGPLOT DATA = SAS_PROJ.CORRELATION_DATA NOAUTOLEGEND;
	REG X = Finish Y = Average_Speed;
	TITLE 'Average Speed vs. Finishing Position';
	LABEL Finish = 'Finishing Position'
		  Average_Speed = 'Average Speed (mph)';
RUN;

PROC SGPLOT DATA = SAS_PROJ.CORRELATION_DATA NOAUTOLEGEND;
	REG X = Average_Running_Position Y = Finish;
	TITLE 'Average Running Position vs. Finishing Position';
	LABEL Average_Running_Position = 'Average Running Position'
		  Finish = 'Finishing Position';
RUN;

PROC SGPLOT DATA = SAS_PROJ.CORRELATION_DATA NOAUTOLEGEND;
	REG X = Average_Running_Position Y = Points;
	TITLE 'Average Running Position vs. Points Earned';
	LABEL Average_Running_Position = 'Average Running Position'
		  Points = 'Points Earned';
RUN;