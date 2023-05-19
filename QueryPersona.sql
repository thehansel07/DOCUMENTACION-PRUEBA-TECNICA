--Creacion de base de datos HanselCabreraPrueba
create database HanselCabreraPrueba
go 
--Especificando base de datos creado para su posterior uso
use HanselCabreraPrueba

--Creando tabla persona
--Columnas IdPersona(Clave primaria, autoIncremento), Nombre, FechaNacimiento
--colocando auto incremento en la clave primaria ID

create table Persona
(
IdPersona int identity(1,1)primary key,
Nombre varchar(30),
FechaDeNacimiento Datetime
)

--Insertando registro en la tabla persona
insert into Persona values('Hansel Cabrera',GETDATE() )









--Crear procedimiento almacenado Genericos

Alter proc Sp_Generico
(
@IdPersona int null, 
@Nombre varchar(30) null, 
@FechaNacimiento datetime null, 
@ActionType int null --Necesario para identificar el tipo de accion
)
AS


If @ActionType = 1  
   IF @IdPersona IS null or @IdPersona = 0
      BEGIN
        INSERT INTO Persona(Nombre, FechaNacimiento) values (@Nombre, @FechaNacimiento)
	    SELECT * FROM Persona where IdPersona = (SELECT MAX(idPersona) FROM Persona) 
		Print CONCAT(('Registro Agregado de manera correcta, persona:'), @Nombre)
	  END
   ELSE 
      BEGIN
       Update Persona set Nombre = @Nombre, FechaNacimiento = @FechaNacimiento where IdPersona = @IdPersona
	   SELECT * FROM Persona where IdPersona = @IdPersona
	   Print CONCAT(('Registro Actualizado De Manera Correcta, ID:'),@IdPersona)
	 END

IF @ActionType = 2
   BEGIN
	 SELECT * FROM Persona where IdPersona = @IdPersona
     DELETE Persona where idPersona = @IdPersona
	 Print CONCAT(('Registros eliminado de manera correcta, ID:'), @IdPersona)

   END

If @ActionType = 3
   BEGIN
     SELECT * FROM Persona
	 Print('Personas Seleccionadas de Manera Correcta')
   END


IF @ActionType = 4
   BEGIN
     SELECT * FROM Persona WHERE idPersona = @IdPersona
	 Print CONCAT(('Registro identificado con el Id:'), @IdPersona, ' fue seleccionado de manera correcta.')
   END





   

 exec Sp_Generico @IdPersona=12, @Nombre='', @FechaNacimiento = '', @ActionType = 4
 select *  from Persona 
 SELECT * FROM Persona where IdPersona = (SELECT MAX(idPersona) FROM Persona) 

