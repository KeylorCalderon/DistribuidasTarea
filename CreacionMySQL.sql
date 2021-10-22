CREATE DATABASE MySQL_DB;

USE MySQL_DB;

CREATE TABLE Estudiantes(Carnet INT PRIMARY KEY,
						nombre VARCHAR(50),
						apellidos VARCHAR(50),
						telefono INT,
						correo VARCHAR(50));
   
CREATE TABLE Cursos(Codigo VARCHAR(50) PRIMARY KEY,
					nombre VARCHAR(50),
					creditos INT,
                    horasSemanales INT);   

CREATE TABLE Semestres(ID INT PRIMARY KEY AUTO_INCREMENT,
					temporada INT,
					numero INT);  
                    
CREATE TABLE Grupos(ID INT PRIMARY KEY AUTO_INCREMENT,
					CursoID VARCHAR(50),
					numeroDeGrupo INT,
                    profesorID INT,
                    cupo INT,
                    SemestreID INT,
                    FOREIGN KEY (CursoID) REFERENCES Cursos (Codigo),
                    FOREIGN KEY (SemestreID) REFERENCES Semestres (ID));

CREATE TABLE Matriculas(ID INT PRIMARY KEY AUTO_INCREMENT,
						EstudianteID INT,
						GrupoID INT,
                        FOREIGN KEY (EstudianteID) REFERENCES Estudiantes (Carnet),
                        FOREIGN KEY (GrupoID) REFERENCES Grupos (ID));
                    
INSERT INTO Estudiantes(Carnet, nombre, apellidos, telefono, correo)
VALUES (1234, 'Keylor', 'Calderón Vega', 72125875, 'koiscal71@hotmail.com'),
  	   (5678, 'Sisi', 'Brenes Brenes', 49239423, 'sisi920@gmail.com'),
	   (8901, 'Juan', 'Perez Solano', 291822111, 'juanPS@gmail.com');
       
INSERT INTO Cursos(Codigo, nombre, creditos, horasSemanales)
VALUES ('12012-IC', 'Introducción a la programación', 4, 8),
  	   ('10010-IC', 'Taller de programación', 5, 12);
       
INSERT INTO Semestres(temporada, numero)
VALUES (2020, 1),
  	   (2020, 2),
       (2021, 1),
       (2021, 2);

INSERT INTO Grupos(CursoID, numeroDeGrupo, profesorID, cupo, SemestreID)
VALUES ('12012-IC', 1, 1, 15, 3),
	   ('12012-IC', 2, 2, 25, 3),
	   ('10010-IC', 1, 2, 12, 3),
	   ('10010-IC', 2, 1, 5, 3);
       
INSERT INTO Matriculas(EstudianteID, GrupoID)
VALUES (1234, 1),
  	   (1234, 2),
	   (5678, 3);