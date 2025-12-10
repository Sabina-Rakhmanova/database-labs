DROP TABLE IF EXISTS Payment CASCADE;
DROP TABLE IF EXISTS Invoice CASCADE;
DROP TABLE IF EXISTS Medication CASCADE;
DROP TABLE IF EXISTS ProcedureRecord CASCADE;
DROP TABLE IF EXISTS Treatment CASCADE;
DROP TABLE IF EXISTS Appointment CASCADE;
DROP TABLE IF EXISTS Staff CASCADE;
DROP TABLE IF EXISTS Animal CASCADE;
DROP TABLE IF EXISTS Owner CASCADE;

CREATE TABLE Owner (
    OwnerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Address TEXT
);

CREATE TABLE Staff (
    StaffID SERIAL PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Qualification TEXT,
    HireDate DATE NOT NULL DEFAULT CURRENT_DATE,
 
    CONSTRAINT CHK_Staff_Role CHECK (Role IN ('Veterinarian', 'Veterinary Technician', 'Receptionist', 'Manager'))
);

CREATE TABLE Animal (
    AnimalID SERIAL PRIMARY KEY,
    OwnerID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Species VARCHAR(50) NOT NULL,
    Breed VARCHAR(100),
    DOB DATE,
    Weight DECIMAL(5, 2), 
    
    FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    CONSTRAINT CHK_Animal_Species CHECK (Species IN ('Dog', 'Cat', 'Bird', 'Rabbit', 'Reptile', 'Horse', 'Other')),
    
    CONSTRAINT CHK_Animal_DOB CHECK (DOB <= CURRENT_DATE)
);

CREATE TABLE Appointment (
    AppointmentID BIGSERIAL PRIMARY KEY,
    AnimalID INT NOT NULL,
    VetID INT NOT NULL,
    DateTime TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    VisitType VARCHAR(50) NOT NULL,
    DurationInterval INTERVAL NOT NULL DEFAULT '1 hour',
    Status VARCHAR(20) NOT NULL,
    
    FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (VetID) REFERENCES Staff(StaffID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
        
    CONSTRAINT CHK_Appointment_Type CHECK (VisitType IN ('Check-up', 'Surgery', 'Vaccination', 'Emergency', 'Follow-up')),
    
    CONSTRAINT CHK_Appointment_Status CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled', 'No-Show')),

    CONSTRAINT CHK_Appointment_Future CHECK (DateTime > CURRENT_TIMESTAMP)
);

ALTER TABLE Appointment
ADD CONSTRAINT EXCLUDE_Vet_Overlap EXCLUDE USING GIST (
    VetID WITH =,
    TSTZRANGE(DateTime, DateTime + DurationInterval) WITH OVERLAPS
);

CREATE TABLE Treatment (
    TreatmentID BIGSERIAL PRIMARY KEY,
    AppointmentID BIGINT UNIQUE NOT NULL, 
    Diagnosis TEXT NOT NULL,
    Notes TEXT,
    DateCompleted TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ProcedureRecord (
    ProcedureRecordID SERIAL PRIMARY KEY,
    TreatmentID BIGINT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    
    FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID)
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT CHK_Procedure_Cost CHECK (Cost >= 0)
);

CREATE TABLE Medication (
    MedicationID SERIAL PRIMARY KEY,
    TreatmentID BIGINT NOT NULL,
    DrugName VARCHAR(100) NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    PrescriptionDate DATE NOT NULL DEFAULT CURRENT_DATE,
    
    FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID)
        ON DELETE CASCADE ON UPDATE CASCADE,
        
    CONSTRAINT CHK_Medication_Quantity CHECK (Quantity > 0)
);

CREATE TABLE Invoice (
    InvoiceID BIGSERIAL PRIMARY KEY,
    AppointmentID BIGINT UNIQUE NOT NULL, 
    IssueDate DATE NOT NULL DEFAULT CURRENT_DATE,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
        ON DELETE CASCADE ON UPDATE CASCADE,
        
    CONSTRAINT CHK_Invoice_Amount CHECK (TotalAmount >= 0)
);

CREATE TABLE Payment (
    PaymentID BIGSERIAL PRIMARY KEY,
    InvoiceID BIGINT NOT NULL,
    PaymentDate DATE NOT NULL DEFAULT CURRENT_DATE,
    AmountPaid DECIMAL(10, 2) NOT NULL,
    Method VARCHAR(50) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
        
    CONSTRAINT CHK_Payment_Amount CHECK (AmountPaid > 0),
    CONSTRAINT CHK_Payment_Method CHECK (Method IN ('Cash', 'Credit Card', 'Bank Transfer')),
    
    CONSTRAINT CHK_Payment_Status CHECK (Status IN ('Pending', 'Paid', 'Overdue'))
);
