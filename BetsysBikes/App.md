# Betsy's Bikes APP

## Proceso ETL

Un proceso que contiene 3 capas para poder representar finalmente los datos a través de la extracción, transofrmación y carga.

###  1ª App Extracción 
1. Importamos los archivos Certification.db, CertificationData.xlsx a Qlik, dónde éstos contienen diferentes tablas con datos.

2. A través del script, hacemos el proceso de extracción de datos dónde los convertimos y generamos los QVD's sin tocar los datos(cada QVD corresponde a una tabla de datos) para su prcesamiento rápido, eficaz y optimizado a la hora de trabajar con los datos.


###  2ª App Transform

3. Importamos estos QVD's para limpiarlos y transformar los datos, realizando un modelamiendo de datos trabajando cada tabla, campo y dato.

4. Una vez finalizada la transformación y validando los datos a través de validations reports.xlsx, los volvemos a extraer a QVD's generando los QVD's finales 

###  3ª App Load

5. Importamos y cargamaos los QVD's finales a la APP.
6. Crearemos las dimensiones y métricas necesarias para realizar la parte gráfica de la app en dónde incluiremos extensiones cómo MzKPI y MzPanel.