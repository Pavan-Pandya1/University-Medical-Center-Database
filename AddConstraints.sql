
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
