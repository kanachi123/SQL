CREATE TABLE Employees (
    EmployeeID INT  PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    HireDate DATE NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    DepartmentID INT,
    ManagerID INT NULL,
    PerformaceRating DECIMAL(3,2),
    Foreign Key (DepartmentID) REFERENCES Departments(DepartmentID),
    Foreign Key (ManagerID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Products(
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    CategoryName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL, 
    StockQuantity INT NOT NULL,
    ManufactureDate DATE
);

Create Table Sales(
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    EmployeeID INT NOT NULL,
    SaleDate DATETIME NOT NULL,
    Quantity INT NOT NULL,
    TotalAmount DECIMAL(15, 2) NOT NULL,
    Foreign Key (ProductID) REFERENCES Products(ProductID),
    Foreign Key (EmployeeID) REFERENCES Employees(EmployeeID)

);

Create Table Projects(
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName NVARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Budget DECIMAL(15, 2) NOT NULL,
    Status NVARCHAR(50) NOT NULL
);

