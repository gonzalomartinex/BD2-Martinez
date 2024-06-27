use Chinook;

-- Mostrar las pistas(Track) cuya cantidad de playlists 
-- sea mayor al promedio de cantidad de playlists por 
-- pista, ademas mostrar la cantidad de playlist por 
-- Pista y una lista con los nombres de las playlists

Select t.Trackid, count(t.Trackid) as cant_playlist, group_concat(p.Name) as Playlist
From Track t 
inner join PlaylistTrack pt USING (Trackid) 
inner join Playlist p using (Playlistid)
group by pt.Trackid
having cant_playlist > (
	Select AVG(cant_playlist) 
    from (select count(pt.Trackid) as cant_playlist 
    From Track t left join PlaylistTrack pt on t.Trackid = pt.Trackid 
    group by pt.Trackid) as a);


Select AVG(cant_playlist) from (select count(pt.Trackid) as cant_playlist From Track t left join PlaylistTrack pt on t.Trackid = pt.Trackid group by pt.Trackid) as a;

select count(pt.Trackid) as cant_playlist From Track t left join PlaylistTrack pt on t.Trackid = pt.Trackid group by pt.Trackid;

select * from Track;



-- Obtener los pares de clientes que compartan nombre, 
-- solo considerar los cliente que residen en USA, 
-- mostrar los apellidos y las direcciones de residencia

Select c.Customerid, c.FirstName, c.LastName, c.Address, c2.Customerid, c2.FirstName, c2.LastName, c2.Address, c.Country
FROM Customer c 
INNER JOIN Customer c2 ON c.FirstName = c2.FirstName
Where c.Customerid > c2.Customerid AND c.Country = 'USA';

-- Listar todas las facturas(Invoice) cuyo total no sea ni 
-- el maximo ni el minimo ademas deben ser de los clientes 
-- con estos nombre: Astrid, Daan, Kathy, Frank

SELECT i.Total, c.FirstName
FROM Invoice i
INNER JOIN Customer c USING (Customerid)
WHERE i.Total != (select MIN(i2.Total) FROM Invoice i2) 
and i.Total != (select MAX(i2.Total) FROM Invoice i2)
and (
	c.FirstName LIKE 'Astrid' 
    OR c.FirstName LIKE 'Daan' 
    OR c.FirstName LIKE 'Kathy' 
    OR c.FirstName LIKE 'Frank');

select MIN(i2.Total), MAX(i2.Total)  FROM Invoice i2;


DROP DATABASE IF EXISTS prueba;
CREATE database prueba;

use prueba;

create table Estudiantes(
	id_estudiante INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(10),
	CONSTRAINT PK_estudiante PRIMARY KEY (id_estudiante)
);

create table Cursos(
	id_curso INT NOT NULL AUTO_INCREMENT,
	nombre_curso VARCHAR(10),
	CONSTRAINT PK_curso PRIMARY KEY (id_curso)
);

create table Matriculas(
	id_estudiante INT,
	id_curso INT,
	CONSTRAINT FK_id_estudiante FOREIGN KEY (id_estudiante) REFERENCES Estudiantes (id_estudiante),
	CONSTRAINT FK_id_curso FOREIGN KEY (id_curso) REFERENCES Cursos (id_curso)
);


INSERT INTO Estudiantes (nombre) VALUES ('marcos');
INSERT INTO Estudiantes (nombre) VALUES ('juan');
INSERT INTO Estudiantes (nombre) VALUES ('pepe');
INSERT INTO Estudiantes (nombre) VALUES ('yo');
INSERT INTO Estudiantes (nombre) VALUES ('wallie');
INSERT INTO Estudiantes (nombre) VALUES ('toto');
INSERT INTO Estudiantes (nombre) VALUES ('nene');
INSERT INTO Estudiantes (nombre) VALUES ('manso');

INSERT INTO Cursos (nombre_curso) VALUES ('A');
INSERT INTO Cursos (nombre_curso) VALUES ('B');
INSERT INTO Cursos (nombre_curso) VALUES ('C');

INSERT INTO Matriculas (id_estudiante, id_curso) VALUES (1, 1);
INSERT INTO Matriculas (id_estudiante, id_curso) VALUES (2, 3);
INSERT INTO Matriculas (id_estudiante, id_curso) VALUES (3, 1);
INSERT INTO Matriculas (id_estudiante, id_curso) VALUES (4, 2);
INSERT INTO Matriculas (id_estudiante, id_curso) VALUES (5, 2);
INSERT INTO Matriculas (id_estudiante, id_curso) VALUES (6, 1);
INSERT INTO Matriculas (id_estudiante, id_curso) VALUES (7, 1);
INSERT INTO Matriculas (id_estudiante, id_curso) VALUES (8, 1);


-- ¿Cuál de las siguientes consultas SQL mostrará una lista concatenada de los 
-- nombres de los estudiantes matriculados en el curso con id_curso = 1, separados por comas?


SELECT GROUP_CONCAT(nombre) AS estudiantes_matriculados  
FROM Estudiantes JOIN Matriculas ON Estudiantes.id_estudiante = Matriculas.id_estudiante 
WHERE Matriculas.id_curso = 1;

-- nota final 10

