-- Ejercicio 4
use Banco;

delimiter //
create procedure CuentasConSaldoMayorQue(in limite decimal(10, 2))
begin
	select numero_cuenta, saldo
    from cuentas
    where saldo > limite;
end //
delimiter ;