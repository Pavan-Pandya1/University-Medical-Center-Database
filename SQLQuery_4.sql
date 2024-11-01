CREATE VIEW patientdiagnoses AS
SELECT p.Id, p.FirstName, p.LastName, pr.Diagnosis, pr.CheckInTime
FROM PatientInfo p
INNER JOIN PatientRecords pr ON p.Id = pr.PatientId
WHERE pr.CheckInTime > DATEADD(month, -6, GETDATE())
GO

CREATE VIEW admittedPatientsView AS
SELECT p.Id AS PatientId, p.LastName, p.FirstName, p.DateofBirth, a.AdmitDate, f.FacilityName, f.Street, f.PostalCode, f.City
FROM PatientInfo p
INNER JOIN AdmittedPatients a ON p.Id = a.PatientId
INNER JOIN FacilityInfo f ON a.FacilityId = f.Id;
GO

CREATE VIEW patientweightHeightTrends AS
SELECT pr.PatientId, p.FirstName + ' ' + p.LastName AS PatientName, pr.CheckInTime, pr.PatientWeight, pr.PatientHeight
FROM PatientRecords pr
INNER JOIN PatientInfo p ON pr.PatientId = p.Id
WHERE pr.CheckInTime > DATEADD(month, -12, GETDATE())
GO

CREATE VIEW medicationprescriptionInfo AS
SELECT mi.MedicationName, mi.Refills, mi.DozesPerDay, pi.CurrentStatus, pi.Cost, pi.PharmacyId
FROM MedicationInfo mi
INNER JOIN PrescriptionInfo pi ON mi.PrescriptionId = pi.Id