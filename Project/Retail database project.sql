USE `database project`

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    TotalSpent DECIMAL(10, 2) DEFAULT 0,
    LoyaltyPoints INT DEFAULT 0
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

-- Purchases Table
CREATE TABLE Purchases (
    PurchaseID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    ProductID INT,
    PurchaseDate DATE NOT NULL,
    Quantity INT NOT NULL,
    TotalCost DECIMAL(10, 2) AS (Quantity * Price) STORED,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Rewards Table
CREATE TABLE Rewards (
    RewardID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    DiscountPercentage DECIMAL(5, 2) DEFAULT 15.00,
    RewardEarnedDate DATE,
    RewardRedeemedDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
