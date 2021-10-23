USE SQLServer_DB
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