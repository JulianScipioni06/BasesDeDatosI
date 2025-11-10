-- Ejercicio 7
use Banco;

delimiter //
create procedure Extraer(in cuenta int, in monto decimal(10, 2))
begin
	declare saldoActual decimal(10, 2);
    
    select saldo
    into saldoActual
    from cuentas
    where numero_cuenta = cuenta;
    
    if saldoActual >= monto then
		insert into movimientos (numero_cuenta, fecha, tipo, importe)
        values (cuenta, curdate(), 'DEBITO', monto);
	end if;
end //
delimiter ;