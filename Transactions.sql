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


