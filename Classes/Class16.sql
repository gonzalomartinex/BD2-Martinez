Use sakila;

-- 1

-- Cuando intentas insertar un nuevo empleado con un valor NULL en la columna de email, 
-- el resultado depende de cómo esté configurada esa columna:

-- 		Si el campo email permite NULL: La inserción se hará sin problemas, 
--  	y el nuevo empleado se agregará con el valor NULL en el campo de email.

-- 		Si el campo email no permite NULL (tiene una restricción NOT NULL): La inserción fallará, 
-- 		y recibirás un mensaje de error como ERROR 1048 (23000): Column 'email' cannot be null.

DROP TABLE employee;

CREATE TABLE IF NOT EXISTS employee (
    employeeNumber INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    hire_date DATE NOT NULL,
    job_title VARCHAR(50) NOT NULL
);

INSERT INTO employee (first_name, last_name, email, hire_date, job_title) VALUES 
('Teo', 'Reyna', NULL, CURDATE(), 'Tester de Pelis'),
('Reyna', 'Teodoro', NULL, CURDATE(), 'Girador de CDs'),
('Yo', 'posta soy yo man', NULL, CURDATE(), 'Ser yo');

SELECT * FROM employee;

-- 2

-- Esta consulta disminuye el valor de employeeNumber en 20 para todos los empleados en la tabla employees. 
-- Esto podría hacer que algunos valores de employeeNumber se vuelvan negativos o que se repitan con otros 
-- valores ya existentes, dependiendo de cómo esté la tabla. Si hay una restricción UNIQUE en employeeNumber, 
-- esto podría causar un error porque dos empleados no pueden tener el mismo número si este campo es único.

-- EVITAR ERROR DE SAFE MODE -> Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

SET SQL_SAFE_UPDATES = 0;

UPDATE employee SET employeeNumber = employeeNumber - 20;

SELECT employeeNumber FROM employee;

UPDATE employee SET employeeNumber = employeeNumber + 20;

SELECT employeeNumber FROM employee;

SET SQL_SAFE_UPDATES = 1;

-- 3

ALTER TABLE employee ADD COLUMN age INT CHECK (age BETWEEN 16 AND 70);

-- EVITAR ERROR DE SAFE MODE -> Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

SET SQL_SAFE_UPDATES = 0;

UPDATE employee SET age = CASE
	WHEN first_name = 'Teo' AND last_name = 'Reyna' THEN 22
    WHEN first_name = 'Reyna' AND last_name = 'Teodoro' THEN 24
    ELSE null
END;

SET SQL_SAFE_UPDATES = 1;

SELECT employeeNumber, first_name, last_name, age FROM employee;

-- 4

-- film_actor es una tabla de relacion la cual contiene informacion de las tablas film y actor a traves de sus primary keys
-- film_actor tiene "film_actor.film_id" sacada de "film.film_id" y lo mismo para actor, "film_actor.actor_id" sacado de "actor.actor_id"


-- 5

ALTER TABLE employee ADD COLUMN lastUpdate DATETIME;


CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employee
FOR EACH ROW
SET NEW.lastUpdate = NOW();


CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employee
FOR EACH ROW
SET NEW.lastUpdate = NOW();


ALTER TABLE employee ADD COLUMN lastUpdateUser VARCHAR(50);


CREATE TRIGGER before_employee_insert_user
BEFORE INSERT ON employee
FOR EACH ROW
SET NEW.lastUpdate = NOW(), NEW.lastUpdateUser = CURRENT_USER();


CREATE TRIGGER before_employee_update_user
BEFORE UPDATE ON employee
FOR EACH ROW
SET NEW.lastUpdate = NOW(), NEW.lastUpdateUser = CURRENT_USER();

-- 6

SHOW TRIGGERS LIKE 'film_text';

SHOW CREATE TRIGGER trigger_name;

-- no hay triggers que se ejecuten al cargar o modificar la tabla film_text.
-- Si quieren triggers para esa tabla habría que crearlos según las necesidades específicas de la aplicación o el esquema de datos.

SHOW TRIGGERS;
