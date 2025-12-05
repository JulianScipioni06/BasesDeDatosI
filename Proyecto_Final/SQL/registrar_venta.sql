USE sistema_ventas;

DROP PROCEDURE IF EXISTS registrar_venta;
DELIMITER $$
CREATE PROCEDURE registrar_venta(
    IN p_dni_cliente INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_stock_actual INT;
    SELECT stock INTO v_stock_actual 
    FROM Producto 
    WHERE id_producto = p_id_producto;

    IF v_stock_actual >= p_cantidad THEN
        INSERT INTO Orden (dni_cliente, id_producto, fecha, cant_unidades)
        VALUES (p_dni_cliente, p_id_producto, CURDATE(), p_cantidad);
    END IF;
END$$
DELIMITER ;