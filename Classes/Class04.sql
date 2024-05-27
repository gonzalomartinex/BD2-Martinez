CREATE DATABASE IF NOT EXISTS tienda_pelis;
USE tienda_pelis;


DROP TABLE IF EXISTS Categoria;
DROP TABLE IF EXISTS Film_Categoria;
DROP TABLE IF EXISTS Actor;
DROP TABLE IF EXISTS Actor_Pelicula;
DROP TABLE IF EXISTS Tienda;
DROP TABLE IF EXISTS Pelicula;
DROP TABLE IF EXISTS Personal_Tienda;
DROP TABLE IF EXISTS Inventario_Tienda;

CREATE TABLE IF NOT EXISTS Pelicula (
    pelicula_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    duracion INT,
    rating VARCHAR(10),
    special_features VARCHAR(255),
    rental_rate DECIMAL(5,2),
    replacement_cost DECIMAL(5,2)
);

CREATE TABLE IF NOT EXISTS Categoria (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);


CREATE TABLE IF NOT EXISTS Film_Categoria (
    pelicula_id INT,
    categoria_id INT,
    FOREIGN KEY (pelicula_id) REFERENCES Pelicula(pelicula_id),
    FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id),
    PRIMARY KEY (pelicula_id, categoria_id)
);

CREATE TABLE IF NOT EXISTS Actor (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Actor_Pelicula (
    actor_id INT,
    pelicula_id INT,
    FOREIGN KEY (actor_id) REFERENCES Actor(actor_id),
    FOREIGN KEY (pelicula_id) REFERENCES Pelicula(pelicula_id),
    PRIMARY KEY (actor_id, pelicula_id)
);

CREATE TABLE IF NOT EXISTS Tienda (
    tienda_id INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(255),
    ciudad VARCHAR(100),
    pais VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Personal_Tienda (
    personal_id INT AUTO_INCREMENT PRIMARY KEY,
    tienda_id INT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    FOREIGN KEY (tienda_id) REFERENCES Tienda(tienda_id)
);

CREATE TABLE Inventario_Tienda (
    inventario_id INT AUTO_INCREMENT PRIMARY KEY,
    tienda_id INT,
    pelicula_id INT,
    disponible BOOLEAN,
    FOREIGN KEY (tienda_id) REFERENCES Tienda(tienda_id),
    FOREIGN KEY (pelicula_id) REFERENCES Pelicula(pelicula_id)
);

INSERT INTO Pelicula (titulo, duracion, rating, special_features, rental_rate, replacement_cost) 
VALUES 
    ('El Padrino', 175, 'R', 'Comentarios del Director', 2.99, 20.00),
    ('Titanic', 195, 'PG-13', 'Detrás de Escenas', 3.50, 22.50),
    ('El Rey León', 90, 'G', 'Detrás de Escenas', 2.00, 18.00),
    ('Zoolander Fiction', 120, 'PG-13', 'Comentarios del Director', 2.50, 23.00),
    ('La La Land', 128, 'PG-13', 'Detrás de Escenas', 2.75, 21.00);

INSERT INTO Categoria (nombre) VALUES 
    ('Drama'),
    ('Romance'),
    ('Acción'),
    ('Comedia');

INSERT INTO Film_Categoria (pelicula_id, categoria_id) VALUES
    (1, 1),
    (2, 2),
    (3, 1),
    (4, 1),
    (5, 1);

INSERT INTO Actor (nombre, apellido) VALUES 
    ('Al Pacino', 'Pacino'),
    ('Leonardo', 'DiCaprio'),
    ('Kate', 'Winslet'),
    ('Robert', 'De Niro'),
    ('Scarlett', 'Johansson');

INSERT INTO Actor_Pelicula (actor_id, pelicula_id) VALUES
    (1, 1),
    (2, 2),
    (3, 2),
    (4, 4),
    (5, 4);

INSERT INTO Tienda (direccion, ciudad, pais) VALUES 
    ('Calle Principal 123', 'Ciudad de Ejemplo', 'País Ejemplo'),
    ('Avenida Secundaria 456', 'Otra Ciudad', 'Otro País');

INSERT INTO Personal_Tienda (tienda_id, nombre, apellido) VALUES
    (1, 'Juan', 'Pérez'),
    (1, 'María', 'González'),
    (2, 'Pedro', 'Martínez'),
    (2, 'Laura', 'Sánchez');
    
INSERT INTO Inventario_Tienda (tienda_id, pelicula_id, disponible) VALUES
    (1, 1, TRUE),
    (1, 2, TRUE),
    (1, 3, FALSE),
    (2, 2, TRUE),
    (2, 3, TRUE),
    (2, 4, FALSE),
    (2, 5, TRUE);

    
SELECT titulo, special_features
FROM Pelicula
WHERE rating = 'PG-13';

SELECT DISTINCT duracion
FROM Pelicula;

SELECT titulo, rental_rate, replacement_cost
FROM Pelicula
WHERE replacement_cost BETWEEN 20.00 AND 24.00;

SELECT p.titulo, c.nombre AS categoria, p.rating
FROM Pelicula p
JOIN Film_Categoria fc ON p.pelicula_id = fc.pelicula_id
JOIN Categoria c ON fc.categoria_id = c.categoria_id
WHERE p.special_features = 'Detrás de Escenas';


SELECT a.nombre, a.apellido
FROM Actor a
JOIN Actor_Pelicula ap ON a.actor_id = ap.actor_id
JOIN Pelicula p ON ap.pelicula_id = p.pelicula_id
WHERE p.titulo = 'Zoolander Fiction';

SELECT direccion, ciudad, pais
FROM Tienda
WHERE tienda_id = 1;

SELECT p1.titulo AS titulo1, p2.titulo AS titulo2, p1.rating
FROM Pelicula p1, Pelicula p2
WHERE p1.pelicula_id < p2.pelicula_id AND p1.rating = p2.rating;

SELECT p.titulo, pt.nombre AS nombre_gerente, pt.apellido AS apellido_gerente
FROM Pelicula p
JOIN Inventario_Tienda it ON p.pelicula_id = it.pelicula_id
JOIN Tienda t ON it.tienda_id = t.tienda_id
JOIN Personal_Tienda pt ON t.tienda_id = pt.tienda_id
WHERE t.tienda_id = 2 AND it.disponible = TRUE;


