SELECT 
    OwnerID, 
    FirstName, 
    LastName, 
    Phone, 
    Email
FROM 
    Owner
ORDER BY 
    LastName;

SELECT
    A.AnimalID,
    A.Name AS AnimalName,
    A.Species,
    A.Breed,
    O.FirstName AS OwnerFirstName,
    O.LastName AS OwnerLastName
FROM
    Animal A
JOIN
    Owner O ON A.OwnerID = O.OwnerID
ORDER BY
    A.Name;

SELECT
    A.AppointmentID,
    A.DateTime,
    A.VisitType,
    A.Status,
    AN.Name AS PatientName,
    O.LastName AS OwnerLastName
FROM
    Appointment A
JOIN
    Animal AN ON A.AnimalID = AN.AnimalID
JOIN
    Owner O ON AN.OwnerID = O.OwnerID
WHERE
    A.VetID = 1 
ORDER BY
    A.DateTime;

SELECT
    StaffID,
    FirstName,
    LastName,
    Qualification,
    HireDate
FROM
    Staff
WHERE
    Role = 'Veterinarian'
ORDER BY
    LastName;

SELECT
    A.AppointmentID,
    A.DateTime,
    A.VisitType,
    A.Status,
    T.Diagnosis,
    S.FirstName AS VetFirstName,
    S.LastName AS VetLastName
FROM
    Appointment A
LEFT JOIN
    Treatment T ON A.AppointmentID = T.AppointmentID
JOIN
    Staff S ON A.VetID = S.StaffID
WHERE
    A.AnimalID = 1 
ORDER BY
    A.DateTime DESC;

SELECT
    T.Diagnosis,
    T.Notes,
    PR.Name AS ProcedureName,
    PR.Cost AS ProcedureCost,
    M.DrugName,
    M.Dosage,
    M.Quantity
FROM
    Treatment T
LEFT JOIN
    ProcedureRecord PR ON T.TreatmentID = PR.TreatmentID
LEFT JOIN
    Medication M ON T.TreatmentID = M.TreatmentID
WHERE
    T.TreatmentID = 3;

SELECT
    A.DateTime,
    AN.Name AS Patient,
    O.LastName AS Owner,
    A.VisitType,
    S.LastName AS AssignedVet
FROM
    Appointment A
JOIN
    Animal AN ON A.AnimalID = AN.AnimalID
JOIN
    Owner O ON AN.OwnerID = O.OwnerID
JOIN
    Staff S ON A.VetID = S.StaffID
WHERE
    A.DateTime::date = (CURRENT_DATE + interval '1 day') 
    AND A.Status = 'Scheduled';

SELECT
    I.InvoiceID,
    I.IssueDate,
    I.TotalAmount,
    AN.Name AS Patient,
    A.DateTime AS AppointmentDate
FROM
    Invoice I
JOIN
    Appointment A ON I.AppointmentID = A.AppointmentID
JOIN
    Animal AN ON A.AnimalID = AN.AnimalID
WHERE
    AN.OwnerID = 1;

SELECT
    P.PaymentID,
    P.PaymentDate,
    P.AmountPaid,
    P.Method,
    P.Status
FROM
    Payment P
WHERE
    P.InvoiceID = 3
ORDER BY
    P.PaymentDate;
