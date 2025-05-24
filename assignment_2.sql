-- Active: 1747467450451@@127.0.0.1@5433@ph

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);


CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) CHECK (conservation_status IN ('Endangered', 'Vulnerable', 'Near Threatened', 'Least Concern')) NOT NULL
);



CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT NOT NULL,
    ranger_id INT NOT NULL,
    location VARCHAR(100) NOT NULL,
    sighting_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (species_id) REFERENCES species(species_id) ON DELETE CASCADE,
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id) ON DELETE CASCADE
);


INSERT INTO rangers (name, region) VALUES 
('Meera Rahman', 'Sundarbans'),
('Rafiq Hossain', 'Chittagong Hill Tracts'),
('Nasima Akter', 'Sylhet Forest Range'),
('Tariq Islam', 'Lawachara National Park'),
('Farhana Yasmin', 'Rangamati Hills'),
('Asif Chowdhury', 'Bandarban Wildlife Zone'),
('Sharmin Jahan', 'Madhupur Sal Forest'),
('Javed Karim', 'Dinajpur Reserved Forest'),
('Rumana Haque', 'Cox’s Bazar Marine Zone'),
('Habibul Bashar', 'Kuakata Coastal Belt');


SELECT * FROM rangers;

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Asian Elephant', 'Elephas maximus', '1758-01-01', 'Endangered'),
('Ganges River Dolphin', 'Platanista gangetica', '1801-01-01', 'Endangered'),
('Hoolock Gibbon', 'Hoolock hoolock', '1837-01-01', 'Endangered'),
('Fishing Cat', 'Prionailurus viverrinus', '1833-01-01', 'Vulnerable'),
('Pangolin', 'Manis crassicaudata', '1822-01-01', 'Endangered'),
('Oriental Pied Hornbill', 'Anthracoceros albirostris', '1801-01-01', 'Near Threatened'),
('Saltwater Crocodile', 'Crocodylus porosus', '1801-01-01', 'Least Concern'),
('Clouded Leopard', 'Neofelis nebulosa', '1821-01-01', 'Vulnerable'),
('Red Junglefowl', 'Gallus gallus', '1758-01-01', 'Least Concern');


SELECT * FROM species;


INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Sundarbans Core Zone', '2025-05-10 06:45:00', 'Tiger tracks found near riverbank'),
(3, 2, 'Padma River Bend', '2025-05-12 14:30:00', 'Dolphin breaching observed by boat patrol'),
(4, 3, 'Lawachara Canopy Trail', '2025-05-13 09:10:00', 'Group of gibbons vocalizing in canopy'),
(2, 4, 'Chittagong Elephant Corridor', '2025-05-15 16:00:00', 'Elephant herd crossing highway safely'),
(5, 5, 'Madhupur Wetlands', '2025-05-16 07:25:00', 'Fishing cat seen hunting at dawn'),
(6, 6, 'Bandarban Hills', '2025-05-17 18:45:00', 'Pangolin spotted near termite mound'),
(7, 7, 'Rangamati Riverbank', '2025-05-18 08:30:00', 'Hornbill pair flying across tree line'),
(8, 8, 'Cox’s Bazar Estuary', '2025-05-19 11:15:00', 'Crocodile basking in muddy creek'),
(9, 9, 'Sundarbans Eastern Block', '2025-05-20 17:00:00', 'Clouded leopard glimpse reported'),
(10, 10, 'Sylhet Village Edge', '2025-05-21 06:00:00', 'Red junglefowl crowing at sunrise');

SELECT * FROM sightings;


-- problem 1

INSERT INTO rangers (name, region) 
VALUES ('Derek Fox', 'Kuakata Coastal Belt');


-- problem 2

SELECT COUNT(DISTINCT species_id) AS "unique species count"
FROM sightings;

-- problem 3

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes)
VALUES (2, 3, 'Last Pass Trail', '2025-05-23 17:20:00', 'Faint tracks found on ridge');

SELECT *
FROM sightings
WHERE location ILIKE '%Pass%';


-- problem 4

SELECT rangers.name, COUNT(sightings.sighting_id) AS "total sightings"
FROM rangers
JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name
ORDER BY "total sightings" DESC;


-- problem 5

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status)
VALUES ('Golden Langur', 'Trachypithecus geei', '1956-01-01', 'Endangered');

SELECT species.common_name
FROM species
LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE sightings.species_id IS NULL;


-- problem 6

SELECT species.common_name,sightings.sighting_time, rangers.name
FROM sightings
JOIN species ON sightings.species_id = species.species_id
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2;


-- problem 7


ALTER TABLE species
DROP CONSTRAINT species_conservation_status_check;

ALTER TABLE species
ADD CONSTRAINT species_conservation_status_check
CHECK (conservation_status IN (
  'Endangered', 'Vulnerable', 'Near Threatened', 'Least Concern', 'Historic'
));


INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Asian Elephant', 'Elephas maximus', '1758-01-01', 'Endangered'),
('Ganges River Dolphin', 'Platanista gangetica', '1801-01-01', 'Endangered'),
('Hoolock Gibbon', 'Hoolock hoolock', '1837-01-01', 'Endangered'),
('Fishing Cat', 'Prionailurus viverrinus', '1833-01-01', 'Vulnerable'),
('Pangolin', 'Manis crassicaudata', '1822-01-01', 'Endangered'),
('Oriental Pied Hornbill', 'Anthracoceros albirostris', '1801-01-01', 'Near Threatened'),
('Saltwater Crocodile', 'Crocodylus porosus', '1801-01-01', 'Least Concern'),
('Clouded Leopard', 'Neofelis nebulosa', '1821-01-01', 'Vulnerable'),
('Red Junglefowl', 'Gallus gallus', '1758-01-01', 'Least Concern');

UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

SELECT * FROM species



-- problem 8
SELECT sighting_id,
    CASE 
        WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sighting_time) >= 12 AND EXTRACT(HOUR FROM sighting_time) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS "time of day"
FROM sightings;


-- problem 9

DELETE FROM rangers
WHERE NOT EXISTS (
    SELECT 1
    FROM sightings
    WHERE sightings.ranger_id = rangers.ranger_id
);

-- or--

DELETE FROM rangers
WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id FROM sightings
);







