GO
CREATE FUNCTION dbo.fnGetPRCost (@PatientRecordId int)
RETURNS money
BEGIN
  RETURN (SELECT
    ISNULL(pi.Cost, 0) + ISNULL(pri.Cost, 0) + ISNULL(lti.Cost, 0) + ISNULL(iti.Cost, 0)
  FROM PatientRecords pr
  LEFT JOIN ProcedureInfo pi
    ON pr.ProcedureId = pi.Id
  LEFT JOIN MedicationInfo mi
    ON pr.MedicationId = mi.Id
  JOIN PrescriptionInfo pri
    ON mi.PrescriptionId = pri.Id
  LEFT JOIN LabTestInfo lti
    ON pr.LabTestId = lti.Id
  LEFT JOIN ImagingTestInfo iti
    ON pr.ImagingTestId = iti.Id
  WHERE pr.Id = @PatientRecordId);
END;
GO


CREATE FUNCTION dbo.fnGetUpdatedCost (@PatientRecordId int
, @Cost money)
RETURNS money
BEGIN
  RETURN (SELECT
    CASE
      WHEN @Cost < BaseCoverage THEN ini.Copay
      ELSE (ini.Copay + (((100 - ini.CovergePercentage) * @Cost) / 100))
    END
  FROM PatientRecords pr
  JOIN PatientInfo pi
    ON pr.PatientId = pi.Id
  JOIN InsuranceInfo ini
    ON pi.InsuranceNumber = ini.InsuranceNumber
  WHERE pr.Id = @PatientRecordId);
END;
GO


CREATE VIEW InvoiceDetails
AS
SELECT
  PatientWeight
, PatientHeight
, BloodPressure
, Temperature
, CheckInTime
, CheckOutTime
, Diagnosis
, ProcedureId
, EmployeeId
, PhysicianId
, MedicationId
, ImagingTestId
, LabTestId
,pi.*
,IssuedBy
,IssuedOn
,ValidTill
,Copay
,CovergePercentage
,BaseCoverage
,ISNULL(dbo.fnGetPRCost(pr.Id), 0) AS Cost
,dbo.fnGetUpdatedCost(pr.Id, ISNULL(dbo.fnGetPRCost(pr.Id), 0)) AS OutOfPocket
FROM PatientRecords pr
JOIN PatientInfo pi
  ON pr.PatientId = pi.Id
JOIN InsuranceInfo ii 
  ON pi.InsuranceNumber = ii.InsuranceNumber
GO


CREATE VIEW BillingSummary as 
SELECT Id as PatientId ,
InsuranceNumber ,
Copay,
CovergePercentage,
BaseCoverage,
Cost ,
OutOfPocket as OutOfPocketCost
from InvoiceDetails
GO


CREATE VIEW PharmacyPrescriptions
AS
SELECT
  phari.*, medi.MedicationName,
  medi.Refills ,
  medi.DozesPerDay,
  medi.Notes,
  Cost,
  CurrentStatus
FROM PrescriptionInfo presi
JOIN PharmacyInfo phari
  ON presi.PharmacyId = phari.Id
JOIN MedicationInfo medi
  ON medi.PrescriptionId = presi.Id
GO


CREATE VIEW PatientVisitDetails
AS
SELECT
  PatientId,
  PatientWeight,
  PatientHeight,
  BloodPressure,
  Temperature,
  CheckInTime,
  CheckOutTime,
  pr.LocationId,
  Diagnosis,
  ProcedureId,
  EmployeeId,
  PhysicianId,
  MedicationId,
  ImagingTestId,
  LabTestId,
  pi.LastName AS PatientLastName,
  pi.FirstName AS PatientFirstName,
  pi.Street AS PatientStreet,
  pi.PostalCode AS PatientPostalCode,
  pi.City AS PatientCity,
  pi.PhoneNumber AS PatientPh,
  PrimaryCarePhysician,
  pi.DateofBirth AS PatientDOB,
  InsuranceNumber,
  ProcedureName,
  ProcedureDuration,
  proi.Cost AS ProcedureCost,
  psyi.EmpId AS PhysicianEmpId,
  LicenseNumber,
  MedicationName,
  Refills,
  DozesPerDay,
  Notes,
  lbti.TestName AS LabTestName,
  lbti.Cost AS LabCost,
  iti.TestName,
  iti.Cost
FROM PatientRecords pr
JOIN PatientInfo pi
  ON pr.PatientId = pi.Id
LEFT JOIN ProcedureInfo proi
  ON proi.Id = pr.ProcedureId
JOIN EmployeeInfo empi
  ON pr.EmployeeId = empi.Id
JOIN PhysicianInfo psyi
  ON psyi.Id = pr.PhysicianId
LEFT JOIN MedicationInfo medi
  ON pr.MedicationId = medi.Id
LEFT JOIN ImagingTestInfo iti
  ON pr.ImagingTestId = iti.Id
LEFT JOIN ImagingTestResults itr
  ON iti.Id = itr.TestId
LEFT JOIN LabTestInfo lbti
  ON pr.LabTestId = lbti.Id
LEFT JOIN LabTestResults lbtr
  ON lbtr.TestId = lbti.Id
GO


CREATE VIEW PhysicianScheduleWithDetails
AS
SELECT
  StartTime,
  Duration,
  FacilityId,
  RoomNumber,
  EquipmentNeeded,
  LicenseNumber,
  TakingNewPatients,
  Active,
  Retired,
  Position,
  ei.LastName AS PhysiscianLastName,
  ei.FirstName AS PhysiscianFirstName,
  ei.Department AS PhysiscianDept,
  ei.PhoneNumber AS PhysiscianPh,
  eni.LastName AS NurseLastName,
  eni.FirstName AS NurseFirstName,
  eni.Department AS NurseDept,
  eni.PhoneNumber AS NursePh,
  pni.LastName AS PatientLastName,
  pni.FirstName AS PatientFirstName,
  pni.Street AS PatientStreet,
  pni.PostalCode AS PatientPostalCode,
  pni.City AS PatientCity,
  pni.PhoneNumber AS PatientPh,
  PrimaryCarePhysician,
  pni.DateofBirth AS PatientDOB,
  InsuranceNumber
FROM PhysicianSchedule ps
JOIN PhysicianInfo pi
  ON ps.PhysicianId = pi.Id
JOIN EmployeeInfo ei
  ON pi.EmpId = ei.Id
JOIN ScheduleDetails sd
  ON ps.ScheduleDetails = sd.Id
JOIN FacilityInfo fi
  ON sd.FacilityId = fi.Id
JOIN NurseInfo ni
  ON ps.NurseId = ni.Id
JOIN EmployeeInfo eni
  ON ni.EmpId = eni.Id
JOIN PatientInfo pni
  ON ps.PatientId = pni.Id
GO


CREATE PROC spUpdateRooms @FacilityId int
AS
  DECLARE @NoOfRooms int
  SELECT
    @NoOfRooms = RoomsAvailable
  FROM FacilityDetails
  WHERE FacilityId = @FacilityId;
  IF @NoOfRooms > 0
  BEGIN
    UPDATE FacilityDetails
    SET RoomsAvailable = (@NoOfRooms - 1)
    WHERE FacilityId = @FacilityId;
  END
  ELSE
    THROW 50010
    , 'Cannot book rooom. No Rooms Available!'
    , 1;
GO


CREATE PROC spUpdateBeds @FacilityId int
AS
  DECLARE @NoOfBeds int
  SELECT
    @NoOfBeds = ICUBeds
  FROM FacilityDetails
  WHERE FacilityId = @FacilityId;
  IF @NoOfBeds > 0
  BEGIN
    UPDATE FacilityDetails
    SET ICUBeds = (@NoOfBeds - 1)
    WHERE FacilityId = @FacilityId;
  END
  ELSE
    THROW 50010
    , 'Cannot book rooom. No Beds Available!'
    , 1;
GO

CREATE PROC spDischargePatient @PatientId int
AS
  DECLARE @FacilityId int,
          @ICUBeds int
  SELECT
    @FacilityId = FacilityId
  FROM AdmittedPatients
  WHERE PatientId = @PatientId;
  SELECT
    @ICUBeds = ICUBeds
  FROM FacilityDetails
  WHERE FacilityId = @FacilityId;
  UPDATE FacilityDetails
  SET ICUBeds = (@ICUBeds + 1)
  WHERE FacilityId = @FacilityId;
  DELETE FROM AdmittedPatients
  WHERE PatientId = @PatientId
GO

CREATE PROC spPrescriptionStatus @PrescriptionId int
, @Status nvarchar(255)
AS
  UPDATE PrescriptionInfo
  SET CurrentStatus = @Status
  WHERE Id = @PrescriptionId;
GO

CREATE TRIGGER dbo.UpdateRoomsAvailable
ON dbo.PhysicianSchedule
AFTER INSERT
AS
BEGIN
  DECLARE @FacId int
  SELECT
    @FacId = FacilityId
  FROM ScheduleDetails s
  JOIN Inserted i
    ON i.ScheduleDetails = s.Id
  EXEC spUpdateRooms @FacilityId = @FacId
END
GO

CREATE TRIGGER dbo.UpdateBedsAvailable
ON dbo.AdmittedPatients
AFTER INSERT
AS
BEGIN
  DECLARE @FacId int
  SELECT
    @FacId = a.FacilityId
  FROM AdmittedPatients a
  JOIN Inserted i
    ON i.Id = a.Id
  EXEC spUpdateBeds @FacilityId = @FacId
END

GO

CREATE ROLE Doctors;
GRANT UPDATE, Insert
    ON AdmittedPatients
    TO Doctors;
GRANT UPDATE, Insert
    ON PatientInfo
    TO Doctors;
GRANT UPDATE
    , INSERT
    ON PatientRecords
    TO Doctors;

GRANT UPDATE
  , INSERT
  ON ImagingTestResults
  TO Doctors;

GRANT UPDATE
  , INSERT
  ON LabTestResults
  TO Doctors;

GRANT UPDATE
  , INSERT
  ON ProcedureInfo
  TO Doctors;

GRANT UPDATE
  , INSERT
  ON MedicationInfo
  TO Doctors;
ALTER ROLE db_datareader ADD MEMBER Doctors;
GO
CREATE ROLE LabAdmin;
GRANT UPDATE, Insert
    ON LabTestInfo
    TO LabAdmin;
GRANT UPDATE, Insert
    ON LabTestResults
    TO LabAdmin;
ALTER ROLE db_datareader ADD MEMBER LabAdmin;
GO
CREATE ROLE Pharmacist;
GRANT UPDATE, Insert
    ON PrescriptionInfo
    TO Pharmacist;
GRANT UPDATE, Insert
    ON MedicationInfo
    TO Pharmacist;
ALTER ROLE db_datareader ADD MEMBER Pharmacist;
GO
CREATE ROLE Nurse;
GRANT UPDATE, Insert
    ON PatientRecords
    TO Nurse;
GRANT UPDATE, Insert
    ON PatientInfo
    TO Nurse;
GRANT UPDATE, Insert
    ON PhysicianSchedule
    TO Nurse;
ALTER ROLE db_datareader ADD MEMBER Nurse;
GO
CREATE LOGIN DoctorLogin
    WITH PASSWORD = 'P@SSW0rd'
        , DEFAULT_DATABASE = UniversityMedicalCenter_;
CREATE USER Doctor1
FOR LOGIN DoctorLogin;
ALTER ROLE Doctors ADD MEMBER Doctor1;
GO
CREATE LOGIN NurseLogin
    WITH PASSWORD = 'P@SSW0rd'
        , DEFAULT_DATABASE = UniversityMedicalCenter_;

CREATE USER Nurse1
FOR LOGIN NurseLogin;
ALTER ROLE Nurse ADD MEMBER Nurse1;
GO
CREATE LOGIN Pharmacy
    WITH PASSWORD = 'Pharmacy'
        , DEFAULT_DATABASE = UniversityMedicalCenter_;
CREATE USER Pharmacist1
FOR LOGIN Pharmacy;
ALTER ROLE Pharmacist ADD MEMBER Pharmacist1;
GO

-- Transaction to Retire Doctor
BEGIN TRAN;

  DECLARE @DoctorFirstName nvarchar(255) = 'Reza',
          @DoctorLastName nvarchar(255) = 'Zaf',
          @ReplacementDoctorLastName nvarchar(255) = 'Shaw',
          @ReplacementDoctorFirstName nvarchar(255) = 'Tom'

  DECLARE @OldDoctorId int

  SELECT
    @OldDoctorId = pi.EmpId
  FROM PhysicianInfo pi
  JOIN EmployeeInfo ei
    ON pi.EmpId = ei.Id
  WHERE ei.FirstName = @DoctorFirstName
  AND ei.LastName = @DoctorLastName

  DECLARE @NewDoctorId int

  SELECT
    @NewDoctorId = pi.EmpId
  FROM PhysicianInfo pi
  JOIN EmployeeInfo ei
    ON pi.EmpId = ei.Id
  WHERE ei.FirstName = @ReplacementDoctorFirstName
  AND ei.LastName = @ReplacementDoctorLastName


  UPDATE PatientInfo
  SET PrimaryCarePhysician = @NewDoctorId
  WHERE PrimaryCarePhysician = @OldDoctorId

  UPDATE PhysicianInfo
  SET Retired = 1,
      TakingNewPatients = 0
  WHERE EmpId = @OldDoctorId;

COMMIT TRAN

-- Transaction to Transfer Prescription To Different Pharmacy
BEGIN TRAN;

  DECLARE @PatientId int = 1,
          @NewPharmacyId int = 52

  UPDATE PrescriptionInfo
  SET PharmacyId = @NewPharmacyId,
      CurrentStatus = 'Processing'
  WHERE Id IN (SELECT
    prei.Id
  FROM PatientRecords pr
  JOIN PatientInfo pi
    ON pr.PatientId = pi.Id
    JOIN MedicationInfo medi
      ON pr.MedicationId = medi.Id
    JOIN PrescriptionInfo prei
      ON medi.PrescriptionId = prei.Id
  WHERE pi.Id = @PatientId
  AND prei.CurrentStatus != 'Processed')
COMMIT TRAN