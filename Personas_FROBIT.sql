DROP DATABASE IF EXISTS Personas_db;

CREATE DATABASE Personas_db;
USE Personas_db;
-- Crear la tabla Estados
CREATE TABLE Estados (
    Id_Estado INT PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL
);

-- Crear la tabla Personas
CREATE TABLE Personas (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Apellido VARCHAR(50) NOT NULL,
    Nombres VARCHAR(50) NOT NULL,
    DNI VARCHAR(20) NOT NULL UNIQUE,
    Domicilio VARCHAR(100),
    Telefono VARCHAR(20),
    Id_Estado INT,
    FecHora_Registros DATETIME DEFAULT CURRENT_TIMESTAMP,
    FecHora_Modificacion DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (Id_Estado) REFERENCES Estados(Id_Estado)
);
INSERT INTO Estados (Id_Estado, Descripcion)
VALUES (1, 'Activo'), (2, 'Inactivo');

-- Procedimiento para registrar una persona
DELIMITER $$

CREATE PROCEDURE Registrar_Persona(
    IN p_Apellido VARCHAR(50), 
    IN p_Nombres VARCHAR(50), 
    IN p_DNI VARCHAR(20), 
    IN p_Domicilio VARCHAR(100), 
    IN p_Telefono VARCHAR(20), 
    IN p_Id_Estado INT, 
    IN p_FecHora_Registros DATETIME
)
BEGIN
    INSERT INTO Personas (Apellido, Nombres, DNI, Domicilio, Telefono, Id_Estado, FecHora_Registros)
    VALUES (p_Apellido, p_Nombres, p_DNI, p_Domicilio, p_Telefono, p_Id_Estado, p_FecHora_Registros);
END $$

DELIMITER ;

-- Procedimiento para consultar una persona
DELIMITER $$

CREATE PROCEDURE Consultar_Persona(
    IN p_Id INT
)
BEGIN
    SELECT * FROM Personas WHERE Id = p_Id;
END $$

DELIMITER ;

-- Procedimiento para eliminar una persona (baja lógica)
DELIMITER $$

CREATE PROCEDURE Eliminar_Persona(
    IN p_Id INT
)
BEGIN
    UPDATE Personas 
    SET Id_Estado = 2 
    WHERE Id = p_Id;
END $$

DELIMITER ;

-- Procedimiento para actualizar una persona
DELIMITER $$

CREATE PROCEDURE Actualizar_Persona(
    IN p_Id INT,
    IN p_Apellido VARCHAR(50), 
    IN p_Nombres VARCHAR(50), 
    IN p_DNI VARCHAR(20), 
    IN p_Domicilio VARCHAR(100), 
    IN p_Telefono VARCHAR(20), 
    IN p_Id_Estado INT,
    IN p_FecHora_Modificacion DATETIME
)
BEGIN
    UPDATE Personas 
    SET Apellido = p_Apellido, 
        Nombres = p_Nombres, 
        DNI = p_DNI, 
        Domicilio = p_Domicilio, 
        Telefono = p_Telefono, 
        Id_Estado = p_Id_Estado, 
        FecHora_Modificacion = p_FecHora_Modificacion
    WHERE Id = p_Id;
END $$

DELIMITER ;

