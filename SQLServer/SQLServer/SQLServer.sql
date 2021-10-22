CREATE DATABASE SQLServer_DB
GO

USE SQLServer_DB
GO

CREATE TABLE Libros (ID INT PRIMARY KEY,
					 nombre VARCHAR(50),
					 ISBN VARCHAR(50),
					 autor VARCHAR(50))
GO

CREATE TABLE Planilla(ID INT PRIMARY KEY,
					  nombre VARCHAR(50),
					  apellidos VARCHAR(50),
					  telefono INT,
					  correo VARCHAR(50))
GO

CREATE TABLE Prestamos(ID INT PRIMARY KEY,
					   IDLibro INT,
					   IDPlanilla INT,
					   EstudianteID INT,
					   FechaInicio DATE,
					   FechaFin DATE,
					   FOREIGN KEY (IDLibro) REFERENCES Libros(ID),
					   FOREIGN KEY (IDPlanilla) REFERENCES Planilla(ID))
GO

CREATE TABLE TipoDeTransaccion(ID INT PRIMARY KEY,
							   tipo VARCHAR(50))
GO

CREATE TABLE Financiero(ID INT PRIMARY KEY,
					   tipoDeTransaccion INT,
					   monto FLOAT,
					   fechaLimite DATE,
					   pagado BIT,
					   FOREIGN KEY (tipoDeTransaccion) REFERENCES TipoDeTransaccion(ID))
GO