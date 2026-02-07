
[MinMaxTemp]:
LOAD
	DATE(MIN(FieldValue('OrderDate', RecNo()))) 														as MinDate,
    DATE(MAX(FieldValue('OrderDate', RecNo()))) 														as MaxDate
AUTOGENERATE FieldValueCount('OrderDate');
 
 

[MasterCalendar_Temp]:
LOAD
	DATE(MinDate + IterNo() - 1) 																		as OrderDate
Resident MinMaxTemp
WHILE MinDate + IterNo() - 1 <= MaxDate;
DROP TABLE MinMaxTemp;
 


 
 
[MasterCalendar]:
LOAD
	    
    //Número Fecha 022016
    Date(OrderDate, 'MMYYYY') 																			as DateCode,
    
	OrderDate,
    Day(OrderDate) 																						as Día,


    //Mes Número 08
    Num(Month(OrderDate), '00') 																		as MesNum,
    
    //Mes Nombre
    Month(OrderDate) 																					as MesNombre,    
      
	// Nº Mesdentro del trimestre 2 = feb, mayo, agost
    Mod(Month(OrderDate)-1,3)+1 																		as MonthInQuarter,
    


    //Nº Trimestre  1,2,3,4
    Ceil(Month(OrderDate)/3) 																			as Quarter,
    
     
    //Nº Trimestre Formato Q1, Q2, Q3, Q4
     Dual('Q' & Ceil(Month(OrderDate) / 3), Ceil(Month(OrderDate) / 3)) 								as QuarterQ,
     

	//Nº Semestre
   	Dual('S' & Ceil(Month(OrderDate)/6), Ceil(Month(OrderDate)/6)) 										as Semestre,


    //Mes-Año  feb-2016
 	Date(MonthStart(OrderDate), 'MMM-YYYY') 															as MonthYear,
    
     
    // Trimestre natural Q3-2006
    Dual('Q' & Ceil(Month(OrderDate)/3) & '-' & Year(OrderDate),
    	Year(OrderDate)*10 + Ceil(Month(OrderDate)/3)) 													as QuarterYear,
   
 	//Año 
   	Year(OrderDate) 																					as Año,
    
    


    // 1 = dentro del rango y 0 = fuera del rango
    //FiscalYearToDate. 1 = inicio año hasta hoy
    InYearToDate(OrderDate,$(vToday), 0)* -1 															as CYTDFlag,
    
    //FiscalLastYearToDate  1 = un año atrás
    InYearToDate(OrderDate,$(vToday), -1, 7)* -1 														as CLYTDFlag,
    
    //FiscalLastYearToDate  1 = dos años atrás
    InYearToDate(OrderDate,$(vToday), -2, 7)* -1                                                        as C2LYTDFlag,
    
    //FiscalQuarterToDate 1 = desde el inicio del trimestre hasta ahora
    InQuarterToDate(OrderDate, $(vToday), 0) * -1 														as CQTDFlag,
    
    //FiscalMonthToDate 1 = desde inicio del mes hasta ahora
	InMonthToDate(OrderDate, $(vToday), 0)     * -1 													as CMTDFlag,		
    
    
    
    
    // Index Quarter empezando por Julio
	(If(Month(OrderDate)>=7, Year(OrderDate)+1, Year(OrderDate))  * 4)
    	+ Ceil((Mod(Month(OrderDate)+5,12)+1)/3) 														as QuarterIndex
  
RESIDENT MasterCalendar_Temp;
DROP TABLE MasterCalendar_Temp;