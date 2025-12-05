use sistema_ventas;

-- Procedimiento Agregar Productos
DROP PROCEDURE IF EXISTS agregar_cliente;
DELIMITER $$
create procedure agregar_cliente(
	IN dni_cliente int,
	IN nombre varchar(30),
    IN apellido varchar(30),
    IN email varchar(50),
    IN telefono varchar(50),
    IN direccion varchar(50)
)
BEGIN
	INSERT INTO Cliente (dni_cliente, nombre, apellido, email, telefono, direccion) VALUES
    (dni_cliente, nombre, apellido, email, telefono, direccion);
END$$
DELIMITER ;

-- Procedimiento Ver Productos
DROP PROCEDURE IF EXISTS ver_clientes;
DELIMITER $$
create procedure ver_clientes()
BEGIN
	SELECT * FROM Cliente ORDER BY dni_cliente ASC;
END$$
DELIMITER ;

-- Procedimiento Actualizar Productos
DROP PROCEDURE IF EXISTS actualizar_cliente;
DELIMITER $$
create procedure actualizar_cliente(
	IN dni_cliente_buscado int,
	IN nuevo_nombre varchar(30),
    IN nuevo_apellido varchar(30),
    IN nuevo_email varchar(50),
    IN nuevo_telefono varchar(50),
    IN nuevo_direccion varchar(50)
)
BEGIN
	UPDATE Cliente
    SET 
        nombre = nuevo_nombre,
        apellido = nuevo_apellido,
        email = nuevo_email,
        telefono = nuevo_telefono,
        direccion = nuevo_direccion
    WHERE dni_cliente = dni_cliente_buscado;
END$$
DELIMITER ;