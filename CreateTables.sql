USE UniversityMedicalCenter;
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
  City nvarchar(50) NULL,
  PhoneNumber nvarchar(20) NULL
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

CREATE TABLE BILLING (
  billingID  INT NOT NULL,
  numberOfVisits INT NOT NULL,
  medicalBillingCode VARCHAR(5) NOT NULL, 
  payer VARCHAR(20) NOT NULL, 
  paymentMethod VARCHAR(20) NOT NULL,
  CONSTRAINT PK_Billing PRIMARY KEY (billingID)
);


ALTER TABLE PatientRecords
WITH NOCHECK ADD CONSTRAINT FK_PatientRecords_PatientInfo FOREIGN KEY (PatientId) REFERENCES PatientInfo (Id)

ALTER TABLE PatientRecords
WITH NOCHECK ADD CONSTRAINT FK_PatientRecords_ProcedureInfo FOREIGN KEY (ProcedureId) REFERENCES ProcedureInfo (Id)

ALTER TABLE PatientRecords
WITH NOCHECK ADD CONSTRAINT FK_PatientRecords_MedicationInfo FOREIGN KEY (MedicationId) REFERENCES MedicationInfo (Id)

ALTER TABLE PatientRecords
WITH NOCHECK ADD CONSTRAINT FK_PatientRecords_EmployeeInfo FOREIGN KEY (EmployeeId) REFERENCES EmployeeInfo (Id)

ALTER TABLE PatientRecords
WITH NOCHECK ADD CONSTRAINT FK_PatientRecords_PhysicianInfo FOREIGN KEY (PhysicianId) REFERENCES PhysicianInfo (Id)

ALTER TABLE PatientRecords
WITH NOCHECK ADD CONSTRAINT FK_PatientRecords_LabTestInfo FOREIGN KEY (LabTestId) REFERENCES LabTestInfo (Id)

ALTER TABLE PatientRecords
WITH NOCHECK ADD CONSTRAINT FK_PatientRecords_ImagingTestInfo FOREIGN KEY (ImagingTestId) REFERENCES ImagingTestInfo (Id)

ALTER TABLE PatientPreScreen
WITH NOCHECK ADD CONSTRAINT FK_PatientRecords_PatientPreScreen FOREIGN KEY (PatientRecordId) REFERENCES PatientRecords (Id)

ALTER TABLE AdmittedPatients
WITH NOCHECK ADD CONSTRAINT FK_PatientInfo_AdmittedPatients FOREIGN KEY (PatientId) REFERENCES PatientInfo (Id)

ALTER TABLE AdmittedPatients
WITH NOCHECK ADD CONSTRAINT FK_FacilityInfo_AdmittedPatients FOREIGN KEY (FacilityId) REFERENCES FacilityInfo (Id)

ALTER TABLE MedicationInfo
WITH NOCHECK ADD CONSTRAINT FK_MedicationInfo_PrescriptionInfo FOREIGN KEY (PrescriptionId) REFERENCES PrescriptionInfo (Id)

ALTER TABLE PhysicianInfo
WITH NOCHECK ADD CONSTRAINT FK_PhysicianInfo_LicenseInfo FOREIGN KEY (LicenseNumber) REFERENCES LicenseInfo (LicenseNumber)

ALTER TABLE PatientInfo
WITH NOCHECK ADD CONSTRAINT FK_PatientInfo_InsuranceInfo FOREIGN KEY (InsuranceNumber) REFERENCES InsuranceInfo (InsuranceNumber)

ALTER TABLE PhysicianInfo
WITH NOCHECK ADD CONSTRAINT FK_PhysicianInfo_EmployeeInfo FOREIGN KEY (EmpId) REFERENCES EmployeeInfo (Id)

ALTER TABLE NurseInfo
WITH NOCHECK ADD CONSTRAINT FK_NurseInfo_EmployeeInfo FOREIGN KEY (EmpId) REFERENCES NurseInfo (Id)

ALTER TABLE EmployeeBenefits
WITH NOCHECK ADD CONSTRAINT FK_EmployeeBenefits_EmployeeInfo FOREIGN KEY (EmpId) REFERENCES EmployeeInfo (Id)

ALTER TABLE FacilityDetails
WITH NOCHECK ADD CONSTRAINT FK_FacilityDetails_FacilityInfo FOREIGN KEY (FacilityId) REFERENCES FacilityInfo (Id)

ALTER TABLE PrescriptionInfo
WITH NOCHECK ADD CONSTRAINT FK_PrescriptionInfo_PharmacyInfo FOREIGN KEY (PharmacyId) REFERENCES PharmacyInfo (Id)

ALTER TABLE VisitorInfo
WITH NOCHECK ADD CONSTRAINT FK_VisitorInfo_PatientInfo FOREIGN KEY (PatientId) REFERENCES PatientInfo (Id)

ALTER TABLE VisitorInfo
WITH NOCHECK ADD CONSTRAINT FK_VisitorInfo_FacilityInfo FOREIGN KEY (FacilityId) REFERENCES FacilityInfo (Id)

ALTER TABLE PhysicianSchedule
WITH NOCHECK ADD CONSTRAINT FK_PhysicianSchedule_PhysicianInfo FOREIGN KEY (PhysicianId) REFERENCES PhysicianInfo (Id)

ALTER TABLE PhysicianSchedule
WITH NOCHECK ADD CONSTRAINT FK_PhysicianSchedule_PatientInfo FOREIGN KEY (PatientId) REFERENCES PatientInfo (Id)

ALTER TABLE PhysicianSchedule
WITH NOCHECK ADD CONSTRAINT FK_PhysicianSchedule_ScheduleDetails FOREIGN KEY (ScheduleDetails) REFERENCES ScheduleDetails (Id)

ALTER TABLE PhysicianSchedule
WITH NOCHECK ADD CONSTRAINT FK_PhysicianSchedule_NurseInfo FOREIGN KEY (NurseId) REFERENCES NurseInfo (Id)

ALTER TABLE ScheduleDetails
WITH NOCHECK ADD CONSTRAINT FK_PhysicianSchedule_FacilityInfo FOREIGN KEY (FacilityId) REFERENCES FacilityInfo (Id)

ALTER TABLE LabTestResults
WITH NOCHECK ADD CONSTRAINT FK_LabTestResults_LabTestInfo FOREIGN KEY (TestId) REFERENCES LabTestInfo (Id)

ALTER TABLE ImagingTestResults
WITH NOCHECK ADD CONSTRAINT FK_ImagingTestResults_ImagingTestInfo FOREIGN KEY (TestId) REFERENCES ImagingTestInfo (Id)

ALTER TABLE BILLING 
WITH NO CHECK ADD CONSTRAINT FK_Billing_PatientInfo FOREIGN KEY (billingID) REFERENCES PatientInfo (Id)

ALTER TABLE BILLING 
WITH NO CHECK ADD CONSTRAINT FK_Billing_MedicationInfo FOREIGN KEY (billingID) REFERENCES MedicationInfo (Id)

ALTER TABLE BILLING 
WITH NO CHECK ADD CONSTRAINT FK_Billing_LabTestInfo FOREIGN KEY (billingID) REFERENCES PatientInfo (Id)

ALTER TABLE BILLING 
WITH NO CHECK ADD CONSTRAINT FK_Billing_InsuranceInfo FOREIGN KEY (billingID) REFERENCES InsuranceInfo (InsuranceNumber)

ALTER TABLE BILLING 
WITH NO CHECK ADD CONSTRAINT FK_Billing_PharmacyInfo FOREIGN KEY (billingID) REFERENCES PharmacyInfo (Id)

ALTER TABLE BILLING 
WITH NO CHECK ADD CONSTRAINT FK_Billing_ImagingTestInfo FOREIGN KEY (billingID) REFERENCES ImagingTestInfo (Id)