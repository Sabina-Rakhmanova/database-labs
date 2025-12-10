CREATE INDEX idx_appointment_datetime ON Appointment (DateTime);

CREATE INDEX idx_animal_ownerid ON Animal (OwnerID);

CREATE INDEX idx_staff_role ON Staff (Role);

CREATE INDEX idx_invoice_issuedate ON Invoice (IssueDate);

BEGIN;

INSERT INTO Appointment (AnimalID, VetID, DateTime, VisitType, Status) VALUES
(
    1, 
    3, 
    CURRENT_DATE + interval '7 days' + interval '15 hours', 
    'Vaccination',
    'Scheduled'
);

COMMIT;

BEGIN;

UPDATE Appointment
SET 
    Status = 'Completed',
    DateTime = CURRENT_TIMESTAMP - interval '1 hour' 
WHERE 
    AppointmentID = 4;

INSERT INTO Treatment (AppointmentID, Diagnosis, Notes) VALUES
(
    4,
    'Cyst removal (Routine surgery).',
    'Procedure successful. Patient recovered well from anesthesia. Owner advised on aftercare.'
);

SELECT currval('treatment_treatmentid_seq') INTO temp_treatment_id;

INSERT INTO ProcedureRecord (TreatmentID, Name, Cost) VALUES
(temp_treatment_id, 'Cyst Removal Surgery', 350.00),
(temp_treatment_id, 'Anesthesia Monitoring (1hr)', 100.00);

INSERT INTO Medication (TreatmentID, DrugName, Dosage, Quantity) VALUES
(temp_treatment_id, 'Buprenorphine', '0.02mg/kg', 3);

WITH CalculatedCost AS (
    SELECT 
        SUM(Cost) AS ProcedureCosts 
    FROM ProcedureRecord 
    WHERE TreatmentID = temp_treatment_id
)
INSERT INTO Invoice (AppointmentID, IssueDate, TotalAmount) VALUES
(
    4,
    CURRENT_DATE,
    (SELECT ProcedureCosts FROM CalculatedCost) + 150.00 
);

INSERT INTO Payment (InvoiceID, PaymentDate, AmountPaid, Method, Status) VALUES
(
    currval('invoice_invoiceid_seq'), 
    CURRENT_DATE,
    0.00, 
    'Credit Card', 
    'Pending'
);

COMMIT;

SELECT
    A.DateTime,
    A.Status AS ApptStatus,
    T.Diagnosis,
    I.TotalAmount AS InvoiceTotal,
    P.Status AS PaymentStatus
FROM
    Appointment A
JOIN
    Treatment T ON A.AppointmentID = T.AppointmentID
JOIN
    Invoice I ON A.AppointmentID = I.AppointmentID
JOIN
    Payment P ON I.InvoiceID = P.InvoiceID
WHERE
    A.AppointmentID = 4;
