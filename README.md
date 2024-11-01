# University Medical Center Database

## Project Overview

This project involves the design, implementation, and testing of a database management system for the University Medical Center. The database is designed to store and manage data related to various hospital operations, including patient information, medical records, staff schedules, facility management, and more.

## Table of Contents

1. [Project Structure](#project-structure)
2. [Database Design](#database-design)
3. [Implementation](#implementation)
4. [Usage](#usage)
5. [Testing](#testing)
6. [Technologies Used](#technologies-used)

## Project Structure

The project is divided into three main phases:

1. Design
2. Implementation
3. Testing

## Database Design

The database schema consists of 23 main tables, including:

- PatientInfo
- PatientRecords
- PatientPreScreen
- AdmittedPatients
- ProcedureInfo
- MedicationInfo
- PrescriptionInfo
- PhysicianInfo
- PhysicianSchedule
- ScheduleDetails
- LicenseInfo
- InsuranceInfo
- NurseInfo
- EmployeeInfo
- EmployeeBenefits
- FacilityInfo
- FacilityDetails
- PharmacyInfo
- VisitorInfo
- LabTestInfo
- LabTestResults
- ImagingTestInfo
- ImagingTestResults
- Billings

The database is normalized to the Third Normal Form (3NF) to ensure data integrity and minimize redundancy.

## Implementation

The implementation phase includes:

1. Creating the database
2. Creating tables with appropriate constraints (Primary Keys, Foreign Keys, etc.)
3. Inserting sample data into the tables
4. Creating views, stored procedures, and triggers for common operations and data integrity

## Usage

To use this database:

1. Execute the SQL scripts to create the database and tables
2. Run the insert statements to populate the tables with sample data
3. Use the provided views, stored procedures, and functions to query and manipulate the data

## Testing

The testing phase involves:

1. Verifying the integrity constraints
2. Testing the views, stored procedures, and triggers
3. Running various scenarios to ensure the database meets the requirements of the University Medical Center

## Technologies Used

- SQL Server (or Azure Data Studio for Mac users)
- Docker (for Mac users)

Note: This README provides an overview of the project. For detailed information on each component, please refer to the individual SQL files and documentation provided in the project.