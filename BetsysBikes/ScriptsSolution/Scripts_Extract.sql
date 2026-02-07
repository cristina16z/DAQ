LIB CONNECT TO 'C--Users-cristina.val-Desktop-ExerciciFinal-Certification.mdb';



Address:
LOAD AddressID,
    AddressLine1,
    AddressLine2,
    City,
    CountryRegionCode,
    CountryRegionName,
    IsOnlyStateProvinceFlag,
    PostalCode,
    StateProvinceCode,
    StateProvinceName,
    TerritoryID;
SQL SELECT AddressID,
    AddressLine1,
    AddressLine2,
    City,
    CountryRegionCode,
    CountryRegionName,
    IsOnlyStateProvinceFlag,
    PostalCode,
    StateProvinceCode,
    StateProvinceName,
    TerritoryID
FROM Address;
STORE Address INTO 'lib://BetsysBikes/QVDs/Address.qvd'(qvd);
Drop Table Address;


Customer:
LOAD AccountNumber,
    CustomerID,
    PersonID,
    StoreID,
    TerritoryID;
SQL SELECT AccountNumber,
    CustomerID,
    PersonID,
    StoreID,
    TerritoryID
FROM Customer;
STORE Customer INTO 'lib://BetsysBikes/QVDs/Customer.qvd'(qvd);
Drop Table Customer;

Employee:
LOAD BaseRate,
    BirthDate,
    CurrentFlag,
    DepartmentName,
    EmailAddress,
    EmergencyContactName,
    EmergencyContactPhone,
    EmployeeBusinessEntityID,
    EndDate,
    FirstName,
    Gender,
    HireDate,
    LastName,
    MaritalStatus,
    MiddleName,
    ParentEmployeeBusinessEntityID,
    PayFrequency,
    Phone,
    SalariedFlag,
    SalesPersonFlag,
    SalesTerritoryKey,
    SickLeaveHours,
    StartDate,
    Status,
    Title,
    VacationHours;
SQL SELECT BaseRate,
    BirthDate,
    CurrentFlag,
    DepartmentName,
    EmailAddress,
    EmergencyContactName,
    EmergencyContactPhone,
    EmployeeBusinessEntityID,
    EndDate,
    FirstName,
    Gender,
    HireDate,
    LastName,
    MaritalStatus,
    MiddleName,
    ParentEmployeeBusinessEntityID,
    PayFrequency,
    Phone,
    SalariedFlag,
    SalesPersonFlag,
    SalesTerritoryKey,
    SickLeaveHours,
    StartDate,
    Status,
    Title,
    VacationHours
FROM Employee;
STORE Employee INTO 'lib://BetsysBikes/QVDs/Employee.qvd'(qvd);
Drop Table Employee;

Person:
LOAD BusinessEntityID,
    EmailPromotion,
    FirstName,
    LastName,
    MiddleName,
    NameStyle,
    PersonType,
    Suffix,
    Title;
SQL SELECT BusinessEntityID,
    EmailPromotion,
    FirstName,
    LastName,
    MiddleName,
    NameStyle,
    PersonType,
    Suffix,
    Title
FROM Person;
STORE Person INTO 'lib://BetsysBikes/QVDs/Person.qvd'(qvd);
Drop Table Person;

Product:
LOAD `Class`,
    `Color`,
    DaysToManufacture,
    DiscontinuedDate,
    FinishedGoodsFlag,
    ListPrice,
    MakeFlag,
    Name,
    ProductID,
    ProductLine,
    ProductModelID,
    ProductNumber,
    ProductSubcategoryID,
    ReorderPoint,
    SafetyStockLevel,
    SellEndDate,
    SellStartDate,
    `Size`,
    SizeUnitMeasureCode,
    StandardCost,
    Style,
    Weight,
    WeightUnitMeasureCode;
SQL SELECT `Class`,
    `Color`,
    DaysToManufacture,
    DiscontinuedDate,
    FinishedGoodsFlag,
    ListPrice,
    MakeFlag,
    Name,
    ProductID,
    ProductLine,
    ProductModelID,
    ProductNumber,
    ProductSubcategoryID,
    ReorderPoint,
    SafetyStockLevel,
    SellEndDate,
    SellStartDate,
    `Size`,
    SizeUnitMeasureCode,
    StandardCost,
    Style,
    Weight,
    WeightUnitMeasureCode
FROM Product;
STORE Product INTO 'lib://BetsysBikes/QVDs/Product.qvd'(qvd);
Drop Table Product;

ProductCategory:
LOAD Name,
    ProductCategoryID;
SQL SELECT Name,
    ProductCategoryID
FROM ProductCategory;
STORE ProductCategory INTO 'lib://BetsysBikes/QVDs/ProductCategory.qvd'(qvd);
Drop Table ProductCategory;

ProductModel:
LOAD Name,
    ProductModelID;
SQL SELECT Name,
    ProductModelID
FROM ProductModel;
STORE ProductModel INTO 'lib://BetsysBikes/QVDs/ProductModel.qvd'(qvd);
Drop Table ProductModel;


ProductSubcategory:
LOAD Name,
    ProductCategoryID,
    ProductSubcategoryID;
SQL SELECT Name,
    ProductCategoryID,
    ProductSubcategoryID
FROM ProductSubcategory;
STORE ProductSubcategory INTO 'lib://BetsysBikes/QVDs/ProductSubcategory.qvd'(qvd);
Drop Table ProductSubcategory;


ProductVendor:
LOAD AverageLeadTime,
    BusinessEntityID,
    LastReceiptCost,
    LastReceiptDate,
    MaxOrderQty,
    MinOrderQty,
    OnOrderQty,
    ProductID,
    StandardPrice,
    UnitMeasureCode;
SQL SELECT AverageLeadTime,
    BusinessEntityID,
    LastReceiptCost,
    LastReceiptDate,
    MaxOrderQty,
    MinOrderQty,
    OnOrderQty,
    ProductID,
    StandardPrice,
    UnitMeasureCode
FROM ProductVendor;
STORE ProductVendor INTO 'lib://BetsysBikes/QVDs/ProductVendor.qvd'(qvd);
Drop Table ProductVendor;


SalesOrderDetail:
LOAD CarrierTrackingNumber,
    DueDate,
    OrderQty,
    ProductID,
    SalesOrderDetailID,
    SalesOrderID,
    ShipDate,
    SpecialOfferID,
    UnitPrice,
    UnitPriceDiscount;
SQL SELECT CarrierTrackingNumber,
    DueDate,
    OrderQty,
    ProductID,
    SalesOrderDetailID,
    SalesOrderID,
    ShipDate,
    SpecialOfferID,
    UnitPrice,
    UnitPriceDiscount
FROM SalesOrderDetail;
STORE SalesOrderDetail INTO 'lib://BetsysBikes/QVDs/SalesOrderDetail.qvd'(qvd);
Drop Table SalesOrderDetail;


SalesOrderHeader:
LOAD AccountNumber,
    BillToAddressID,
    CustomerID,
    Freight,
    LocalCurrency,
    OnlineOrderFlag,
    OrderDate,
    PurchaseOrderNumber,
    RevisionNumber,
    SalesOrderID,
    SalesOrderNumber,
    ShipMethodID,
    ShipToAddressID,
    Status,
    TaxAmt,
    TerritoryID;
SQL SELECT AccountNumber,
    BillToAddressID,
    CustomerID,
    Freight,
    LocalCurrency,
    OnlineOrderFlag,
    OrderDate,
    PurchaseOrderNumber,
    RevisionNumber,
    SalesOrderID,
    SalesOrderNumber,
    ShipMethodID,
    ShipToAddressID,
    Status,
    TaxAmt,
    TerritoryID
FROM SalesOrderHeader;
STORE SalesOrderHeader INTO 'lib://BetsysBikes/QVDs/SalesOrderHeader.qvd'(qvd);
Drop Table SalesOrderHeader;


SalesTerritory:
LOAD CountryRegionCode,
    `Group`,
    Name,
    TerritoryID;
SQL SELECT CountryRegionCode,
    `Group`,
    Name,
    TerritoryID
FROM SalesTerritory;
STORE SalesTerritory INTO 'lib://BetsysBikes/QVDs/SalesTerritory.qvd'(qvd);
Drop Table SalesTerritory;

SalesTerritoryHistory:
LOAD BusinessEntityID,
    EndDate,
    StartDate,
    TerritoryID;
SQL SELECT BusinessEntityID,
    EndDate,
    StartDate,
    TerritoryID
FROM SalesTerritoryHistory;
STORE SalesTerritoryHistory INTO 'lib://BetsysBikes/QVDs/SalesTerritoryHistory.qvd'(qvd);
Drop Table SalesTerritoryHistory;

Store:
LOAD SalesPersonID,
    StoreID,
    StoreName;
SQL SELECT SalesPersonID,
    StoreID,
    StoreName
FROM `Store`;
STORE Store INTO 'lib://BetsysBikes/QVDs/Store.qvd'(qvd);
Drop Table Store;

Vendor:
LOAD AccountNumber,
    ActiveFlag,
    BusinessEntityID,
    CreditRating,
    Name,
    PreferredVendorStatus;
SQL SELECT AccountNumber,
    ActiveFlag,
    BusinessEntityID,
    CreditRating,
    Name,
    PreferredVendorStatus
FROM Vendor;
STORE Vendor INTO 'lib://BetsysBikes/QVDs/Vendor.qvd'(qvd);
Drop Table Vendor;


Quota:
LOAD
    F1,
    "275",
    "276",
    "277",
    "279",
    "280",
    "282",
    "284",
    "286",
    "288",
    "289",
    "290",
    Website
FROM [lib://BetsysBikes/Certification Data.xlsx]
(ooxml, embedded labels, table is Quota);
STORE Quota INTO 'lib://BetsysBikes/QVDs/Quota.qvd'(qvd);
Drop Table Quota;


SpecialOffer:
LOAD
    SpecialOfferID,
    Description,
    DiscountPct,
    "Type",
    Category
FROM [lib://BetsysBikes/Certification Data.xlsx]
(ooxml, embedded labels, table is [Special Offer]);
STORE SpecialOffer INTO 'lib://BetsysBikes/QVDs/SpecialOffer.qvd'(qvd);
Drop Table SpecialOffer;


SpecialMetrics:
LOAD
    Salesperson,
    "Sales Order",
    "Order Quantity",
    "Order Total",
    "Items / Order",
    "Avg. Order Qty",
    "Avg. Order Sales",
    H,
    "I",
    J,
    K,
    L,
    M
FROM [lib://BetsysBikes/Certification Data.xlsx]
(ooxml, embedded labels, table is [Special Metrics - Example]);
STORE SpecialMetrics INTO 'lib://BetsysBikes/QVDs/SpecialMetrics.qvd'(qvd);
Drop Table SpecialMetrics;


