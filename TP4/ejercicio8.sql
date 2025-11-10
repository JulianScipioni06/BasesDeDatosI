-- Ejercicio 8
use Banco;

delimiter //
create trigger tr_actualizar_saldo
after insert on movimientos
for each row
begin 
	declare montoAActualizar decimal(10, 2);
    
    if upper(new.tipo) = 'CREDITO' then
		set montoAActualizar = new.importe;
	else 
		set montoAActualizar = -new.importe;
	end if;
    
    update cuentas
    set saldo = saldo + montoAActualizar
    where numero_cuenta = new.numero_cuenta;
end //
delimiter ;