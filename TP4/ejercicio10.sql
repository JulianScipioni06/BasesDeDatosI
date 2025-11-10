-- Ejercicio 10

use Banco;
 
DELIMITER //

CREATE PROCEDURE TotalMovimientosDelMes(
    IN p_cuenta INT,
    OUT p_total DECIMAL(10,2)
)
BEGIN
    DECLARE v_montomonto DECIMAL(10,2);
    DECLARE v_tipo VARCHAR(10);
    DECLARE fin_cursor BOOLEAN DEFAULT FALSE;

    DECLARE cur_movimientos CURSOR FOR
        SELECT monto, tipo
        FROM movimientos
        WHERE idCuenta = p_cuenta
          AND MONTH(fecha) = MONTH(CURDATE())
          AND YEAR(fecha) = YEAR(CURDATE());

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;

    SET total = 0;

    OPEN cur_movimientos;
    leer: LOOP
        FETCH cur_movimientos INTO v_monto, v_tipo;
        IF fin_cursor THEN
            LEAVE leer;
        END IF;

        IF v_tipo = 'CREDITO' THEN
            SET p_total = p_total + v_monto;
        ELSE
            SET p_total = p_total - v_monto;
        END IF;
    END LOOP;
    CLOSE cur_movimientos;
END //

DELIMITER ;
