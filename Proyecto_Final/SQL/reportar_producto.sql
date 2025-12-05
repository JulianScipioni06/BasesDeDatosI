use sistema_ventas;

DROP PROCEDURE IF EXISTS reportar_producto;
DELIMITER $$
create procedure reportar_producto()
BEGIN
	SELECT p.id_producto, p.nombre, SUM(o.cant_unidades) AS total_vendido
	FROM producto p
	INNER JOIN Orden o ON p.id_producto = o.id_producto
	GROUP BY p.id_producto, p.nombre
	ORDER BY SUM(o.cant_unidades) DESC LIMIT 1;
END$$
DELIMITER ;
