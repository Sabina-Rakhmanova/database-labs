INSERT INTO Owner (FirstName, LastName, Phone, Email, Address) VALUES
(
    'Aizada',
    'Rakhmanova',
    '996-777-123456', 
    'aizada.r@centralasia.kg',
    '34 Toktogul St, Bishkek, Kyrgyzstan'
),
(
    'Temirlan',
    'Bekov',
    '7701-987654',
    't.bekov@steppesmail.kz',
    '15 Abay Ave, Almaty, Kazakhstan'
),
(
    'Gulnara',
    'Musaeva',
    '998-90-5551122', 
    'gulnara.musaeva@vetmail.uz',
    '10 Chüy Prospect, Osh, Kyrgyzstan'
),
(
    'Bektur',
    'Asanov',
    '996-550-333777',
    'bektur.a@mountainvet.kg',
    '7 Jibek Jolu, Karakol, Kyrgyzstan'
);

INSERT INTO Staff (FirstName, LastName, Role, Qualification, HireDate) VALUES
(
    'Dr. Aigerim',
    'Sultanova',
    'Veterinarian',
    'DVM, Equine and Small Ruminant Specialist',
    '2018-05-15'
),
(
    'Dr. Nurlan',
    'Asylbek',
    'Veterinarian',
    'DVM, Exotics and Wildlife Medicine',
    '2020-09-01'
),
(
    'Dr. Jyldyz',
    'Tursunova',
    'Veterinarian',
    'DVM, General Practice',
    '2022-01-10'
),
(
    'Dinara',
    'Kydyrova',
    'Veterinary Technician',
    'Certified Veterinary Nurse (CVN)',
    '2019-11-20'
),
(
    'Ermek',
    'Zhumaliev',
    'Manager',
    'MBA, Clinic Operations',
    '2017-02-01'
);

INSERT INTO Animal (OwnerID, Name, Species, Breed, DOB, Weight) VALUES
(1, 'Bars', 'Dog', 'Shepherd (Kuchi mix)', '2019-03-20', 38.0),      
(2, 'Shumkar', 'Bird', 'Saker Falcon', '2021-08-10', 1.2),      
(3, 'Tash', 'Reptile', 'Desert Tortoise', '2020-01-01', 0.95),   
(1, 'Botokoz', 'Cat', 'Siberian Cat', '2022-05-01', 5.1),       
(4, 'Tulpar', 'Horse', 'New Kirghiz', '2015-11-05', 450.0);   


INSERT INTO Appointment (AnimalID, VetID, DateTime, VisitType, Status, DurationInterval) VALUES
(
    1,
    1, 
    CURRENT_DATE - interval '10 days' + interval '10 hours',
    'Check-up',
    'Completed',
    '1 hour'
),
(
    2, 
    2, 
    CURRENT_DATE - interval '5 days' + interval '14 hours',
    'Vaccination',
    'Completed',
    '30 minutes'
),
(
    5, 
    3, 
    CURRENT_DATE - interval '1 day' + interval '9 hours 30 minutes',
    'Emergency',
    'Completed',
    '1 hour 30 minutes'
);

INSERT INTO Appointment (AnimalID, VetID, DateTime, VisitType, Status) VALUES
(
    4, 
    1, 
    CURRENT_DATE + interval '3 days' + interval '11 hours',
    'Surgery',
    'Scheduled'
);

INSERT INTO Appointment (AnimalID, VetID, DateTime, VisitType, Status) VALUES
(
    3, 
    2, 
    CURRENT_DATE + interval '3 days' + interval '14 hours',
    'Check-up',
    'Scheduled'
);


INSERT INTO Treatment (AppointmentID, Diagnosis, Notes, DateCompleted) VALUES
(
    1, 
    'Routine checkup, early hip dysplasia detected.',
    'Started anti-inflammatory and joint supplement protocol. Advised on exercise routine.',
    CURRENT_DATE - interval '10 days' + interval '11 hours'
),
(
    2, 
    'Routine vaccination against Pox. Excellent feather condition.',
    'Discussed optimal diet and weight maintenance for a hunting bird.',
    CURRENT_DATE - interval '5 days' + interval '14 hours 30 minutes'
),
(
    3, 
    'Colic suspected. Stabilized with fluids and mild analgesic.',
    'Observed for 4 hours. Owner advised on feed changes and daily movement.',
    CURRENT_DATE - interval '1 day' + interval '11 hours'
);

INSERT INTO ProcedureRecord (TreatmentID, Name, Cost) VALUES
(3, 'Equine Rectal Exam', 80.00),
(3, 'IV Fluid Administration (Colic Protocol)', 240.00);

INSERT INTO Medication (TreatmentID, DrugName, Dosage, Quantity, PrescriptionDate) VALUES
(1, 'Meloxicam', '7.5mg daily', 30, CURRENT_DATE - interval '10 days'),
(1, 'Omega-3 Supplement', 'One capsule daily', 60, CURRENT_DATE - interval '10 days');

INSERT INTO Medication (TreatmentID, DrugName, Dosage, Quantity, PrescriptionDate) VALUES
(3, 'Flunixin Meglumine (Banamine)', 'IV injection', 1, CURRENT_DATE - interval '1 day');

INSERT INTO Invoice (AppointmentID, IssueDate, TotalAmount) VALUES
(1, CURRENT_DATE - interval '10 days', 160.00); 

INSERT INTO Payment (InvoiceID, PaymentDate, AmountPaid, Method, Status) VALUES
(1, CURRENT_DATE - interval '10 days', 160.00, 'Cash', 'Paid');

INSERT INTO Invoice (AppointmentID, IssueDate, TotalAmount) VALUES
(2, CURRENT_DATE - interval '5 days', 75.00); 

INSERT INTO Invoice (AppointmentID, IssueDate, TotalAmount) VALUES
(3, CURRENT_DATE - interval '30 days', 650.00); 

INSERT INTO Payment (InvoiceID, PaymentDate, AmountPaid, Method, Status) VALUES
(3, CURRENT_DATE - interval '29 days', 500.00, 'Bank Transfer', 'Paid');

INSERT INTO Payment (InvoiceID, PaymentDate, AmountPaid, Method, Status) VALUES
(3, CURRENT_DATE, 150.00, 'Credit Card', 'Overdue');
