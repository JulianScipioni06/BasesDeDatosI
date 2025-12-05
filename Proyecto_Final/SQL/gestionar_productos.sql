use sistema_ventas;

-- Procedimiento Agregar Productos
DELIMITER $$
DROP PROCEDURE IF EXISTS agregar_producto;
create procedure agregar_producto(
	IN nombre varchar(30),
    IN precio decimal(10,2),
    IN stock int,
    IN categoria varchar(50)
)
BEGIN
	INSERT INTO Producto (nombre, stock, precio, categoria) VALUES
    (nombre, stock, precio, categoria);
END$$
DELIMITER ;

-- Procedimiento Ver Productos
DELIMITER $$
DROP PROCEDURE IF EXISTS ver_productos;
create procedure ver_productos()
BEGIN
	SELECT * FROM Producto ORDER BY id_producto ASC;
END$$
DELIMITER ;

-- Procedimiento Actualizar Productos
DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_producto;
create procedure actualizar_producto(
	IN id_producto_buscado int,
	IN nuevo_nombre varchar(30),
    IN nuevo_precio decimal(10,2),
    IN nuevo_stock int,
    IN nueva_categoria varchar(50)
)
BEGIN
	UPDATE Producto
    SET 
        nombre = nuevo_nombre,
        precio = nuevo_precio,
        stock = nuevo_stock,
        categoria = nueva_categoria
    WHERE id_producto = id_producto_buscado;
END$$
DELIMITER ;

-- Procedimiento Eliminar un producto
DELIMITER $$
DROP PROCEDURE IF EXISTS eliminar_producto;
create procedure eliminar_producto (IN id_producto_buscado int)
BEGIN
	DELETE FROM Producto WHERE id_producto_buscado = id_producto;
END$$
DELIMITER ;
