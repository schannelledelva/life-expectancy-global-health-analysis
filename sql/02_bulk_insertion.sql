BULK INSERT LifeExpectancy --TableName
FROM 'C:\Path_to_dataset'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
