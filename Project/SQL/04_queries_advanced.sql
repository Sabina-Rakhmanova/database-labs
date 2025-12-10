SELECT
    TO_CHAR(IssueDate, 'YYYY-MM') AS Month,
    COUNT(InvoiceID) AS TotalInvoices,
    SUM(TotalAmount) AS TotalRevenueGenerated
FROM
    Invoice
GROUP BY
    Month
ORDER BY
    Month DESC;

SELECT
    S.StaffID,
    S.FirstName || ' ' || S.LastName AS VeterinarianName,
    S.Qualification,
    COUNT(A.AppointmentID) AS TotalAppointments
FROM
    Staff S
JOIN
    Appointment A ON S.StaffID = A.VetID
WHERE
    S.Role = 'Veterinarian'
GROUP BY
    S.StaffID, S.FirstName, S.LastName, S.Qualification
ORDER BY
    TotalAppointments DESC
LIMIT 1;

SELECT
    Diagnosis,
    COUNT(*) AS DiagnosisCount
FROM
    Treatment
GROUP BY
    Diagnosis
ORDER BY
    DiagnosisCount DESC
LIMIT 5;

SELECT
    Species,
    COUNT(AnimalID) AS TotalAnimals,
    ROUND(AVG(Weight)::numeric, 2) AS AverageWeight_kg
FROM
    Animal
GROUP BY
    Species
ORDER BY
    TotalAnimals DESC;

WITH InvoicePayments AS (
    SELECT
        I.InvoiceID,
        I.TotalAmount,
        COALESCE(SUM(P.AmountPaid), 0) AS TotalPaid
    FROM
        Invoice I
    LEFT JOIN
        Payment P ON I.InvoiceID = P.InvoiceID
    GROUP BY
        I.InvoiceID, I.TotalAmount
)
SELECT
    IP.InvoiceID,
    O.FirstName || ' ' || O.LastName AS Owner,
    A.Name AS Patient,
    IP.TotalAmount,
    IP.TotalPaid,
    (IP.TotalAmount - IP.TotalPaid) AS BalanceDue,
    I.IssueDate
FROM
    InvoicePayments IP
JOIN
    Invoice I ON IP.InvoiceID = I.InvoiceID
JOIN
    Appointment AP ON I.AppointmentID = AP.AppointmentID
JOIN
    Animal A ON AP.AnimalID = A.AnimalID
JOIN
    Owner O ON A.OwnerID = O.OwnerID
WHERE
    (IP.TotalAmount - IP.TotalPaid) > 0 
ORDER BY
    BalanceDue DESC;

SELECT
    'Procedures' AS Category,
    COALESCE(SUM(Cost), 0) AS TotalCost
FROM
    ProcedureRecord
UNION ALL
SELECT
    'Medications' AS Category,
    COALESCE(SUM(M.Quantity * 10.00), 0) AS TotalCost 
FROM
    Medication M;

SELECT
    S.LastName AS VetLastName,
    A.DateTime AS CurrentAppointmentTime,
    LAG(A.DateTime, 1) OVER (PARTITION BY A.VetID ORDER BY A.DateTime) AS PreviousAppointmentTime,
    A.DateTime - LAG(A.DateTime, 1) OVER (PARTITION BY A.VetID ORDER BY A.DateTime) AS TimeSincePrevious
FROM
    Appointment A
JOIN
    Staff S ON A.VetID = S.StaffID
ORDER BY
    VetLastName, CurrentAppointmentTime;

WITH EarliestAppointment AS (
    SELECT
        AnimalID,
        MIN(DateTime) AS FirstVisit
    FROM
        Appointment
    GROUP BY
        AnimalID
)
SELECT
    A.Name AS AnimalName,
    O.LastName AS OwnerName,
    E.FirstVisit,
    (CURRENT_DATE - E.FirstVisit::date) AS DaysAsPatient
FROM
    EarliestAppointment E
JOIN
    Animal A ON E.AnimalID = A.AnimalID
JOIN
    Owner O ON A.OwnerID = O.OwnerID
ORDER BY
    DaysAsPatient DESC
LIMIT 3;
