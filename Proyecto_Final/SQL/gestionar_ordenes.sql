USE sistema_ventas;

DROP PROCEDURE IF EXISTS obtenerOrdenesCliente;
DELIMITER $$
CREATE PROCEDURE obtenerOrdenesCliente (
    IN p_dni_cliente INT 
)
BEGIN
    SELECT
        Cliente.nombre AS Nombre_Cliente,
        Cliente.apellido AS Apellido_Cliente,
        Orden.id_orden AS ID_de_la_Orden,
        Orden.fecha AS Fecha_del_Pedido,
        Producto.nombre AS Producto_Comprado,
        Orden.cant_unidades AS Cantidad_Unidades 
    FROM Cliente
    INNER JOIN Orden ON Cliente.dni_cliente = Orden.dni_cliente 
    INNER JOIN Producto ON Orden.id_producto = Producto.id_producto 
    WHERE Cliente.dni_cliente = p_dni_cliente
    ORDER BY Orden.fecha ASC, Orden.id_orden ASC;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER descontar_stock_venta
AFTER INSERT ON orden
FOR EACH ROW
BEGIN
    UPDATE producto 
    SET stock = stock - NEW.cant_unidades
    WHERE id_producto = NEW.id_producto;
END$$
DELIMITER ;