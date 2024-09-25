USE sakila;

-- Query 1
-- Crear un usuario llamado data_analyst.

CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY 'password123';
-- Permitir acceso desde cualquier host.
CREATE USER 'data_analyst'@'%' IDENTIFIED BY 'password123';

-- Query 2
-- Otorgar permisos solo para SELECT, UPDATE y DELETE en todas las tablas de la base de datos sakila.

GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';
SHOW GRANTS FOR 'data_analyst'@'localhost';

-- Query 3
-- Iniciar sesión con este usuario e intentar crear una tabla. Mostrar el resultado.

-- Instrucción para iniciar sesión:
-- mysql -u data_analyst -p
-- Después, intentar crear una tabla con el siguiente comando:
CREATE TABLE region (
  region_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  region_name VARCHAR(100) NOT NULL,
  country_id SMALLINT UNSIGNED NOT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (region_id),
  KEY idx_fk_country_id (country_id),
  CONSTRAINT `fk_region_country` FOREIGN KEY (country_id) REFERENCES country (country_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Resultado esperado:
-- ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'region'

-- Query 4
-- Intentar actualizar el título de una película. Escribir el script para realizar la actualización.

SELECT title FROM film WHERE film_id = 254;
UPDATE film SET title='El Teo Cansado de dar Clase (la peli)' WHERE film_id = 254;

-- Respuesta esperada:
-- Query OK, 1 row affected (0.03 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

-- Query 5
-- Con el usuario root o un usuario con privilegios de administrador, revocar el permiso de UPDATE. Escribir el comando.

REVOKE UPDATE ON sakila.* FROM 'data_analyst'@'localhost';
FLUSH PRIVILEGES;

-- Query 6
-- Iniciar sesión nuevamente con el usuario data_analyst e intentar hacer la misma actualización del paso anterior. Mostrar el resultado.

UPDATE film SET title='Marco Aurelio sexto y su caballito de mar' WHERE film_id = 254;

-- Respuesta esperada:
-- ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'
