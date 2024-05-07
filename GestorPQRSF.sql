-- Verifica si la base de datos "Gestor_PQRS" existe
DROP DATABASE IF EXISTS gestor_PQRSF;

-- Si la base de datos no existe, créala
CREATE DATABASE IF NOT EXISTS gestor_PQRSF;

-- Selecciona la base de datos recién creada para realizar operaciones en ella
USE gestor_PQRSF;

-- Crea la tabla 'roles' para almacenar a los usuarios
CREATE TABLE roles(
	idRol INT PRIMARY KEY AUTO_INCREMENT,  -- Identificador único autoincremental
    rol VARCHAR(20)
);

-- Roles definidas anteriormente
INSERT INTO roles(rol) 
    VALUES ('Administrador'),
		   ('Usuario');

-- Crea la tabla 'usuarios' para almacenar a los usuarios
CREATE TABLE usuarios(
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,  -- Identificador único autoincremental
    nombre VARCHAR(150), -- Nombre de la persona
	apellido VARCHAR(150), -- Apellido de la persona
    cedula VARCHAR(20), -- Cédula de la persona
    telefono VARCHAR(20), -- Telefono de la persona
    correo VARCHAR(200), -- Correo de la persona
    idRol INT,
    FOREIGN KEY (idRol) REFERENCES roles(idRol) ON DELETE SET NULL -- Llave foránea
);

-- Crear la tabla solicitud para definir el tipo de solicitud
CREATE TABLE solicitud(
	idSolicitud INT PRIMARY KEY AUTO_INCREMENT,  -- Identificador único autoincremental
    idUsuario INT,
    tipoSolicitud VARCHAR(20),
    fecha DATE,
    descripcion TEXT, -- Descripción de la solicitud (opcional si la persona subio un archivo)
    archivo VARCHAR(100), -- Archivo (opcional si la descripción esta llena
    FOREIGN KEY (idUsuario) REFERENCES usuarios(idUsuario) ON DELETE SET NULL -- Llave foránea
);

INSERT INTO usuarios(nombre, apellido, cedula, telefono, correo, idRol)
VALUES ('Gabriela', 'Delgado', '1081053738', '3114882004', 'gabrieladelgadoc07@gmail.com', 1)