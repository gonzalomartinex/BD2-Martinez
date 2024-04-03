CREATE DATABASE IF NOT EXISTS imdb;

USE imdb;

DROP TABLE IF EXISTS film_actor;
DROP TABLE IF EXISTS actor;
DROP TABLE IF EXISTS film;


CREATE TABLE IF NOT EXISTS actor (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    primer_nombre VARCHAR(50),
    apellido VARCHAR(50),
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS film (
    film_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion TEXT,
    ano_lanzamiento INT
);

CREATE TABLE IF NOT EXISTS film_actor (
    actor_id INT,
    film_id INT,
    PRIMARY KEY (actor_id, film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

INSERT INTO actor (primer_nombre, apellido) VALUES
    ('Diego', 'Peretti'),
    ('Guillermo', 'Francella'),
    ('Ricardo', 'Darín'),
    ('Luis', 'Brandoni');

INSERT INTO film (titulo, descripcion, ano_lanzamiento) VALUES
    ('Los Simuladores', 'Una serie de televisión argentina sobre un grupo de personas que resuelven problemas a través de simulaciones', 2002),
    ('El Robo del Siglo', 'Una comedia policial argentina basada en el robo al Banco Río de Acassuso', 2020),
    ('El Secreto de Sus Ojos', 'Un drama policial argentino sobre un crimen sin resolver y un amor no correspondido', 2009);

INSERT INTO film_actor (actor_id, film_id) VALUES
    (1, 1), -- Diego Peretti en Los Simuladores
    (2, 1), -- Guillermo Francella en Los Simuladores
    (1, 2), -- Diego Peretti en El Robo del Siglo
    (2, 2), -- Guillermo Francella en El Robo del Siglo
    (3, 3), -- Ricardo Darín en El Secreto de Sus Ojos
    (4, 3); -- Luis Brandoni en El Secreto de Sus Ojos

