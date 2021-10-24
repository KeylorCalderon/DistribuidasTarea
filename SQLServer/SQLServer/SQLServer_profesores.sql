CREATE DATABASE SQLServer_profesores_Central
GO

USE SQLServer_profesores_profesores_Central
GO

CREATE TABLE Profesores(Identificacion INT PRIMARY KEY,
					    nombre VARCHAR(50),
						apellidos VARCHAR(50),
					    telefono INT,
					    correo VARCHAR(50))
GO

INSERT INTO Profesores(Identificacion, nombre, apellidos, telefono, correo)
VALUES (1, 'Cristofer', 'Bonilla Valverde', 97875444, 'Bonilla@gmail.com'),
  	   (2, 'Gustavo', 'Valera Soto', 3266444, 'GV87@gmail.com');
GO
-----------------------------------------------------------
CREATE DATABASE SQLServer_profesores_SanCarlos
GO

USE SQLServer_profesores_profesores_SanCarlos
GO

CREATE TABLE Profesores(Identificacion INT PRIMARY KEY,
					    nombre VARCHAR(50),
						apellidos VARCHAR(50),
					    telefono INT,
					    correo VARCHAR(50))
GO

INSERT INTO Profesores(Identificacion, nombre, apellidos, telefono, correo)
VALUES (18766, 'Among', 'Sus Brenes', 87544, 'ASaE@gmail.com');
GO
-----------------------------------------------------------
CREATE DATABASE SQLServer_profesores_Alajuela
GO

USE SQLServer_profesores_profesores_Alajuela
GO

CREATE TABLE Profesores(Identificacion INT PRIMARY KEY,
					    nombre VARCHAR(50),
						apellidos VARCHAR(50),
					    telefono INT,
					    correo VARCHAR(50))
GO

INSERT INTO Profesores(Identificacion, nombre, apellidos, telefono, correo)
VALUES (87334, 'Natalie', 'Aguilar Lolo', 9888877, 'Nat07@gmail.com');
GO
-----------------------------------------------------------
CREATE DATABASE SQLServer_profesores_Limon
GO

USE SQLServer_profesores_profesores_Limon
GO

CREATE TABLE Profesores(Identificacion INT PRIMARY KEY,
					    nombre VARCHAR(50),
						apellidos VARCHAR(50),
					    telefono INT,
					    correo VARCHAR(50))
GO

INSERT INTO Profesores(Identificacion, nombre, apellidos, telefono, correo)
VALUES (9918766, 'Manuel', 'Vega Solano', 84433, 'ManiLO@gmail.com');
GO
-----------------------------------------------------------
CREATE DATABASE SQLServer_profesores_SanJose
GO

USE SQLServer_profesores_profesores_SanJose
GO

CREATE TABLE Profesores(Identificacion INT PRIMARY KEY,
					    nombre VARCHAR(50),
						apellidos VARCHAR(50),
					    telefono INT,
					    correo VARCHAR(50))
GO

INSERT INTO Profesores(Identificacion, nombre, apellidos, telefono, correo)
VALUES (888124, 'Andres', 'Redondo Acuña', 83346544, 'ARedondo.AE@gmail.com');
GO
-----------------------------------------------------------