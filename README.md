# NYC_Pipeline
Capstone Project: NYC Payroll Data Integration 

Project Description
This project involves creating a data warehouse in Azure SQL Database, integrating it with GitHub for version control, and utilizing stored procedures for efficient data management and querying. The goal is to aggregate and analyze payroll data from multiple years (2020 and 2021) for key business insights, ensuring that the process is automated and scalable.

Tools Used
i.	Azure SQL Database: Cloud-based relational database service for storing and managing data.
ii.	SQL Server Management Studio (SSMS): Tool for managing SQL Server and Azure SQL Database.
iii.	Azure Data Studio: Tool for database development and operations.
iv.	GitHub: Platform for version control and collaboration.

Warehouse Schema (Structure)
The data warehouse schema includes the following tables:
1.	Fact Table: FactPayroll
Columns: EmployeeID, TitleCode, AgencyCode, FiscalYear, PayrollNumber, RegularHours, RegularGrossPaid, OTHours, TotalOTPaid, TotalOtherPay

2.	Dimension Tables:
DimEmployee: EmployeeID, LastName, FirstName, AgencyStartDate, WorkLocationBorough, LeaveStatusasofJune30, BaseSalary

3.	Aggregate Tables:
AggregatePayrollByAgency: AgencyCode, TotalPayrollCost
AggregateOvertimeByTitle: TitleCode, TotalOvertimePaid
AverageSalaryByBorough: WorkLocationBorough, AverageSalary
AggregateHoursByEmployee: EmployeeID, TotalRegularHours, TotalOvertimeHours
AggregatePaymentsByFiscalYearAndAgency: FiscalYear, AgencyCode, TotalPayments

4.	Step-by-Step Description of the Processes Involved
Extract Data from Source Systems:
Use SQL queries to extract payroll data from the source tables (nycpayroll_2020 and nycpayroll_2021).

5.	Transform Data:
Ensure consistency in data types and format across different years.
Cast necessary columns to appropriate data types (e.g., DECIMAL(10, 2)).

6.	Load Data into Fact Table:
Create a consolidated `FactPayroll` table to hold combined payroll data.
Insert data from both 2020 and 2021 tables into “FactPayroll”.

7.	Automate Data Loading (Optional):
Schedule regular updates using tools like Azure Data Factory.

8.	Create and Manage Aggregate Tables:
Create aggregate tables to pre-compute and store summary data for quick access.
Use SQL scripts to create and populate these tables based on the `FactPayroll` data.

9.	Integrate with GitHub:
Export database schema and data.
Create a new repository on GitHub.
Clone the repository locally and add the exported files.
Commit and push the changes to GitHub for version control.

10.	Work with Stored Procedures:
Create stored procedures to encapsulate common queries and data manipulation logic.
Use Azure Data Studio to write and manage stored procedures.

11.	Execute and Update Stored Procedures:
Execute stored procedures using `EXEC` command.
Modify stored procedures with `ALTER PROCEDURE` as needed.
Drop stored procedures with `DROP PROCEDURE` if no longer needed.

By following these steps, the project ensures a robust, scalable, and version-controlled data warehouse solution in Azure SQL Database, enhanced with the use of stored procedures for efficient data management and querying.

