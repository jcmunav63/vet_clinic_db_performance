/*Queries that provide answers to the questions from all projects.*/

/* FEATURE BRANCH 03-querying-mulltiple-tables */

-- H) QUERYING THE TABLES
-- 1) What animals belong to Melody Pond?
SELECT animals.name, owners.full_name FROM animals
JOIN owners ON (animals.owner_id = owners.id 
AND owners.full_name LIKE 'Melody Pond');

-- 2) List of all animals that are pokemon (their type is Pokemon):
SELECT animals.name, species.name FROM animals
JOIN species ON (animals.species_id = species.id 
AND species.name LIKE 'Pokemon');

-- 3) List all owners and their animals, remember to 
--    include those that don't own any animal
SELECT owners.full_name, animals.name FROM owners
LEFT JOIN animals ON (owners.id = animals.owner_id);

-- 4) How many animals are there per species?
SELECT COUNT(animals.name), species.name FROM animals
JOIN species ON (animals.species_id = species.id) GROUP BY species.name;

-- 5) List all Digimon owned by Jennifer Orwell...
SELECT animals.name as animal_name, owners.full_name as owner_name, 
species.name as species 
FROM animals
JOIN owners ON (animals.owner_id = owners.id
AND owners.full_name like 'Jennifer Orwell')
JOIN species ON (animals.species_id = species.id);

-- 6) List all animals owned by Dean Winchester that haven't 
--    tried to escape
SELECT animals.name as animal_name, owners.full_name as owner_name, 
animals.escape_attempts 
FROM animals
JOIN owners ON (animals.owner_id = owners.id
AND owners.full_name like 'Dean Winchester');
-- ALL HIS ANIMALS HAVE TRIED TO ESCAPE

-- 7) Who owns the most animals?
SELECT owners.full_name as owner_name, COUNT(animals.name)
FROM owners
LEFT JOIN animals ON (owners.id = animals.owner_id)
GROUP BY owners.full_name;
-- MELODY POND OWNS THE MOST ANIMALS (3)



/* FEATURE BRANCH 02-query-and-update-animals-table */

-- C) TRANSACTION: Update species column and ROLLBACK
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

-- D) TRANSACTION: Update species column to 'digimon' and 'pokemon'
--    and COMMIT the changes.
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon'
WHERE species IS null;

SELECT * FROM animals;

COMMIT;

-- E) TRANSACTION: DELETE all records from animals table and ROLLBACK changes.
BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;

--F) TRANSACTION: 
--   * Delete all animals born after Jan 1st, 2022;
--   * Create a savepoint for the transaction;
--   * Update all animals' weight to be their weight multiplied by -1;
--   * Rollback to the savepoint;
--   * Update all animals' weights that are negative to be their weight multiplied by -1;
--   * Commit transaction.
BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;

UPDATE animals set weight_kg = (weight_kg * -1);
ROLLBACK TO SP1;

UPDATE animals SET weight_kg = (weight_kg * -1) WHERE weight_kg < 0;
COMMIT;

/* QUERYING THE DATABASE */

-- 1) How many animals are there?
SELECT COUNT(name) FROM animals; --10 ANIMALS

-- 2) How many animals have never tried to escape?
SELECT COUNT(name) FROM animals WHERE (escape_attempts = 0); --2 ANIMALS

-- 3) What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals; -- AVERAGE WEIGHT 15.55 kg

-- 4) Who escapes the most, neutered or non neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
-- NEUTERED ANIMALS ATTEMPTED ESCAPE 20 TIMES, VS NON NEUTERED 4 TIMES.

-- 5) What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg) FROM animals GROUP BY species;
-- MAXIMUM WEIGHT: pokemon 17 kg; digimon 45 kg
SELECT species, MIN(weight_kg) FROM animals GROUP BY species;
-- MINIMUM WEIGHT: pokemon 11 kg; digimon 5.7 kg

-- 6) What is the average number of escape attempts per animal type of
--    those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals
WHERE (date_of_birth > '1989-12-31' AND date_of_birth < '2001-01-01')
GROUP BY species;
-- ONLY POKEMON species averages 3.0 escape attempts.


/* FEATURE BRANCH 01-create-animals-table */

-- a) Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name like '%mon';

-- b) List the name of all animals born between 2016 and 2019.
SELECT id, name FROM animals WHERE (date_of_birth > '2015-12-31' AND date_of_birth < '2020-01-01');

-- c) List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT id, name FROM animals WHERE (neutered=true AND escape_attempts<3);

-- d) List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT id, date_of_birth FROM animals WHERE (name = 'Agumon' OR name = 'Pikachu');

-- e) List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE (weight_kg > 10.5);

-- f) Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

-- g) Find all animals not named Gabumon.
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';

-- h) Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE (weight_kg >= 10.4 AND weight_kg <= 17.3);
