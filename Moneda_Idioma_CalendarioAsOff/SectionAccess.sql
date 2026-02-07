STAR IS *;

SEGURETAT:
CROSSTABLE("ID División", "Valor", 3)
LOAD
    Usuari,
    "e-mail",
    ACCESS,
    //"Divisió:",
    "110",
    "120",
    "130",
    "140",
    "150",
    "160",
    "170",
    "180",
    "190",
    "210",
    "310",
    "410",
    "990"
// FROM [$(vRutaSeguretat)Seguretat Qlik.xlsx]
// (ooxml, embedded labels, header is 1 lines, table is Sheet0);
FROM [$(vRutaSeguretat)Seguretat Qlik.xlsx]
(ooxml, embedded labels, table is Sheet0);


TMP_Seguretat:
CROSSTABLE("ID País", "Valor", 3)
LOAD
    Usuari,
    "e-mail",
    ACCESS,
//     País,
    AD,
    AE,
    AF,
    OCC
// FROM [$(vRutaSeguretat)Seguretat Qlik.xlsx]
// (ooxml, embedded labels, header is 1 lines, table is Sheet0);
FROM [$(vRutaSeguretat)Seguretat Qlik.xlsx]
(ooxml, embedded labels, table is Sheet0);

LEFT JOIN (SEGURETAT)
LOAD
  *
RESIDENT TMP_Seguretat;

DROP TABLE TMP_Seguretat;


Seguretat_v2:
LOAD
  Usuari, 
    UPPER("e-mail") AS Correo,
    NUM#("ID División", '#.##0')&'-'&"ID País" AS "LinkSeguridad",
    ACCESS
RESIDENT SEGURETAT
WHERE UPPER(Valor)='X' 
//AND "e-mail"<>'QLIK@GENEBRE.ES';
AND UPPER("e-mail")<>'QLIK@GENEBRE.ES';
//AND "e-mail"<>'QLIK@GENEBRE.ES';


// AND "e-mail"<>'QLIK@GENEBRE.ES'
DROP TABLE SEGURETAT;

NoConcatenate
// Seguretat_v3:
// LOAD DISTINCT
//   Usuari,
//     "e-mail",
//     CONCAT("ID División" , '|') AS LinkSeguridad
// RESIDENT Seguretat_v2
// GROUP BY Usuari, "e-mail";

// DROP TABLE Seguretat_v2;

SA:
LOAD DISTINCT
//   UPPER(Correo) AS USER,
    Correo AS USERID,
    1 as ok,
    UPPER(ACCESS) AS ACCESS,
    "LinkSeguridad" AS LINKSEGURIDAD
RESIDENT Seguretat_v2;

Concatenate(SA)
LOAD DISTINCT
//   UPPER(Correo) AS USER,
    'QLIK@GENEBRE.ES' AS USERID,
    'ADMIN' AS ACCESS,
    '*' AS LINKSEGURIDAD
AutoGenerate (1);

// Concatenate(SA)
// LOAD DISTINCT
// //   UPPER(Correo) AS USER,
//     'QLIK@GENEBRE.ES' AS USERID,
//     'ADMIN' AS ACCESS,
//     '*' AS LINKSEGURIDAD
// AutoGenerate (1);


SECTION ACCESS;
NOCONCATENATE
Seguridad_Final:
LOAD
  USERID,
    ACCESS,
    LINKSEGURIDAD
RESIDENT SA;
SECTION APPLICATION;



DROP TABLE Seguretat_v2,SA;