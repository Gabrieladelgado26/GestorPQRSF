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

CREATE TABLE tipoSolicitud(
	idTipoSolicitud INT PRIMARY KEY AUTO_INCREMENT,
    tipoSolicitud VARCHAR(20)
);

INSERT INTO tipoSolicitud(tipoSolicitud)
VALUES ('Petición'),
	   ('Queja'),
       ('Reclamo'),
       ('Sugerencia'),
	   ('Felicitacion');

-- Crear la tabla solicitud para definir el tipo de solicitud
CREATE TABLE solicitud(
	idSolicitud INT PRIMARY KEY AUTO_INCREMENT,  -- Identificador único autoincremental
    idUsuario INT,
    idTipoSolicitud INT,
    fecha DATE,
    descripcion TEXT, -- Descripción de la solicitud (opcional si la persona subio un archivo)
    archivo VARCHAR(100), -- Archivo (opcional si la descripción esta llena
    estado VARCHAR(20),
    FOREIGN KEY (idUsuario) REFERENCES usuarios(idUsuario) ON DELETE SET NULL, -- Llave foránea
    FOREIGN KEY (idTipoSolicitud) REFERENCES tipoSolicitud(idTipoSolicitud) ON DELETE SET NULL -- Llave foránea
);

INSERT INTO usuarios(nombre, apellido, cedula, telefono, correo, idRol)
VALUES ('Gabriela', 'Delgado', '1081053738', '3114882004', 'gabrieladelgadoc07@gmail.com', 1);

DELIMITER //

CREATE PROCEDURE agregarUsuario(
    IN p_nombre VARCHAR(150),
    IN p_apellido TEXT,
    IN p_cedula VARCHAR(20),
    IN p_telefono VARCHAR(20),
    IN p_correo INT,
    IN p_idRol INT
)
BEGIN
    INSERT INTO usuarios(nombre, apellido, cedula, telefono, correo, idRol)
	VALUES (p_nombre, p_apellido, p_cedula, p_telefono, p_correo, p_idRol);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE agregarSolicitud(
    IN p_idUsuario INT,
    IN p_idTipoSolicitud INT,
    IN p_fecha DATE,
    IN p_descripcion TEXT,
    IN p_archivo VARCHAR(100),
    IN p_estado VARCHAR(20)
)
BEGIN
    INSERT INTO solicitud(idUsuario, idTipoSolicitud, fecha, descripcion, archivo, estado)
	VALUES (p_idUsuario, p_idTipoSolicitud, p_fecha, p_descripcion, p_archivo, p_estado);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE editarEstadoSolicitud(
    IN idSolicitudParam INT,
    IN nuevoEstado VARCHAR(100)
)
BEGIN
    UPDATE solicitud
    SET 
        estado = nuevoEstado
    WHERE 
        idSolicitud = idSolicitudParam;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE eliminarSolicitud(IN solicitud_id INT)
BEGIN
    DELETE FROM solicitud WHERE idSolicitud = solicitud_id;
END //

DELIMITER ;