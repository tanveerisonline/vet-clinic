/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT name FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT name FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Query to update and read the animals table data */
BEGIN;
SELECT species FROM animals; -- verify original values
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals; -- verify changes made
ROLLBACK;
SELECT species FROM animals; -- verify that change was rolled back
COMMIT;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT species from animals; -- verify that change was made

COMMIT;
SELECT species from animals; -- verify that change persists after commit

BEGIN;
DELETE FROM animals WHERE species = 'unspecified';
SELECT COUNT(*) FROM animals; -- verify that the delete occurred

ROLLBACK;
SELECT COUNT(*) FROM animals; -- verify that the rollback happened

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT here;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO here;
UPDATE animals
SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/* Query to select animals table data with specific condition and also count them */
SELECT COUNT() FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT ROUND(AVG(weight_kg)::numeric, 2) FROM animals;
SELECT name FROM animals
WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);
SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals GROUP BY species;
SELECT species, ROUND(AVG(escape_attempts)::numeric, 0) FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

/* Query to verify changes made before and after the commit */
BEGIN;
SELECT species from animals; -- verify original values
UPDATE animals SET species = 'test';
SELECT species from animals; -- verify changes made
ROLLBACK;
SELECT species from animals; -- verify that change was rolled back
COMMIT;
SELECT species from animals; -- verify that change persists after commit
