/* FEATURE BRANCH 04-Add-join-table-for-visits */

-- C) Insert some data into VETS, SPECIALIZATIONS & VISITS tables...

-- C-1) Inserting data into VETS table...
INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('William Tatcher', '45', '2000-04-23'),
('Maisy Smith', '26', '2019-01-17'),
('Stephanie Mendez', '64', '1981-05-04'),
('Jack Harkness', '38', '2008-06-08');

-- C-2) Inserting data into SPECIALIZATIONS table...
INSERT INTO specializations (vet_id, species_id) 
VALUES ((select (id) from vets where name = 'William Tatcher'),
	(select (id) from species where name = 'Pokemon'));

INSERT INTO specializations (vet_id, species_id) 
VALUES ((select (id) from vets where name = 'Stephanie Mendez'),
	(select (id) from species where name = 'Pokemon'));

INSERT INTO specializations (vet_id, species_id) 
VALUES ((select (id) from vets where name = 'Stephanie Mendez'),
	(select (id) from species where name = 'Digimon'));

INSERT INTO specializations (vet_id, species_id) 
VALUES ((select (id) from vets where name = 'Jack Harkness'),
	(select (id) from species where name = 'Digimon'));

-- C-3) Inserting data into VISITS table...



/* FEATURE BRANCH 03-querying-multiple-tables */

-- D) INSERT values into the OWNERS table
INSERT INTO owners (full_name, age) VALUES
('Sam Smith', '34'),
('Jennifer Orwell', '19'),
('Bob', '45'),
('Melody Pond', '77'),
('Dean Winchester', '14'),
('Jodie Whittaker', '38');

-- E) INSERT values into the SPECIES table
INSERT INTO species (name) VALUES
('Pokemon'),
('Digimon');

-- F) INSERT Species IDs into the animals table
UPDATE animals 
SET species_id = (SELECT id from species WHERE name = 'Digimon') 
WHERE name LIKE '%mon';

UPDATE animals 
SET species_id = (SELECT id from species WHERE name = 'Pokemon') 
WHERE species_id is NULL;

-- G) INSERT Owners IDs into the animals table 
-- Sam Smith owns Agumon:
UPDATE animals 
SET owner_id = (SELECT id from owners where full_name = 'Sam Smith') 
WHERE id = 1;
-- Jennifer Orwell owns Gabumon and Pikachu:
UPDATE animals 
SET owner_id = (SELECT id from owners where full_name = 'Jennifer Orwell') 
WHERE id in (2, 3);
-- Bob owns Devimon and Plantmon:
UPDATE animals 
SET owner_id = (SELECT id from owners where full_name = 'Bob') 
WHERE id in (4, 6);
-- Melody Pond owns Charmander, Squirtle, and Blossom:
UPDATE animals 
SET owner_id = (SELECT id from owners where full_name = 'Melody Pond') 
WHERE id in (5, 7, 10);
-- Dean Winchester owns Angemon and Boarmon:
UPDATE animals 
SET owner_id = (SELECT id from owners where full_name = 'Dean Winchester') 
WHERE id in (8, 9);


/* FEATURE BRANCH 02-query-and-update-animals-table */

-- B) INSERT the following data:
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Charmander', '2020-02-08', '0', false, '-11.0'),
('Plantmon', '2021-11-15', '2', true, '-5.7'),
('Squirtle', '1993-04-02', '3', false, '-12.13'),
('Angemon', '2005-06-12', '1', true, '-45.0'),
('Boarmon', '2005-06-07', '7', true, '20.4'),
('Blossom', '1998-10-13', '3', true, '17.0'),
('Ditto', '2022-05-14', '4', true, '22.0');


/* FEATURE BRANCH 01-create-animals-table */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', '0', true, '10.23');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', '2', true, '8.0');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', '1', false, '15.04');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', '5', true, '11.0');
