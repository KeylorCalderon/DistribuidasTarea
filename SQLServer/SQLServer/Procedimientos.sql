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
				P.EstudianteID AS EstudianteID,
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
				P.EstudianteID AS EstudianteID,
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

CREATE PROCEDURE prestamoLibro

	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			continue;
		END TRY
		BEGIN CATCH
			SELECT 'ERROR EN LA OPERACIÓN: '+ERROR_MESSAGE();
		END CATCH
		SET NOCOUNT OFF;
	END
GO