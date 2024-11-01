CREATE FUNCTION dbo.CalculateAge(@DOB datetime)
RETURNS INT
AS
BEGIN
    DECLARE @Age INT
    SET @Age = DATEDIFF(YEAR, @DOB, GETDATE())
    IF (DATEADD(YEAR, @Age, @DOB) > GETDATE())
        SET @Age = @Age - 1
    RETURN @Age
END
GO

CREATE FUNCTION dbo.ConcatenateName(@FirstName nvarchar(50), @LastName nvarchar(50))
RETURNS nvarchar(101)
AS
BEGIN
    DECLARE @FullName nvarchar(101)
    SET @FullName = @FirstName + ' ' + @LastName
    RETURN @FullName
END

GO

CREATE FUNCTION dbo.CalculateWorkingDays(@StartDate datetime, @EndDate datetime)
RETURNS INT
AS
BEGIN
    DECLARE @WorkingDays INT
    SET @WorkingDays = 0
    WHILE @StartDate <= @EndDate
    BEGIN
        IF (DATENAME(dw, @StartDate) NOT IN ('Saturday', 'Sunday'))
            SET @WorkingDays = @WorkingDays + 1
        SET @StartDate = DATEADD(day, 1, @StartDate)
    END
    RETURN @WorkingDays
END
GO

CREATE FUNCTION dbo.SplitString(@String nvarchar(max), @Delimiter nvarchar(1))
RETURNS @Result TABLE (Value nvarchar(max))
AS
BEGIN
    DECLARE @Pos INT
    WHILE CHARINDEX(@Delimiter, @String) > 0
    BEGIN
        SET @Pos = CHARINDEX(@Delimiter, @String)
        INSERT INTO @Result (Value) VALUES (SUBSTRING(@String, 1, @Pos-1))
        SET @String = SUBSTRING(@String, @Pos+1, LEN(@String))
    END
    IF LEN(@String) > 0
        INSERT INTO @Result (Value) VALUES (@String)
    RETURN
END
