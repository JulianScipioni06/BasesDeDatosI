-- Ejercicio 11

DELIMITER //

CREATE PROCEDURE AplicarInteres(
    IN p_porcentaje DECIMAL(5,2),
    IN p_minimo DECIMAL(10,2)
)
BEGIN
    DECLARE v_idCuenta INT;
    DECLARE v_saldo DECIMAL(10,2);
    DECLARE fin_cursor BOOLEAN DEFAULT FALSE;

    DECLARE cur_cuentas CURSOR FOR
        SELECT idCuenta, saldo
        FROM cuentas
        WHERE saldo > p_minimo;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;

    OPEN cur_cuentas;
    recorrer: LOOP
        FETCH cur_cuentas INTO v_idCuenta, v_saldo;
        IF fin_cursor THEN
            LEAVE recorrer;
        END IF;

        UPDATE cuentas
        SET saldo = v_saldo + (v_saldo * (p_porcentaje / 100))
        WHERE idCuenta = v_idCuenta;
    END LOOP;

    CLOSE cur_cuentas;
END //

DELIMITER ;
