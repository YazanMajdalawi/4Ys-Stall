-- Create Database
CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Phone VARCHAR(50) UNIQUE,
    Address TEXT,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create ProductCategory Table
CREATE TABLE ProductCategory (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL UNIQUE
);

-- Create ProductCatalog Table
CREATE TABLE ProductCatalog (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    QuantityInStock INT NOT NULL,
    ImageURL VARCHAR(255),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES ProductCategory(CategoryID)
);

-- Create ProductImages Table
CREATE TABLE ProductImages (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ImageURL VARCHAR(255) NOT NULL,
    ImageOrder INT NOT NULL,
    ProductID INT,
    FOREIGN KEY (ProductID) REFERENCES ProductCatalog(ProductID)
);

-- Create OrderItems Table
CREATE TABLE OrderItems (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    TotalItemsPrice DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES ProductCatalog(ProductID)
);

-- Create Shippings Table
CREATE TABLE Shippings (
    ShippingID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    CarrierName VARCHAR(255) NOT NULL,
    TrackingNumber VARCHAR(255),
    ShippingStatus VARCHAR(50) DEFAULT 'Pending',
    EstimatedDeliveryDate DATE,
    ActualDeliveryDate DATE,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Create Payments Table
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    TransactionDate DATE NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Create Reviews Table
CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    CustomerID INT NOT NULL,
    ReviewText TEXT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewDate DATE NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES ProductCatalog(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE users (
    id INT(11) NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    password VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);
