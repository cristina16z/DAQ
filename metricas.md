# Dashboard
## 1. Dashboard ejecutivo

Resumen:
- 5 tarjetas KPI (arriba):
- Ventas FYTD (con LY y Var%)
- Sales vs Quota FYTD (con cuota y %cumpl.)
- Margen % FYTD (con margen € opcional)
- % Envíos a tiempo FYTD (con % retrasados)
- Ventas 12M móviles (con 12M previos y Var%)
- Abajo (2 gráficos + 1 mini tabla):
- Combo: Ventas vs Cuota por MonthYear
- Línea: % Envíos a tiempo por MonthYear
- Tabla FYTD/QTD/MTD (Sales, LY, Var%)



- KPI 1 Ventas (FYTD) + comparación YoY , que son Ventas contrastadas con año anterior” + “variación vs año anterior”.
    - Valor principal (Ventas FYTD):Sum({<FYTDFlag={-1}>} LineSalesAmount)
    - Submétrica 1 (Ventas FYTD LY):Sum({<FLYTDFlag={-1}>} LineSalesAmount)
    - Submétrica 2 (Var % FYTD vs LY):Sum({<FYTDFlag={-1}>} LineSalesAmount)/ Sum({<FLYTDFlag={-1}>} LineSalesAmount) - 1


- KPI 2 Ventas vs Cuota (FYTD) + Cuota + % cumplimiento
    - Valor principal (Sales vs Quota € FYTD):Sum({<FYTDFlag={-1}>} LineSalesAmount) - Sum(
  Aggr(
    Max({<FYTDFlag={-1}>} QuotaAmount),
    SalesPersonID,
    QuotaMonth
  )
)

    - Submétrica 1 (Cuota FYTD):Sum(
  Aggr(
    Max({<FYTDFlag={-1}>} QuotaAmount),
    SalesPersonID,
    QuotaMonth
  )
)

    - Submétrica 2 (% sobre cuota):Sum({<FYTDFlag={-1}>} LineSalesAmount)
/ Sum(Aggr(Max({<FYTDFlag={-1}>} QuotaAmount), SalesPersonID, QuotaMonth)) - 1



- KPI 3 Margen % (FYTD)
    - Valor principal (Margen % FYTD):Sum({<FYTDFlag={-1}>} Margin)
/ Sum({<FYTDFlag={-1}>} LineSalesAmount)

    - Submétrica opcional (Margen € FYTD):Sum({<FYTDFlag={-1}>} Margin)

- KPI 4 — Envíos a tiempo % (FYTD)
    - Valor principal (% a tiempo FYTD):Count(DISTINCT {<FYTDFlag={-1}, EsATiempo={1}>} SalesOrderID)
/ Count(DISTINCT {<FYTDFlag={-1}>} SalesOrderID)

    - Submétrica (retrasados % FYTD):Count(DISTINCT {<FYTDFlag={-1}, DiasRetraso={">=1"}>} SalesOrderID)
/ Count(DISTINCT {<FYTDFlag={-1}>} SalesOrderID)



- KPI 5 Ventas 12 meses móviles + comparación vs 12M previos
    - Valor principal (12M actual, terminando en vToday): Sum({<OrderDate={">=$(=Date(AddMonths($(vToday),-11)))<=$(=Date($(vToday)))"}>} LineSalesAmount)

    - Submétrica 1 (12M previo): Sum({<OrderDate={">=$(=Date(AddMonths($(vToday),-23)))<=$(=Date(AddMonths($(vToday),-12)))"}>} LineSalesAmount)

    - Submétrica 2 (Var % 12M): Sum({<OrderDate={">=$(=Date(AddMonths($(vToday),-11)))<=$(=Date($(vToday)))"}>} LineSalesAmount)
/ Sum({<OrderDate={">=$(=Date(AddMonths($(vToday),-23)))<=$(=Date(AddMonths($(vToday),-12)))"}>} LineSalesAmount)- 1



GRÁFICOS


Tendencia mensual: Ventas vs Cuota (últimos 24 meses)
Tipo: Combo (barras ventas + línea cuota)
Dimensión: MonthYear
Ventas:Sum(LineSalesAmount)
Cuota (mensual deduplicada):Sum(Aggr(Max(QuotaAmount), SalesPersonID, QuotaMonth))



Gráfico 2 — Tendencia mensual: % Envíos a tiempo
Tipo: Línea
Dimensión: MonthYear
Medida: Count(DISTINCT {<EsATiempo={1}>} SalesOrderID)
/ Count(DISTINCT SalesOrderID)



Tabla pequeña (muy útil) para cumplir YTD/QTD/MTD sin más KPIs

El documento exige que se muestren los rangos YTD / QTD / MTD comparados con el mismo período del año anterior. 

Objeto: Straight table (3 filas)
Dimensión: una dimensión “desconectada” con valores: FYTD, FQTD, FMTD 
Columnas: Sales Actual, Sales LY, Var%

Sales Actual (según fila):

FYTD: Sum({<FYTDFlag={-1}>} LineSalesAmount)

FQTD: Sum({<FQTDFlag={-1}>} LineSalesAmount)

FMTD: Sum({<FMTDFlag={-1}>} LineSalesAmount)

📌 Para que QTD/MTD tengan LY “correcto”, te recomiendo añadir en calendario:
InQuarterToDate(OrderDate, $(vToday), -1, 7) * -1 as FLQTDFlag,
InMonthToDate(OrderDate, $(vToday), -1) * -1     as FLMTDFlag
y entonces LY sería:

QTD LY: Sum({<FLQTDFlag={-1}>} LineSalesAmount)

MTD LY: Sum({<FLMTDFlag={-1}>} LineSalesAmount)


## 2. Dashboard ejecutivo
KPIS
- A) Ventas (Actual) + Variación vs Año Anterior
    - Tarjeta KPI
    - Métrica (Actual): Sum(LineSalesAmount) con el set del período (FYTD/FQTD/FMTD)
    - Subtítulo/2ª medida (YoY Δ): Ventas_Actual - Ventas_AñoAnterior
    - 3ª medida opcional (YoY %): (Ventas_Actual - Ventas_AñoAnterior)/Ventas_AñoAnterior
- B) Ventas vs Cuota (y cuota actual)
    - Tarjeta KPI (titular)
    - Sales vs Quota (€): Sum(LineSalesAmount)- Sum(Aggr(Max(QuotaAmount), SalesPersonID, QuotaMonth))
    - Cumplimiento % (opcional):
    - Cuota (como 2ª tarjeta o subtítulo):Sum(Aggr(Max(QuotaAmount), SalesPersonID, QuotaMonth))
- C) Margen %
    - Tarjeta KPI
    - Sum(Margin) / Sum(LineSalesAmount)
- D) Envíos a tiempo %
    - Count(DISTINCT {<EsATiempo={1}>} SalesOrderID) / Count(DISTINCT SalesOrderID)

GRÁFICOS
- 1) Ventas móviles 12 meses (obligatorio)
    - Dimensión: MonthYear
    - Medida 1 (Ventas mensuales): Sum(LineSalesAmount)
    - Medida 2 (Rolling 12M): RangeSum( Above( Sum(LineSalesAmount), 0, 12 ) )

- 2) “Sales vs Quota” por mes (para que se entienda el gap)

    - Gráfico recomendado: combo (barras ventas + línea cuota)

    - Dimensión: MonthYear

    - Barras (Sales): Sum(LineSalesAmount)

    - Línea (Quota):Sum(Aggr(Max(QuotaAmount), SalesPersonID, QuotaMonth))

TENDENCIAS
    - A) Envíos a tiempo % por mes (tendencia)

    - Gráfico: línea

    - Dimensión: MonthYear

    - Medida:Count(DISTINCT {<EsATiempo={1}>} SalesOrderID)/ Count(DISTINCT SalesOrderID)

    - B) Margen % por mes (tendencia)
    - Gráfico: línea
    - Dimensión: MonthYear
    - Medida: Sum(Margin)/Sum(LineSalesAmount)

BOTONES
    - Reset/clear
    - Selector de año fiscal

# Analysis

## Hoja Kpis comerciales


- Fila superior (tarjetas KPI):

    - Delayed Shipments %

    - Avg Sales per SalesPerson

    - Sales vs Quota (€) y/o % cumplimiento

    - (Opcional) Avg Order Cost (global)

- Cuerpo (gráficos):

    - Barras: Ventas por Vendedor (Top 10)

    - Combo: Ventas vs Cuota por Vendedor

    - Barras: Distribución retrasos por TiempoDeEnvio

    - Barras/tabla: Coste medio de pedido por Vendedor

- Panel lateral:

    - Filtros requeridos + TreeView de vendedores

### Filtros
- FiscalYear 
- FiscalQuarter
- Month o MonthYear
- SalesTerritoryGroup
- ShipToStateProvinceCode o BillToStateProvinceCode (Provincia/Estado; elige uno consistente)
- CustomerType



### vista arbórea de vendedores (incluyendo Online)
- ListBox TreeView con el campo de ruta (ej. SalesOrgPath) y que seleccione SalesPersonID
con un List Box y marcar “Show as TreeView” (mostrar como vista de árbol).

En la hoja (KPIs / Análisis, donde te lo piden):

Insertar → List Box

Campo: SalesOrgPath

Propiedades del List Box:

Activa “Show as TreeView” (o “Mostrar como vista de árbol”).

Resultado: verás el árbol tipo:

Abbas, Syed E. (285)

Website Sales (WEB)

…otros managers/vendedores…

Cuando seleccionas en ese listbox, por asociación filtrará el modelo vía SalesPersonID (en tu caso, impacta claro en Quota, y en cualquier otra tabla que lleve SalesPersonID).



### 1.  Ventas por Vendedor

- Gráfico de barras horizontal (Top 10/15) + tabla debajo (opcional)
- Dimensión: EmployeeName 
- Medida: Sum(LineSalesAmount)
- Orden: descendente por Sum(LineSalesAmount)

### 2. Envíos Retrasados como % del total enviado
- Mejor objeto: Tarjeta KPI (número + %)
- Medida (Delayed %):
- Count(DISTINCT {<DiasRetraso={">=1"}>} SalesOrderID)
/ Count(DISTINCT SalesOrderID)
- Tooltip/2ª medida (nº retrasados):
- Count(DISTINCT {<DiasRetraso={">=1"}>} SalesOrderID)
- Tooltip/3ª medida (total envíos):
Count(DISTINCT SalesOrderID)
- Count(DISTINCT SalesOrderID)


### 3. Envíos Retrasados por nº de días (segmentados)
- Mejor objeto: Barras apiladas o barras simples
- Dimensión: TiempoDeEnvio (tu bucket Dual: 1 día, 2 días, 3 días, >3)
- Medida (conteo de envíos retrasados):
- Count(DISTINCT {<DiasRetraso={">=1"}>} SalesOrderID)


### 4. Media de Ventas por Vendedor
- Tarjeta KPI
- opción 1: Avg(
  Aggr(
    Sum(LineSalesAmount),
    SalesPersonID
  )
)
- opción 2: Sum(LineSalesAmount) / Count(DISTINCT SalesPersonID)

### 5. Ventas vs. Cuota
- Mejor objeto: Combo chart (barras ventas + línea cuota) por vendedor
y arriba una tarjeta KPI global (diferencia total)
- 5.1 Gráfico por vendedor
- Dimensión: EmployeeName
- Medida 1 (Ventas):Sum(LineSalesAmount)
- Medida 2: Sum(
  Aggr(
    Max(QuotaAmount),
    SalesPersonID,
    QuotaMonth
  )
)

- 5.2 Tarjeta KPI global (titular)
- Sales vs Quota total (€):
Sum(LineSalesAmount)-
Sum(
  Aggr(
    Max(QuotaAmount),
    SalesPersonID,
    QuotaMonth
  )
)
- Opcional: % cumplimiento
Sum(LineSalesAmount)/
Sum(
  Aggr(
    Max(QuotaAmount),
    SalesPersonID,
    QuotaMonth
  )
)


### 6. Coste Medio de Pedido por Vendedor

Mejor objeto: Barras (Top N) o tabla (para auditar)
y opcional una tarjeta KPI con promedio global.
- 6.1 Por vendedor (gráfico)
- Dimensión: EmployeeName
- Medida (coste medio por pedido): Sum(COGS) / Count(DISTINCT SalesOrderID)
- 6.2 KPI global (promedio entre vendedores, recomendado si quieres “un número”)
Avg(
  Aggr(
    Sum(COGS) / Count(DISTINCT SalesOrderID),
    SalesPersonID
  )
)



