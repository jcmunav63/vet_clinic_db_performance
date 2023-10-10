/*Queries that provide answers to the questions from all projects.*/

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
