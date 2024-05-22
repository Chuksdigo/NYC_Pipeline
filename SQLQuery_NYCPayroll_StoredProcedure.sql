CREATE PROCEDURE STG.prc_nycpayroll_data
AS 
BEGIN 

    -- LOADING DIMENSION TABLES
    -- Loading Data from 2020 payroll into Factpayroll

    INSERT INTO EDW.FactPayroll
    SELECT 
    EmployeeID,
    TitleCode,
    AgencyID as AgencyCode,
    FiscalYear,
    PayrollNumber,
    CAST(RegularHours AS DECIMAL(10, 2)),
    CAST(RegularGrossPaid AS DECIMAL(10, 2)),
    CAST(OTHours AS DECIMAL(10, 2)),
    CAST(TotalOTPaid AS DECIMAL(10, 2)),
    CAST(TotalOtherPay AS DECIMAL(10, 2))
    FROM STG.nycpayroll_2020;

    -- Loading Data from 2021 payroll into Factpayroll
    INSERT INTO EDW.FactPayroll
    SELECT 
    EmployeeID,
    TitleCode,
    AgencyCode,
    FiscalYear,
    PayrollNumber,
    CAST(RegularHours AS DECIMAL(10, 2)),
    CAST(RegularGrossPaid AS DECIMAL(10, 2)),
    CAST(OTHours AS DECIMAL(10, 2)),
    CAST(TotalOTPaid AS DECIMAL(10, 2)),
    CAST(TotalOtherPay AS DECIMAL(10, 2))
    FROM STG.nycpayroll_2021;

    -- Loading Data from 2020 payroll into Dim_Employee
    INSERT INTO EDW.DimEmployee
    SELECT
    EmployeeID, LastName, FirstName, AgencyStartDate, WorkLocationBorough, LeaveStatusasofJune30, BaseSalary
    FROM STG.nycpayroll_2020;

    -- Loading Data from 2021 payroll into Dim_Employee
    INSERT INTO EDW.DimEmployee
    SELECT
    EmployeeID, LastName, FirstName, AgencyStartDate, WorkLocationBorough, LeaveStatusasofJune30, BaseSalary
    FROM STG.nycpayroll_2021;

    -- Creating Aggregate tables
    INSERT INTO EDW.AggregatePayrollByAgency
    SELECT 
    AgencyCode,
    SUM (RegularGrossPaid + TotalOTPaid + TotalOtherPay) AS TotalPayrollCost
    FROM EDW.FactPayroll
    GROUP BY AgencyCode;

    INSERT INTO EDW.AggregateOvertimeByTitle
    SELECT 
    TitleCode,
    SUM(TotalOTPaid) AS TotalOvertimePaid
    FROM EDW.FactPayroll
    GROUP BY TitleCode;

    INSERT INTO EDW.AverageSalaryByBorough
    SELECT 
    WorkLocationBorough,
    AVG(BaseSalary) AS AverageSalary
    FROM EDW.DimEmployee
    GROUP BY WorkLocationBorough;

    INSERT INTO EDW.AggregateHoursByEmployee
    SELECT 
    EmployeeID,
    SUM(RegularHours) AS TotalRegularHours,
    SUM(OTHours) AS TotalOvertimeHours
    FROM EDW.FactPayroll
    GROUP BY EmployeeID;

    INSERT INTO EDW.AggregatePaymentsByFiscalYearAndAgency
    SELECT 
    FiscalYear,
    AgencyCode,
    SUM(RegularGrossPaid + TotalOTPaid + TotalOtherPay) AS TotalPayments
    FROM EDW.FactPayroll
    GROUP BY FiscalYear, AgencyCode;

END;

exec STG.prc_nycpayroll_data


TRUNCATE TABLE edw.AggregateHoursByEmployee
TRUNCATE TABLE edw.AggregateOvertimeByTitle
TRUNCATE TABLE edw.AggregatePaymentsByFiscalYearAndAgency
TRUNCATE TABLE edw.AggregatePayrollByAgency
TRUNCATE TABLE edw.AverageSalaryByBorough
TRUNCATE TABLE edw.DimEmployee
TRUNCATE TABLE edw.FactPayroll

drop table STG.AgencyMaster
drop table STG.EmpMaster
drop table STG.nycpayroll_2020
drop table STG.nycpayroll_2021
drop table STG.TitleMaster

SELECT EmployeeID, TotalRegularHours, TotalOvertimeHours 
FROM EDW.AggregateHoursByEmployee;
