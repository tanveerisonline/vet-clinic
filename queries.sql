/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE neutered = true;
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE name != 'Gabumon';


BEGIN;
update animals set species = 'unspecified';
select * from animals;
rollback;
select * from animals;

UPDATE animals set species = 'digimon' where name like '%mon';
select * from animals;
update animals set species = 'pokemon' where species = '';
select * from animals;

BEGIN;
delete from animals;
ROLLBACK;
select * from animals;
=======
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
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

