INSERT INTO PatientInfo (Id
, LastName
, FirstName
, HouseNo
, Street
, PostalCode
, City
, PhoneNumber
, LocationId
, PrimaryCarePhysician
, DateofBirth
, InsuranceNumber
, InsuranceGroupId)
  VALUES (1, 'Sharma', 'Rahul', '1234', 'Hillside Ave', '13210', 'Syracuse', '3155551234', '101', '111', '01-01-1990', '1234567890', 'ABC')
, (2, 'Chopra', 'Neha', '5678', 'Westcott St', '13210', 'Syracuse', '3155555678', '111', '211', '02-14-1992', '0987654321', 'DEF')
, (3, 'Gupta', 'Ankit', '9101', 'Lancaster Ave', '13210', 'Syracuse', '3155559101', '300', '124', '03-20-1994', '1357902468', 'GHI')
, (4, 'Singh', 'Aman', '1212', 'Euclid Ave', '13210', 'Syracuse', '3155551212', '234', '542', '04-15-1996', '2468013579', 'JKL')
, (5, 'Kapoor', 'Amit', '1313', 'Comstock Ave', '13210', 'Syracuse', '3155551313', '871', '276', '05-25-1998', '3692581470', 'MNO')

INSERT INTO PatientRecords (PatientId
, PatientWeight
, PatientHeight
, BloodPressure
, Temperature
, CheckInTime
, CheckOutTime
, LocationId
, Diagnosis
, ProcedureId
, EmployeeId
, PhysicianId
, MedicationId
, ImagingTestId
, LabTestId)
  VALUES (1, 157, 185, 110, 98, '04-30-2023 10:00', '04-30-2023 11:30', 2, 'COVID-19', 3, 21, 2, 4, NULL, 1),
(2, 124, 44, 120, 97, '04-30-2023 13:00', '04-30-2023 13:30', 2, 'Routine Checkup', NULL, 23, 2, NULL, NULL, NULL),
(3, 167, 123, 100, 98, '04-30-2023 14:00', '04-30-2023 14:30', 3, 'Sprained Ankle', 5, 43, 3, 5, 1, 2),
(4, 199, 151, 103, 98, '04-30-2023 15:30', '04-30-2023 16:15', 1, 'Sinus Infection', 2, 45, 1, 4, 2, 3)
INSERT INTO PatientPreScreen (PatientRecordId
, Temperature
, AnySympotoms
, Vaccinated)
  VALUES (1, 98, 1, 0), (1, 97, 1, 0), (2, 98, 1, 0), (5, 98, 1, 1)

INSERT INTO AdmittedPatients (PatientId,
FacilityId,
AdmitDate)
  VALUES (1, 1, '01-01-2021'), (2, 3, '06-05-2021'), (3, 2, '03-04-2020')

INSERT INTO ProcedureInfo (Id
, ProcedureName
, ProcedureDuration
, Cost)
  VALUES (1, 'Compression Wrap', 18, 22)
  , (2, 'COVID-19 Test', 25, 150)
  , (3, 'Sprained Ankle', 175, 300)
  , (4, 'Suturing', 55, 225)
  , (5, 'Appendectomy', 275, 1400)

INSERT INTO MedicationInfo (Id
, PrescriptionId
, MedicationName
, Refills
, DozesPerDay
, Notes)
  VALUES (1, 1, 'Amoxycillin 500mg', 4, 3, NULL)
, (2, 2, 'Ciprofloxacin 400mg', 0, 2, 'Contact in case of any side effects')
, (3, 3, 'Lactulose Solution', 4, 3, NULL)
, (4, 4, 'Paracetamol', 0, 6, 'Every 4 hours')
, (5, 5, 'Naproxen', 10, 4, 'Every 6 hours')

INSERT INTO PrescriptionInfo (Id,
PharmacyId,
Cost,
CurrentStatus)
  VALUES (1, 231, 245, 'Processing')
, (2, 119, 274, 'Waiting Approval')
, (3, 69, 623, 'Ready For Shipment')
, (4, 193, 623, 'Ready For Shipment')
, (5, 76, 623, 'Processed')

INSERT INTO PhysicianInfo (Id,
EmpId,
LicenseNumber,
LocationId,
TakingNewPatients,
Active,
Retired,
Position)
  VALUES (1, 200, '1AB', 456, 1, 1, 0, 'Assistant Professor - Pediatrics'),
(2, 201, '1CD', 789, 1, 1, 0, 'Associate Professor - Cardiology'),
(3, 211, '2EF', 111, 1, 1, 0, 'Associate Professor - Dermatology'),
(4, 251, '5XY', 222, 0, 1, 0, 'Assistant Professor - Pathology'),
(5, 252, '5ZW', 333, 0, 1, 0, 'Assistant Professor - Neurology')

INSERT INTO PhysicianSchedule (PhysicianId,
PatientId,
ScheduleDetails,
NurseId)
  VALUES (2, 1, 1, 3), (2, 1, 2, 3), (3, 2, 3, 5), (5, 5, 4, 5)

INSERT INTO ScheduleDetails (StartTime,
Duration,
FacilityId,
RoomNumber,
EquipmentNeeded)
  VALUES ('04-30-2023 09:00', 90, 1, '1B2', 'MRI MACHINE'),
  ('04-29-2023 14:30', 30, 3, '4C5', NULL),
  ('04-28-2023 12:15', 20, 2, '2E4', NULL),
  ('04-27-2023 11:20', 60, 1, '1F3', 'CT SCANNER')

INSERT INTO LicenseInfo (LicenseNumber,
IssuedBy,
IssuedOn,
ValidTill)
  VALUES ('1WK', 'Cornell University', '07-10-2022', '07-10-2027'),
('2RF', 'Columbia University', '05-05-2021', '05-05-2024'),
('4HA', 'Yale University', '08-15-2022', '08-14-2023'),
('3XJ', 'Harvard University', '11-20-2020', '11-20-2025'),
('6LM', 'Duke University', '02-28-2018', '02-28-2028')

INSERT INTO InsuranceInfo (InsuranceNumber,
IssuedBy,
IssuedOn,
ValidTill,
Copay,
CovergePercentage,
BaseCoverage)
  VALUES (1122343433, 'Anthem', '10-15-2021', '10-15-2022', 30, 85, 175)
, (1322547433, 'Cigna', '09-01-2021', '09-01-2023', 15, 90, 1100)
, (112232554, 'Humana', '02-28-2022', '02-28-2032', 7, 65, 60)
, (221133445, 'Geico', '04-05-2022', '04-05-2023', 1, 80, 85)
, (99877654432, 'Harmony', '06-10-2022', '06-10-2023', 3, 100, 95)


INSERT INTO NurseInfo (Id,
EmpId,
LocationId)
  VALUES (1, 21, 2), (2, 23, 5), (3, 43, 6), (5, 45, 7)

INSERT INTO EmployeeInfo (Id,
LastName,
FirstName,
Street,
PostalCode,
City,
PhoneNumber,
DateofBirth,
Department)
  VALUES (11, 'Kim', 'Ji-hye', 'Oak', '10005', 'New York', '1112223334', '01-01-1995', 'Pediatrics')
  , (13, 'Patel', 'Rohan', 'Cedar', '10007', 'Brooklyn', '1112223444', '02-11-1994', 'Pediatrics')
  , (23, 'Gupta', 'Rajesh', 'Walnut', '13205', 'Syracuse', '2223335555', '11-12-1993', 'Pediatrics')
  , (25, 'Baker', 'Emily', 'Willow', '13205', 'Syracuse', '8779990000', '12-11-1992', 'Pediatrics')
  , (50, 'Park', 'Soo-jin', 'Pine', '10005', 'New York', '3334445555', '12-12-1991', 'Orthopedics')
  , (51, 'Kaya', 'Selim', 'Birch', '13205', 'Syracuse', '5556664444', '07-07-1995', 'Family Medicine')
  , (61, 'Iqbal', 'Farhan', 'Oak', '13205', 'Syracuse', '7775554444', '11-20-1997', 'Family Medicine')
  , (91, 'Garcia', 'Miguel', 'Sumner', '10005', 'New York', '8886665555', '01-01-1995', 'ENT')
  , (92, 'Ahmed', 'Rifat', 'Oak', '10005', 'New York', '8887774444', '12-12-1993', 'Radiology')

INSERT INTO EmployeeBenefits (EmpId,
Salary,
Benefits,
Schedule,
ContractType,
ContractTerms)
  VALUES (25, 72000, 'Healthcare + 10 Paid days off', 'Monday - Friday 9-5', 'Full Time', NULL)
  , (28, 62000, 'Healthcare + 5 Paid days off', 'Monday - Friday 9-5', 'Full Time', NULL)
  , (46, 78000, 'Healthcare', 'Monday - Friday 5-12', 'Full Time', NULL)
  , (48, 92000, 'Healthcare + Dependent Care', 'Monday - Friday 5-12', 'Part Time', NULL)
  , (105, 170000, 'Healthcare + 20 Paid days off', 'Monday - Friday 9-5', 'Full Time', NULL)
  , (109, 140000, 'Healthcare + 20 Paid days off', 'Monday - Friday 9-5', 'Full Time', NULL)
  , (116, 185000, 'Healthcare + 20 Paid days off', 'Monday - Friday 10-8', 'Full Time', NULL)
  , (155, 205000, 'Healthcare + 20 Paid days off', 'Monday - Friday 11-9', 'Full Time', NULL)
  , (156, 215000, 'Healthcare + 20 Paid days off', 'Monday - Friday 7-8', 'Full Time', NULL)

INSERT INTO FacilityInfo (Id,
FacilityName,
Street,
PostalCode,
City,
PhoneNumber)
  VALUES (11, 'Central Hospital', 'Main St', '10016', 'New York', '1113335555'),
  (22, 'Onondaga Medical Center', 'University Ave', '13210', 'Syracuse', '2223334444'),
  (33, 'North Shore Hospital', 'Northern Blvd', '11788', 'Melville', '8889991111')

INSERT INTO FacilityDetails (Id,
FacilityId,
LocationHours,
Departments,
RoomsAvailable,
ICUBeds,
CCUBeds,
TraumaCenterAvailability,
VentilatorsAvailable,
OxygenCylindersAvailable)
  VALUES (201, 1, '9am to 5pm', 'Pediatrics, Cardiology', 60, 80, 15, 8, 180, 88),
(202, 2, '8am to 4pm', 'Orthopedics, Oncology, Family Medicine', 120, 20, 12, 115, 25, 44),
(203, 3, 'All Day', 'Radiology, Neurology', 40, 60, 63, 50, 45, 290)

INSERT INTO PharmacyInfo (Id
, PharmacyName
, LocationHours
, RentalEquipment
, Street
, PostalCode
, City)
  VALUES (121, 'HealthyLife', '9am - 7pm', 'Oxygen Concentrators', 'Main St', '13210', 'Syracuse'),
(223, 'MediMart', '10am - 9pm', 'Oxygen Concentrators, CPAP Machines', 'West Willow', '13210', 'Syracuse'),
(52, 'UrgentCare', '24/7', 'Hospital Beds', 'Parkway', '13210', 'Syracuse'),
(23, 'ConvenientMart', '8am - 10pm', 'N/A', 'South St', '13452', 'Syracuse')

INSERT INTO VisitorInfo (LastName,
FirstName,
Street,
PostalCode,
City,
PhoneNumber,
FacilityId,
PatientId,
CheckInTime,
CheckOutTime,
TemperatureAtCheckin)
  VALUES ('Patel', 'Raj', 'Madison', '13210', 'Syracuse', '2223331312', '2', '1', '04-20-2022 10:10', '04-20-2022 10:25', 98),
  ('Kaur', 'Manpreet', 'Comstock', '13210', 'Syracuse', '5553434241', '1', '2', '04-01-2022 13:10', '04-01-2022 13:35', 98),
  ('Singh', 'Gurpreet', 'Westcott', '13210', 'Syracuse', '888775521', '1', '2', '04-11-2022 14:10', '04-11-2022 14:55', 99)

INSERT INTO LabTestInfo (TestName,
Cost,
PaymentMethod)
  VALUES ('COVID AntiBody', 123, 'Card-Visa'), ('BloodWork-All', 254, 'Cash'), ('NazalSwab', 374, 'Cash')

INSERT INTO LabTestResults (TestId,
Results,
ReportToState,
ReportToCounty)
  VALUES (1, 'Positive Rhino Virus', 0, NULL), (2, 'Normal', 0, NULL), (3, 'negative Rhino Virus', 0, NULL)

INSERT INTO ImagingTestInfo (TestName,
Cost,
PaymentMethod)
  VALUES ('Arm Xray', 234, 'Card - chase'), ('Chest Xray', 424, 'Card - Discover')

INSERT INTO ImagingTestResults (TestId,
Results)
  VALUES (1, 'Congestion'), (2, 'BrokenArm')