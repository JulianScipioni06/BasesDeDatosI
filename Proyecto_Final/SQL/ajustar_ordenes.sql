USE sistema_ventas;

DELIMITER $$
CREATE TRIGGER ajustar_stock_modificacion
AFTER UPDATE ON Orden
FOR EACH ROW
BEGIN
    IF OLD.cant_unidades <> NEW.cant_unidades THEN
        UPDATE Producto
        SET stock = stock + (OLD.cant_unidades - NEW.cant_unidades)
        WHERE id_producto = NEW.id_producto;
    END IF;
END$$

DROP PROCEDURE IF EXISTS ajustar_limite_ordenes;
CREATE PROCEDURE ajustar_limite_ordenes(
    IN p_id_producto INT,
    IN p_cantidad_maxima INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error: Ocurrió un problema y no se realizó el ajuste.' AS mensaje;
    END;

    START TRANSACTION;
    UPDATE Orden
    SET cant_unidades = p_cantidad_maxima
    WHERE id_producto = p_id_producto 
      AND cant_unidades > p_cantidad_maxima;
    COMMIT;
    SELECT 'Ajuste completado exitosamente y stock actualizado.' AS mensaje;
END$$
DELIMITER ;