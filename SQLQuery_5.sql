EXEC spUpdateRooms @FacilityId = 1;
GO

EXEC spUpdateBeds @FacilityId = 1;
GO

EXEC spDischargePatient @PatientId = 100;
GO

EXEC spPrescriptionStatus @PrescriptionId = 1, @Status = 'Completed';
GO
