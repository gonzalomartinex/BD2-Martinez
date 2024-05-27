-- Crear la base de datos
CREATE DATABASE IF NOT exists CABFLY;

-- Usar la base de datos recién creada
USE CABFLY;

CREATE TABLE IF NOT exists Tipo_documento (
    id_tipo_documento INT PRIMARY KEY,
    tipo_doc INT,
    descripcion VARCHAR(255)
);

CREATE TABLE IF NOT exists DNI (
    num_dni INT PRIMARY KEY,
    nombres VARCHAR(255),
    apellidos VARCHAR(255),
    direccion VARCHAR(255),
    fecha_nacimiento DATE,
    id_tipo_documento INT,
    FOREIGN KEY (id_tipo_documento) REFERENCES Tipo_documento(id_tipo_documento)
);

CREATE TABLE IF NOT exists Ciudad (
    id_ciudad INT PRIMARY KEY,
    nombre VARCHAR(255),
    provincia VARCHAR(255),
    descripcion VARCHAR(255)
);

CREATE TABLE IF NOT exists Puerta (
    id_puerta INT PRIMARY KEY,
    descripcion VARCHAR(255)
);

-- Tabla Aeronave
CREATE TABLE IF NOT exists Aeronave (
    id_aeronave INT PRIMARY KEY,
    nombre VARCHAR(255),
    descripcion VARCHAR(255)
);

-- Tabla Bancos
CREATE TABLE IF NOT exists Bancos (
    id_banco INT PRIMARY KEY,
    nombre VARCHAR(255),
    descripcion VARCHAR(255),
    mail VARCHAR(255)
);

CREATE TABLE IF NOT exists Pasajero (
    id_pasajero INT PRIMARY KEY,
    mail VARCHAR(255),
    num_telefono VARCHAR(255),
    DNI INT,
    FOREIGN KEY (DNI) REFERENCES DNI(num_dni)
);

CREATE TABLE IF NOT exists Aeropuerto (
    id_aeropuerto INT PRIMARY KEY,
    nombre VARCHAR(255),
    id_ciudad INT,
    descripcion VARCHAR(255),
    FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad)
);

CREATE TABLE IF NOT exists Vuelo (
    id_vuelo INT PRIMARY KEY,
    fechayhora_salida DATETIME,
    fechayhora_llegada DATETIME,
    precio INT,
    hora_embarque DATETIME,
    id_aeropuerto_salida INT,
    id_aeropuerto_llegada INT,
    id_puerta INT,
    id_avion INT,
    FOREIGN KEY (id_aeropuerto_salida) REFERENCES Aeropuerto(id_aeropuerto),
    FOREIGN KEY (id_aeropuerto_llegada) REFERENCES Aeropuerto(id_aeropuerto),
    FOREIGN KEY (id_puerta) REFERENCES Puerta(id_puerta),
    FOREIGN KEY (id_avion) REFERENCES Aeronave(id_aeronave)
);

CREATE TABLE IF NOT exists Reserva (
    id_reserva INT PRIMARY KEY,
    fecha_hora_emision VARCHAR(255),
    id_pasajero INT,
    id_vuelo INT,
    FOREIGN KEY (id_pasajero) REFERENCES Pasajero(id_pasajero),
    FOREIGN KEY (id_vuelo) REFERENCES Vuelo(id_vuelo)
);

CREATE TABLE IF NOT exists Asiento (
    id_asiento INT PRIMARY KEY,
    ocupado BOOLEAN,
    nombre VARCHAR(255),
    descripcion VARCHAR(255),
    precio INT,
    id_vuelo INT,
    FOREIGN KEY (id_vuelo) REFERENCES Vuelo(id_vuelo)
);

-- Tabla Pasaje
CREATE TABLE IF NOT exists Pasaje (
    id_pasaje INT PRIMARY KEY,
    precio_vuelo INT,
    precio_asiento INT,
    tarjeta INT,
    fechayhora DATETIME,
    id_vuelo INT,
    id_pasajero INT,
    id_asiento INT,
    id_banco INT,
    FOREIGN KEY (id_vuelo) REFERENCES Vuelo(id_vuelo),
    FOREIGN KEY (id_pasajero) REFERENCES Pasajero(id_pasajero),
    FOREIGN KEY (id_asiento) REFERENCES Asiento(id_asiento),
    FOREIGN KEY (id_banco) REFERENCES Bancos(id_banco)
);
