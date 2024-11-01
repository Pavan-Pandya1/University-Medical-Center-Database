USE master
GO
IF DB_ID('universityMedicalCenter') IS NOT NULL
  DROP DATABASE universityMedicalCenter;
GO
CREATE DATABASE universityMedicalCenter;
GO