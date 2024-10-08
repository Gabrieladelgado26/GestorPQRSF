-- Verifica si la base de datos "Gestor_PQRS" existe
DROP DATABASE IF EXISTS gestor_PQRSF;

-- Si la base de datos no existe, créala
CREATE DATABASE IF NOT EXISTS gestor_PQRSF;

-- Selecciona la base de datos recién creada para realizar operaciones en ella
USE gestor_PQRSF;

-- Crea la tabla 'usuarios' para almacenar a los usuarios
CREATE TABLE usuarios(
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,  -- Identificador único autoincremental
    nombre VARCHAR(150), -- Nombre de la persona
	apellido VARCHAR(150), -- Apellido de la persona
    cedula VARCHAR(20), -- Cédula de la persona
    telefono VARCHAR(20), -- Telefono de la persona
    correo VARCHAR(200), -- Correo de la persona
    contrasena VARCHAR(20), 
    rol ENUM('Administrador', 'Usuario')
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
	   ('Felicitación');

-- Crear la tabla solicitud para definir el tipo de solicitud
CREATE TABLE solicitud(
	idSolicitud INT PRIMARY KEY AUTO_INCREMENT,  -- Identificador único autoincremental
    idUsuario INT,
    idTipoSolicitud INT,
    fecha DATE,
    descripcion TEXT, -- Descripción de la solicitud (opcional si la persona subio un archivo)
    archivo VARCHAR(100), -- Archivo (opcional si la descripción esta llena
    respuesta TEXT,
    estado VARCHAR(20),
    FOREIGN KEY (idUsuario) REFERENCES usuarios(idUsuario) ON DELETE SET NULL, -- Llave foránea
    FOREIGN KEY (idTipoSolicitud) REFERENCES tipoSolicitud(idTipoSolicitud) ON DELETE SET NULL -- Llave foránea
);

INSERT INTO usuarios(nombre, apellido, cedula, telefono, correo, contrasena, rol)
VALUES ('Administrador', 'Sistema', '1081053738', '3114882004', 'gabrieladelgadoc07@gmail.com', '123', 'Administrador');

DELIMITER //

CREATE PROCEDURE agregarUsuario(
    IN p_nombre VARCHAR(150),
    IN p_apellido TEXT,
    IN p_cedula VARCHAR(20),
    IN p_telefono VARCHAR(20),
    IN p_correo VARCHAR(200),
    IN p_contrasena VARCHAR(20),
    IN p_rol ENUM('Administrador', 'Usuario')
)
BEGIN
    INSERT INTO usuarios(nombre, apellido, cedula, telefono, correo, contrasena, rol)
	VALUES (p_nombre, p_apellido, p_cedula, p_telefono, p_correo, p_contrasena, p_rol);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE editarUsuario(
    IN p_idUsuario INT,
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_telefono VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_rol ENUM('Administrador', 'Usuario')
)
BEGIN
    UPDATE usuarios
    SET nombre = p_nombre, apellido = p_apellido, telefono = p_telefono, correo = p_correo, rol = p_rol
    WHERE idUsuario = p_idUsuario;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE eliminarUsuario(
    IN p_idUsuario INT
)
BEGIN
    DELETE FROM usuarios WHERE idUsuario = p_idUsuario;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE agregarSolicitud(
    IN p_idUsuario INT,
    IN p_idTipoSolicitud INT,
    IN p_fecha DATE,
    IN p_descripcion TEXT,
    IN p_archivo VARCHAR(100),
    IN p_respuesta TEXT,
    IN p_estado VARCHAR(20)
)
BEGIN
    INSERT INTO solicitud(idUsuario, idTipoSolicitud, fecha, descripcion, archivo, respuesta, estado)
	VALUES (p_idUsuario, p_idTipoSolicitud, p_fecha, p_descripcion, p_archivo, p_respuesta, p_estado);
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

DELIMITER //
CREATE PROCEDURE editarSolicitud(
    IN p_idSolicitud INT,
    IN p_idTipoSolicitud INT,
    IN p_fecha DATE,
    IN p_descripcion VARCHAR(255),
    IN p_archivo VARCHAR(100)
)
BEGIN
    UPDATE solicitud
    SET idTipoSolicitud = p_idTipoSolicitud, fecha = p_fecha, descripcion = p_descripcion, archivo = p_archivo
    WHERE idSolicitud = p_idSolicitud;
END //
DELIMITER ;