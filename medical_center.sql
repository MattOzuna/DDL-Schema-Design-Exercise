DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\c medical_center

CREATE TABLE medical_center (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    medical_center_id INTEGER REFERENCES medical_center ON DELETE SET NULL
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    medical_center_id INTEGER REFERENCES medical_center ON DELETE SET NULL
);

CREATE TABLE diagnoses (
    patient_id INTEGER REFERENCES patients ON DELETE CASCADE,
    doctor_id INTEGER REFERENCES doctors ON DELETE SET NULL,
    diagnosis TEXT NOT NULL
);

