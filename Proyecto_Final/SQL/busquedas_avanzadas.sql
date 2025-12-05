USE sistema_ventas;

DELIMITER $$
DROP PROCEDURE IF EXISTS buscar_productos$$
CREATE PROCEDURE buscar_productos(IN busqueda VARCHAR(50))
BEGIN
    SELECT * FROM Producto
    WHERE nombre LIKE CONCAT('%', busqueda, '%')
       OR categoria LIKE CONCAT('%', busqueda, '%');
END$$

DROP PROCEDURE IF EXISTS buscar_clientes$$
CREATE PROCEDURE buscar_clientes(IN busqueda VARCHAR(50))
BEGIN
    SELECT * FROM Cliente
    WHERE nombre LIKE CONCAT('%', busqueda, '%')
       OR apellido LIKE CONCAT('%', busqueda, '%')
       OR email LIKE CONCAT('%', busqueda, '%');
END$$
DELIMITER ;