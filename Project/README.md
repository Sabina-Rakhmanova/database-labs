# 🐾 Vet Clinic Management System (VCMS) — Database Project

## 📌 Project Overview
This repository contains the final project for the **Database Management Systems** course.  
The project implements a complete **Relational Database** for a **Vet Clinic Management System (VCMS)**.

The system is designed to support daily operations of a veterinary clinic, including:

- patient (animal) registration  
- owner management  
- appointment scheduling  
- medical records  
- treatments and prescriptions  
- billing and payments  
- veterinarian workloads  

The database is built using **PostgreSQL 17** and demonstrates proficiency in:

✔️ SQL schema design  
✔️ Referential integrity & constraints  
✔️ Complex queries and analytics  
✔️ Transactions & indexing  
✔️ Realistic workflow modeling  

---

## 🛠️ Core Database Functionality

### 1️⃣ Animal Management
- Stores animal details (species, breed, age, weight).  
- Each animal is linked to an owner.

### 2️⃣ Owner & Contact Management
- Stores full owner information and contact details.

### 3️⃣ Appointment Scheduling
- Manages appointment dates, types, statuses.  
- Assigns veterinarians to appointments.

### 4️⃣ Veterinarian & Staff Management
- Stores staff roles, qualifications, and work schedules.  
- Tracks which vet handled each appointment.

### 5️⃣ Medical Records & Treatments
Includes:
- diagnoses  
- prescriptions  
- vaccinations  
- procedures  
- lab test results  

All connected to appointments.

### 6️⃣ Billing & Payments
- Tracks treatment costs and medicine charges.  
- Generates invoices and stores payment details.  

### 7️⃣ Integrity & Validation
Implemented using:
- PRIMARY KEY  
- FOREIGN KEY  
- CHECK constraints  
- Cascading relationships  

---

## 📁 Repository Structure & Execution Guide

All SQL scripts must be run **in order**:

| File | Title | SQL Focus | Demonstrates |
|------|--------|-------------|--------------|
| `01_schema_creation.sql` | Schema Creation (DDL) | Table creation, PK & FK | Creates all core tables and constraints |
| `02_data_insertion.sql` | Data Insertion (DML) | Insert statements | Populates realistic test data |
| `03_queries_basic.sql` | Basic Queries | CRUD operations | Select owners, animals, appointments |
| `04_queries_advanced.sql` | Advanced SQL | Aggregates, CTEs, Window functions | Revenue reports, vet workload, diagnosis frequency |
| `05_transactions_and_indexes.sql` | Transactions & Indexes | ACID, performance | ROLLBACK examples, `CREATE INDEX`, EXPLAIN ANALYZE |

---

## 🧰 Technology Stack
- **DBMS:** PostgreSQL 17  
- **Admin Tool:** pgAdmin 4  
- **Version Control:** GitHub  

---

## 📚 Key Business Rules
- Every animal must belong to an owner.  
- Each appointment must have a veterinarian.  
- Payment status must be one of: `Pending`, `Paid`, `Overdue`.  
- No overlapping appointments for the same vet (validated via SQL logic).  

---

## 🚀 How to Use
1. Clone the repository  
2. Open pgAdmin  
3. Run files `01` → `05` in order  
4. Execute queries to test functionality  
5. Use for development, UI integration, or further study  

---

## 👩‍⚕️ Summary
The VCMS is a fully designed relational database that models a realistic veterinary clinic.  

---


