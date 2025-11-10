-- Ejercicio 6
use Banco;

delimiter //
create procedure Depositar(in cuenta int, in monto decimal(10, 2))
begin
	insert into movimientos (numero_cuenta, fecha, tipo, importe)
    values (cuenta, curdate(), 'CREDITO', monto);
end //
delimiter ;