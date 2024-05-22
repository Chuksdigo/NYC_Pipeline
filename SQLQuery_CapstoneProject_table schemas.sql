CREATE TABLE EDW.FactPayroll (
    EmployeeID INT,
    TitleCode VARCHAR(50),
    AgencyCode VARCHAR(50),
    FiscalYear INT,
    PayrollNumber INT,
    RegularHours DECIMAL(10, 2),
    RegularGrossPaid DECIMAL(10, 2),
    OTHours DECIMAL(10, 2),
    TotalOTPaid DECIMAL(10, 2),
    TotalOtherPay DECIMAL(10, 2));

CREATE TABLE EDW.DimEmployee (
    EmployeeID INT,
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    AgencyStartDate DATE,
    WorkLocationBorough VARCHAR(50),
    LeaveStatusasofJune30 VARCHAR(50),
    BaseSalary DECIMAL(10, 2));

CREATE TABLE EDW.AggregatePayrollByAgency(
    AgencyCode VARCHAR(50),
    TotalPayrollCost DECIMAL(10, 2)
);

CREATE TABLE EDW.AggregateOvertimeByTitle(
    TitleCode VARCHAR(50),
    TotalOvertimePaid DECIMAL(10, 2)
);

CREATE TABLE EDW.AverageSalaryByBorough(
    WorkLocationBorough VARCHAR(50),
    AverageSalary DECIMAL(10, 2)
);

CREATE TABLE EDW.AggregateHoursByEmployee(
    EmployeeID INT,
    TotalRegularHours DECIMAL(10, 2),
    TotalOvertimeHours DECIMAL(10, 2)
);

CREATE TABLE EDW.AggregatePaymentsByFiscalYearAndAgency(
    FiscalYear INT,
    AgencyCode VARCHAR(50),
    TotalPayments DECIMAL(10, 2)
);