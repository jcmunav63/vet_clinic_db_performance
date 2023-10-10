/* Database schema to keep the structure of entire database. */

/* FEATURE BRANCH 02-query-and-update-animals-table */

-- A) ADD a column species of type string to the animals table.
ALTER TABLE animals ADD species character varying(50);


/* FEATURE BRANCH 01-create-animals-table */

CREATE TABLE animals
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    name character varying(100) NOT NULL,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg real
);
