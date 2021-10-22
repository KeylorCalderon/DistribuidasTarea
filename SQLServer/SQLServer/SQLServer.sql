CREATE DATABASE SQLServer_DB
GO

USE SQLServer_DB
GO

CREATE TABLE Libros (ID INT IDENTITY (1,1) PRIMARY KEY,
					 nombre VARCHAR(50),
					 ISBN VARCHAR(50),
					 autor VARCHAR(50))
GO

CREATE TABLE Planilla(ID INT IDENTITY (1,1) PRIMARY KEY,
					  nombre VARCHAR(50),
					  apellidos VARCHAR(50),
					  telefono INT,
					  correo VARCHAR(50))
GO

CREATE TABLE Prestamos(ID INT IDENTITY (1,1) PRIMARY KEY,
					   IDLibro INT,
					   IDPlanilla INT,
					   EstudianteID INT,
					   FechaInicio DATE,
					   FechaFin DATE,
					   FOREIGN KEY (IDLibro) REFERENCES Libros(ID),
					   FOREIGN KEY (IDPlanilla) REFERENCES Planilla(ID))
GO

CREATE TABLE TipoDeTransaccion(ID INT IDENTITY (1,1) PRIMARY KEY,
							   tipo VARCHAR(50))
GO

CREATE TABLE Financiero(ID INT IDENTITY (1,1) PRIMARY KEY,
					   tipoDeTransaccion INT,
					   monto FLOAT,
					   fechaLimite DATE,
					   pagado BIT,
					   FOREIGN KEY (tipoDeTransaccion) REFERENCES TipoDeTransaccion(ID))
GO

INSERT INTO Libros(nombre, ISBN, autor)
VALUES ('Robinson Crusoe', '9780194227209', 'Daniel Defoe'),
  	   ('Frankestein', '9780205533091', 'Mary Shelley'),
	   ('El principito', '9788854409842', 'Antoine de Saint-Exupéry');
GO

INSERT INTO Planilla(nombre, apellidos, telefono, correo)
VALUES ('Morshu', 'Beatbox', 81928129, 'Morshu123@gmail.com'),
  	   ('Jeimy', 'Morales', 72182912, 'JMorales@outlook.com');
GO

INSERT INTO Prestamos(IDLibro, IDPlanilla, EstudianteID, FechaInicio, FechaFin)
VALUES (1, 1, 1234, '11-10-2021', '20-10-2021'),
  	   (2, 2, 1234, '10-10-2021', '26-10-2021'),
	   (3, 1, 5678, '12-10-2021', '15-10-2021');
GO

INSERT INTO TipoDeTransaccion(tipo)
VALUES ('Devolución'),
  	   ('Préstamo');
GO

INSERT INTO Financiero(tipoDeTransaccion, monto, fechaLimite, pagado)
VALUES (1, 9850.00, '26-10-2021', 1),
  	   (2, 10650.00, '15-10-2021', 0);