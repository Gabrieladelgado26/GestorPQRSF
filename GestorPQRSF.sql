-- Verifica si la base de datos "Gestor_PQRS" existe
SELECT IF(EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'Gestor_PQRSF'), 'exists', 'not_exists') AS db_status;

-- Si la base de datos no existe, créala
CREATE DATABASE IF NOT EXISTS Gestor_PQRSF;

-- Selecciona la base de datos recién creada para realizar operaciones en ella
USE Gestor_PQRSF;

-- Crear la tabla solicitud para definir el tipo de solicitud
CREATE TABLE solicitud(
	idSolicitud INT PRIMARY KEY AUTO_INCREMENT,  -- Identificador único autoincremental
    solicitud VARCHAR(20)
);

-- Crear la tabla roles para denifir el rol de la persona
CREATE TABLE roles(
	idRol INT PRIMARY KEY AUTO_INCREMENT,  -- Identificador único autoincremental
    rol VARCHAR(20)
);

-- Crea la tabla 'Personas' para almacenar a los usuarios
CREATE TABLE Personas(
    idPersona INT PRIMARY KEY AUTO_INCREMENT,  -- Identificador único autoincremental
    nombre VARCHAR(150), -- Nombre de la persona
	apellido VARCHAR(150), -- Apellido de la persona
    cedula VARCHAR(20), -- Cédula de la persona
    telefono VARCHAR(20), -- Telefono de la persona
    correo VARCHAR(200), -- Correo de la persona
    idSolicitud INT, -- Tipo de solicitud de la persona
    descripcion TEXT, -- Descripción de la solicitud (opcional si la persona subio un archivo)
    archivo VARCHAR(100), -- Archivo (opcional si la descripción esta llena
    FOREIGN KEY (idSolicitud) REFERENCES solicitud(idSolicitud) ON DELETE SET NULL -- Llave foránea
);