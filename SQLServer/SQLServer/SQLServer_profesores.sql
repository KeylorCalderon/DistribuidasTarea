CREATE DATABASE SQLServer_profesores
GO

USE SQLServer_profesores
GO

CREATE TABLE Profesores(Identificacion INT PRIMARY KEY,
					    nombre VARCHAR(50),
						apellidos VARCHAR(50),
					    telefono INT,
					    correo VARCHAR(50))
GO