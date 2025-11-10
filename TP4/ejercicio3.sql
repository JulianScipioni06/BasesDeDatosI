-- Ejercicio 3
use Banco;

delimiter //
create procedure VerCuentas()
begin
	select numero_cuenta, saldo
    from cuentas;
end //
delimiter ;