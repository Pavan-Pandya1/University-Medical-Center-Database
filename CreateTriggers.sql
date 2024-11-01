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

CREATE TRIGGER tr_PatientPreScreen_Insert
ON PatientPreScreen
AFTER INSERT
AS
BEGIN
  UPDATE PatientRecords
  SET Temperature = i.Temperature,
      Diagnosis = CASE WHEN i.AnySymptoms = 1 THEN 'Requires further screening' ELSE r.Diagnosis END
  FROM PatientRecords r
  INNER JOIN inserted i ON r.Id = i.PatientRecordId
  WHERE r.CheckOutTime IS NULL;
END
GO

CREATE TRIGGER tr_PhysicianInfo_UniqueLicenseNumber
ON PhysicianInfo
AFTER INSERT, UPDATE
AS
BEGIN
  IF EXISTS (
    SELECT 1
    FROM PhysicianInfo p
    JOIN inserted i ON p.Id != i.Id AND p.LicenseNumber = i.LicenseNumber
  )
  BEGIN
    RAISERROR('Cannot insert or update physician record with duplicate license number.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
END
