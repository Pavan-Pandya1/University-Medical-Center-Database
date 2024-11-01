CREATE VIEW patientDiagnoses AS
SELECT p.Id, p.FirstName, p.LastName, pr.Diagnosis, pr.CheckInTime
FROM PatientInfo p
INNER JOIN PatientRecords pr ON p.Id = pr.PatientId
WHERE pr.CheckInTime > DATEADD(month, -6, GETDATE())
GO

CREATE VIEW PhysicianNurseSchedules AS
SELECT ps.ScheduleDetails, pi.FirstName + ' ' + pi.LastName AS Physician, ni.Id AS NurseId, ni.FirstName + ' ' + ni.LastName AS Nurse
FROM PhysicianSchedule ps
INNER JOIN PhysicianInfo pi ON ps.PhysicianId = pi.Id
INNER JOIN NurseInfo ni ON ps.NurseId = ni.Id
WHERE CONVERT(date, ps.ScheduleDetails.StartTime) = CONVERT(date, GETDATE())
GO

CREATE VIEW patientWeightHeightTrends AS
SELECT pr.PatientId, p.FirstName + ' ' + p.LastName AS PatientName, pr.CheckInTime, pr.PatientWeight, pr.PatientHeight
FROM PatientRecords pr
INNER JOIN PatientInfo p ON pr.PatientId = p.Id
WHERE pr.CheckInTime > DATEADD(month, -12, GETDATE())
GO

CREATE VIEW medicationPrescriptionInfo AS
SELECT mi.MedicationName, mi.Refills, mi.DozesPerDay, pi.CurrentStatus, pi.Cost, pi.PharmacyId
FROM MedicationInfo mi
INNER JOIN PrescriptionInfo pi ON mi.PrescriptionId = pi.Id

