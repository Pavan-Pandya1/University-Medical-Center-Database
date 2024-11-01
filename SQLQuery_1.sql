USE universityMedicalCenter;
GO
CREATE TABLE PatientInfo (
  Id int NOT NULL,
  LastName nvarchar(50) NOT NULL,
  FirstName nvarchar(50) NOT NULL,
  HouseNo nvarchar(100) NULL,
  Street nvarchar(100) NULL,
  PostalCode nvarchar(10) NULL,
  City nvarchar(50) NULL,
  PhoneNumber nvarchar(20) NULL,
  LocationId int NULL,
  PrimaryCarePhysician int NULL,
  DateofBirth datetime NOT NULL,
  InsuranceNumber nvarchar(50) NOT NULL,
  InsuranceGroupId nvarchar(50) NOT NULL,
  CONSTRAINT PK_PatientInfo PRIMARY KEY (Id)
);


CREATE TABLE PatientRecords (
  Id int IDENTITY (1, 1) NOT NULL,
  PatientId int NOT NULL,
  PatientWeight int NOT NULL,
  PatientHeight int NOT NULL,
  BloodPressure nvarchar(50) NOT NULL,
  Temperature nvarchar(100) NULL,
  CheckInTime datetime NOT NULL,
  CheckOutTime datetime NOT NULL,
  LocationId int NULL,
  Diagnosis nvarchar(max) NOT NULL,
  ProcedureId int NULL,
  EmployeeId int NOT NULL,
  PhysicianId int NOT NULL,
  MedicationId int NULL,
  ImagingTestId int NULL,
  LabTestId int NULL,
  CONSTRAINT PK_PatientRecords PRIMARY KEY (Id)
);

CREATE TABLE PatientPreScreen (
  Id int IDENTITY (1, 1) NOT NULL,
  PatientRecordId int NOT NULL,
  Temperature int NOT NULL,
  AnySympotoms bit NOT NULL,
  Vaccinated bit NOT NULL,
  CONSTRAINT PK_PatientPreScreen PRIMARY KEY (Id)
);

CREATE TABLE AdmittedPatients (
  Id int IDENTITY (1, 1) NOT NULL,
  PatientId int NOT NULL,
  FacilityId int NOT NULL,
  AdmitDate datetime NOT NULL,
  CONSTRAINT PK_AdmittedPatients PRIMARY KEY (Id)
);

CREATE TABLE ProcedureInfo (
  Id int NOT NULL,
  ProcedureName nvarchar(50) NOT NULL,
  ProcedureDuration int NOT NULL,
  Cost money NOT NULL,
  CONSTRAINT PK_ProcedureInfo PRIMARY KEY (Id)
);

CREATE TABLE MedicationInfo (
  Id int NOT NULL,
  PrescriptionId int NOT NULL,
  MedicationName nvarchar(50) NOT NULL,
  Refills nvarchar(50) NOT NULL,
  DozesPerDay int NOT NULL,
  Notes nvarchar(max) NULL,
  CONSTRAINT PK_MedicationInfo PRIMARY KEY (Id)
);

CREATE TABLE PrescriptionInfo (
  Id int NOT NULL,
  PharmacyId int NOT NULL,
  Cost money NOT NULL,
  CurrentStatus nvarchar(255) NOT NULL,
  CONSTRAINT PK_PrescriptionInfo PRIMARY KEY (Id)
);

CREATE TABLE PhysicianInfo (
  Id int NOT NULL,
  EmpId int NOT NULL,
  LicenseNumber nvarchar(50) NOT NULL,
  LocationId int NULL,
  TakingNewPatients bit NOT NULL,
  Active bit NOT NULL,
  Retired bit NOT NULL,
  Position nvarchar(50) NOT NULL,
  CONSTRAINT PK_PhysicianInfo PRIMARY KEY (Id)
);

CREATE TABLE PhysicianSchedule (
  Id int IDENTITY (1, 1) NOT NULL,
  PhysicianId int NOT NULL,
  PatientId int NOT NULL,
  ScheduleDetails int NOT NULL,
  NurseId int NOT NULL,
  CONSTRAINT PK_PhysicianSchedule PRIMARY KEY (Id)
);

CREATE TABLE ScheduleDetails (
  Id int IDENTITY (1, 1) NOT NULL,
  StartTime datetime NOT NULL,
  Duration int NOT NULL,
  FacilityId int NOT NULL,
  RoomNumber nvarchar(255) NOT NULL,
  EquipmentNeeded nvarchar(255) NULL,
  CONSTRAINT PK_ScheduleDetails PRIMARY KEY (Id)
);

CREATE TABLE LicenseInfo (
  LicenseNumber nvarchar(50) NOT NULL,
  IssuedBy nvarchar(50) NOT NULL,
  IssuedOn datetime NOT NULL,
  ValidTill datetime NOT NULL,
  CONSTRAINT PK_LicenseInfo PRIMARY KEY (LicenseNumber)
);

CREATE TABLE InsuranceInfo (
  InsuranceNumber nvarchar(50) NOT NULL,
  IssuedBy nvarchar(50) NOT NULL,
  IssuedOn datetime NOT NULL,
  ValidTill datetime NOT NULL,
  Copay money NOT NULL,
  CovergePercentage int NOT NULL,
  BaseCoverage money NOT NULL,
  CONSTRAINT PK_InsuranceInfo PRIMARY KEY (InsuranceNumber)
);

CREATE TABLE NurseInfo (
  Id int NOT NULL,
  EmpId int NOT NULL,
  LocationId int NULL,
  CONSTRAINT PK_NurseInfo PRIMARY KEY (Id)
);

CREATE TABLE EmployeeInfo (
  Id int NOT NULL,
  LastName nvarchar(50) NOT NULL,
  FirstName nvarchar(50) NOT NULL,
  Street nvarchar(100) NULL,
  PostalCode nvarchar(10) NULL,
  City nvarchar(50) NULL,
  PhoneNumber nvarchar(20) NULL,
  DateofBirth datetime NOT NULL,
  Department nvarchar(255) NOT NULL,
  CONSTRAINT PK_EmployeeInfo PRIMARY KEY (Id)
);

CREATE TABLE EmployeeBenefits (
  EmpId int NOT NULL,
  Salary money NOT NULL,
  Benefits nvarchar(255) NOT NULL,
  Schedule nvarchar(255) NOT NULL,
  ContractType nvarchar(50) NOT NULL,
  ContractTerms nvarchar(255) NULL,
  CONSTRAINT PK_EmployeeBenefits PRIMARY KEY (EmpId)
);

CREATE TABLE FacilityInfo (
  Id int NOT NULL,
  FacilityName nvarchar(50) NOT NULL,
  Street nvarchar(100) NULL,
  PostalCode nvarchar(10) NULL,
  City nvarchar(50) NULL,
  PhoneNumber nvarchar(20) NULL,
  CONSTRAINT PK_FacilityInfo PRIMARY KEY (Id)
);

CREATE TABLE FacilityDetails (
  Id int NOT NULL,
  FacilityId int NOT NULL,
  LocationHours nvarchar(255) NOT NULL,
  Departments nvarchar(255) NOT NULL,
  RoomsAvailable int NOT NULL,
  ICUBeds int NOT NULL,
  CCUBeds int NOT NULL,
  TraumaCenterAvailability int NOT NULL,
  VentilatorsAvailable int NOT NULL,
  OxygenCylindersAvailable int NOT NULL,
  CONSTRAINT PK_FacilityDetails PRIMARY KEY (Id)
);


CREATE TABLE PharmacyInfo (
  Id int NOT NULL,
  PharmacyName nvarchar(50) NOT NULL,
  LocationHours nvarchar(255) NOT NULL,
  RentalEquipment nvarchar(255) NOT NULL,
  Street nvarchar(100) NULL,
  PostalCode nvarchar(10) NULL,
  City nvarchar(50) NULL
  CONSTRAINT PK_PharmacyInfo PRIMARY KEY (Id)
);

CREATE TABLE VisitorInfo (
  Id int IDENTITY (1, 1) NOT NULL,
  LastName nvarchar(50) NOT NULL,
  FirstName nvarchar(50) NOT NULL,
  Street nvarchar(100) NULL,
  PostalCode nvarchar(10) NULL,
  City nvarchar(50) NULL,
  PhoneNumber nvarchar(20) NULL,
  FacilityId int NULL,
  PatientId int NULL,
  CheckInTime datetime NOT NULL,
  CheckOutTime datetime NOT NULL,
  TemperatureAtCheckin int NOT NULL,
  CONSTRAINT PK_VisitorInfo PRIMARY KEY (Id)
);

CREATE TABLE LabTestInfo (
  Id int IDENTITY (1, 1) NOT NULL,
  TestName nvarchar(255) NOT NULL,
  Cost money NOT NULL,
  PaymentMethod nvarchar(50) NULL,
  CONSTRAINT PK_LabTestInfo PRIMARY KEY (Id)
);

CREATE TABLE LabTestResults (
  Id int IDENTITY (1, 1) NOT NULL,
  TestId int NOT NULL,
  Results nvarchar(255) NOT NULL,
  ReportToState bit NOT NULL,
  ReportToCounty nvarchar(50) NULL,
  CONSTRAINT PK_LabTestResults PRIMARY KEY (Id)
);

CREATE TABLE ImagingTestInfo (
  Id int IDENTITY (1, 1) NOT NULL,
  TestName nvarchar(255) NOT NULL,
  Cost money NOT NULL,
  PaymentMethod nvarchar(50) NULL,
  CONSTRAINT PK_ImagingTestInfo PRIMARY KEY (Id)
);

CREATE TABLE ImagingTestResults (
  Id int IDENTITY (1, 1) NOT NULL,
  TestId int NOT NULL,
  Results nvarchar(255) NOT NULL
  CONSTRAINT PK_ImagingTestResults PRIMARY KEY (Id)
);

CREATE TABLE Billings (
  BillingID INT PRIMARY KEY,
  PatientID INT NOT NULL,
  PrescriptioID INT NOT NULL,
  ImagingTestId INT,
  MedicationID INT,
  LabTestID INT,
  BillingDate DATE NOT NULL,
  BillingAmount DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (PatientID) REFERENCES PatientInfo(Id),
  FOREIGN KEY (PrescriptioID) REFERENCES PrescriptionInfo(Id),
  FOREIGN KEY (ImagingTestId) REFERENCES ImagingTestInfo(Id),
  FOREIGN KEY (MedicationID) REFERENCES MedicationInfo(Id),
  FOREIGN KEY (LabTestID) REFERENCES LabTestInfo(Id)
);