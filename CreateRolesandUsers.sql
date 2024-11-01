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
        , DEFAULT_DATABASE = UniversityMedicalCenter;
CREATE USER Doctor1
FOR LOGIN DoctorLogin;
ALTER ROLE Doctors ADD MEMBER Doctor1;
GO
CREATE LOGIN NurseLogin
    WITH PASSWORD = 'P@SSW0rd'
        , DEFAULT_DATABASE = UniversityMedicalCenter;

CREATE USER Nurse1
FOR LOGIN NurseLogin;
ALTER ROLE Nurse ADD MEMBER Nurse1;
GO
CREATE LOGIN Pharmacy
    WITH PASSWORD = 'Pharmacy'
        , DEFAULT_DATABASE = UniversityMedicalCenter;
CREATE USER Pharmacist1
FOR LOGIN Pharmacy;
ALTER ROLE Pharmacist ADD MEMBER Pharmacist1;
GO