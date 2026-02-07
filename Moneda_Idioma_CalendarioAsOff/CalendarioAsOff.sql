// ===============================
// VARIABLES DE DATA
// ===============================
LET vMinFecha = MAKEDATE(2023, 1, 1);   // Data inici
LET vMaxFecha = TODAY();               // Avui

LET vNMinFecha = NUM('$(vMinFecha)');
LET vNMaxFecha = NUM('$(vMaxFecha)');


TRACE >>>>>>>>>>>>>>>> $(vNMinFecha) <<<<<<<<<<<<<<<;
TRACE >>>>>>>>>>>>>>>> $(vNMaxFecha) <<<<<<<<<<<<<<<;

// ===============================
// CALENDARI
// ===============================
Calendario:
LOAD
    Date(vDate, 'DD/MM/YYYY')              								as Fecha,
    Year(vDate)                           								as Any,
    Month(vDate)                          								as Mes,
    MonthName(vDate)                     								as MesAny,
    Num(Month(vDate))                    								as NumMes,
    Day(vDate)                            								as Dia,
    Week(vDate)                           								as Setmana,
    WeekYear(vDate)                      								as AnySetmana,
    WeekDay(vDate)                       								as NomDia,
    Dual(WeekDay(vDate), WeekDay(vDate)) 								as NumDiasetmana,
    NUM(year(vDate)&num(month(vDate),'00')) 							as NAñoMes,
    Date(vDate, 'YYYYMM') as YearMonth;
;

LOAD
    $(vNMinFecha) + IterNo() - 1 as vDate
AUTOGENERATE 1
WHILE $(vNMinFecha) + IterNo() - 1 <= $(vNMaxFecha);

CalendarioCompuesto:
LOAD DISTINCT
	DATE(ADDMONTHS(YearMonth, 1-ITERNO(), 0))  							as Date,
	ITERNO()-1								   							as MonthsBack,
    YearMonth,
    YEAR(YearMonth) 													as Año
    
RESIDENT Calendario
WHILE ITERNO()<=48;


CalendarioasOF:
LOAD
	Date,
    MONTH(Date) 														as MonthasOf,
    YEAR(Date) 															as YearasOf,
	MonthsBack,
	YearMonth,
    'CMO'																as Tipo
RESIDENT CalendarioCompuesto
WHERE MonthsBack=0 AND Year(Date)="Año"; 

CONCATENATE(CalendarioasOF)
LOAD
	Date,
     MONTH(Date) 														as MonthasOf,
    YEAR(Date) 															as YearasOf,
	MonthsBack,
	YearMonth,
    'YTD'																as Tipo
RESIDENT CalendarioCompuesto
WHERE "Año"=Year(Date);


CONCATENATE(CalendarioasOF)
LOAD
	Date,
     MONTH(Date) 														as MonthasOf,
    YEAR(Date) 															as YearasOf,
	MonthsBack,						
	YearMonth,
    'TAM'																as Tipo
RESIDENT CalendarioCompuesto
WHERE MonthsBack<12;

DROP TABLE CalendarioCompuesto;