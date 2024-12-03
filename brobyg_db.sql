-- 1. Opret en unik database
DROP DATABASE IF EXISTS unik_database;
CREATE DATABASE unik_database;

-- 2. Skift til den nye database
USE unik_database;

-- 3. Opret den første tabel (Parent Table)
CREATE TABLE person (
    person_id INT AUTO_INCREMENT PRIMARY KEY, -- Primær nøgle
    navn VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    oprettet_dato DATE DEFAULT CURRENT_DATE
);

-- 4. Opret den anden tabel (Child Table), med en Fremmed Nøgle (FK) relation til person
CREATE TABLE ordre (
    ordre_id INT AUTO_INCREMENT PRIMARY KEY, -- Primær nøgle
    person_id INT, -- Fremmed nøgle
    produkt VARCHAR(50) NOT NULL,
    antal INT NOT NULL,
    ordre_dato DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (person_id) REFERENCES person(person_id) -- FK relation
    ON DELETE CASCADE -- Slet ordrer, når en person slettes
    ON UPDATE CASCADE -- Opdater person_id automatisk
);

-- 5. Indsæt testdata i 'person'
INSERT INTO person (navn, email) VALUES 
('Maria', 'maria@example.com'), 
('Jens', 'jens@example.com');

-- 6. Indsæt testdata i 'ordre'
INSERT INTO ordre (person_id, produkt, antal) VALUES 
(1, 'Bog', 3), 
(2, 'T-shirt', 1);

-- 7. Hent data fra begge tabeller for at teste relationen
SELECT person.navn, ordre.produkt, ordre.antal
FROM person
JOIN ordre ON person.person_id = ordre.person_id;
