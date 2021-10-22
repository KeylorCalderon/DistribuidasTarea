CREATE DATABASE MySQL_DB;

USE MySQL_DB;

CREATE TABLE Estudiantes(Carnet INT PRIMARY KEY,
						nombre VARCHAR(50),
						apellidos VARCHAR(50),
						telefono INT,
						correo VARCHAR(50));
                        
CREATE TABLE Matriculas(ID INT PRIMARY KEY,
						EstudianteID INT,
						GrupoID INT,
                        FOREIGN KEY (EstudianteID) REFERENCES Estudiante (Carnet));
   
CREATE TABLE Cursos(Codigo VARCHAR(50) PRIMARY KEY,
					nombre VARCHAR(50),
					creditos INT,
                    horasSemanales INT);   
                    
CREATE TABLE Semestres(ID INT PRIMARY KEY,
					temporada INT,
					numero INT,
                    horasSemanales INT);  
   
CREATE TABLE Grupos(ID INT PRIMARY KEY,
					CursoID VARCHAR(50),
					numeroDeGrupo INT,
                    profesorID INT,
                    cupo INT,
                    SemestreID INT,
                    FOREIGN KEY (CursoID) REFERENCES Cursos (Codigo),
                    FOREIGN KEY (SemestreID) REFERENCES Semestres (ID));