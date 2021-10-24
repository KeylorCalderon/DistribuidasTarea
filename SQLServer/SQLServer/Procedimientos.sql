USE SQLServer_DB
GO

CREATE PROCEDURE consultaLibros
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				L.nombre, L.ISBN, L.autor
			FROM
				Libros L;
		END TRY
		BEGIN CATCH
			SELECT 'ERROR EN LA OPERACIÓN: '+ERROR_MESSAGE();
		END CATCH
		SET NOCOUNT OFF;
	END
GO

CREATE PROCEDURE prestamosActivos

	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT 
				Libro, Estudiante, Empleado
			FROM
			(SELECT
				L.nombre AS Libro,
				P.UsuarioID AS EstudianteID,
				Pl.nombre AS Empleado
			FROM
				Prestamos P,
				Libros L,
				Planilla Pl
			WHERE
				P.IDLibro=L.ID AND
				P.IDPlanilla=Pl.ID AND
				DATEDIFF(day, P.FechaFin, GETDATE())<0) Tabla1
			FULL OUTER JOIN
			(SELECT nombre AS Estudiante, Carnet AS ID FROM OPENQUERY(MYSQL_BD, 
			'SELECT E.nombre, E.Carnet FROM Estudiantes E;')) Tabla2
			ON Tabla1.EstudianteID=Tabla2.ID
			WHERE Tabla1.EstudianteID IS NOT NULL AND Tabla2.ID IS NOT NULL;
		END TRY
		BEGIN CATCH
			SELECT 'ERROR EN LA OPERACIÓN: '+ERROR_MESSAGE();
		END CATCH
		SET NOCOUNT OFF;
	END
GO

CREATE PROCEDURE prestamosVencidos

	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT 
				Libro, Estudiante, Empleado
			FROM
			(SELECT
				L.nombre AS Libro,
				P.UsuarioID AS EstudianteID,
				Pl.nombre AS Empleado
			FROM
				Prestamos P,
				Libros L,
				Planilla Pl
			WHERE
				P.IDLibro=L.ID AND
				P.IDPlanilla=Pl.ID AND
				DATEDIFF(day, P.FechaFin, GETDATE())>=0) Tabla1
			FULL OUTER JOIN
			(SELECT nombre AS Estudiante, Carnet AS ID FROM OPENQUERY(MYSQL_BD, 
			'SELECT E.nombre, E.Carnet FROM Estudiantes E;')) Tabla2
			ON Tabla1.EstudianteID=Tabla2.ID
			WHERE Tabla1.EstudianteID IS NOT NULL AND Tabla2.ID IS NOT NULL;
		END TRY
		BEGIN CATCH
			SELECT 'ERROR EN LA OPERACIÓN: '+ERROR_MESSAGE();
		END CATCH
		SET NOCOUNT OFF;
	END
GO

CREATE PROCEDURE realizarPrestamo
@usuarioID int,
@libroID int,
@planillaID int
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			IF EXISTS(SELECT Carnet FROM OPENQUERY(MYSQL_BD, 'SELECT E.Carnet FROM Estudiantes E;') WHERE Carnet = @usuarioID) --SI EL USUARIO ES ESTUDIANTE
			BEGIN
				IF EXISTS(SELECT EstudianteID FROM OPENQUERY(MYSQL_BD, 'SELECT M.EstudianteID FROM Matriculas M 
																		INNER JOIN Grupos G ON M.GrupoID = G.ID 
																		INNER JOIN Semestres S ON G.SemestreID = S.ID 
																		WHERE S.temporada = year(curdate());') WHERE EstudianteID = @usuarioID) --revisar si el estudiante es activo
				BEGIN
					IF EXISTS(SELECT ID FROM Financiero WHERE EstudianteID = @usuarioID AND pagado = 0)--revisar que no hayan deudas
					BEGIN
						PRINT('El estudiante tiene deudas')
						RETURN
					END
				END

				ELSE
				BEGIN
					PRINT('El estudiante no es activo')
					RETURN
				END
			END

			ELSE --EL USUARIO ES PROFESOR
			BEGIN
				IF NOT EXISTS(SELECT ProfesorID FROM OPENQUERY(MYSQL_BD, 'SELECT G.ProfesorID FROM Grupos G
																INNER JOIN Semestres S ON G.SemestreID = S.ID 
																WHERE S.temporada = year(curdate());') WHERE ProfesorID = @usuarioID) --REVISAR QUE EL PROFESOR SEA ACTIVO
				BEGIN
					PRINT('El profesor no es activo')
					RETURN
				END

			END

			INSERT INTO Prestamos --CREAR EL PRESTAMO
			VALUES(@libroID,@planillaID,@usuarioID,GETDATE(),DATEADD(month,1,GETDATE()))
			
		END TRY
		BEGIN CATCH
			SELECT 'ERROR EN LA OPERACIÓN: '+ERROR_MESSAGE();
		END CATCH
		SET NOCOUNT OFF;
	END
GO

EXEC consultaLibros;
GO

EXEC prestamosActivos;
GO

EXEC prestamosVencidos;
GO

SELECT * FROM Prestamos;
GO

EXEC realizarPrestamo 1234, 3, 2;
GO

SELECT * FROM Prestamos;
GO