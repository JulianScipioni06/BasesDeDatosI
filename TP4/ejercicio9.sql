-- Ejercicio 9
use Banco;

drop trigger if exists tr_actualizar_saldo;

delimiter //
create trigger tr_actualizar_saldo_con_historial
after insert on movimientos
for each row
begin
	declare saldoAnterior decimal(10, 2);
    declare saldoNuevo decimal(10, 2);
    declare importeCalculado decimal(10, 2);
    
    select saldo into saldoAnterior
    from cuentas
    where numero_cuenta = new.numero_cuenta;
    
    if upper(new.tipo) = 'CREDITO' then
		set importeCalculado = new.importe;
	else 
		set importeCalculado = -new.importe;
	end if;
    
    set saldoNuevo = saldoAnterior + importeCalculado;
    
    update cuentas
    set saldo = saldoNuevo
    where numero_cuenta = new.numero_cuenta;
    
    insert into historial_movimientos(numero_cuenta, numero_movimiento, saldo_anterior, saldo_actual)
    values (new.numero_cuenta, new.numero_movimiento, saldoAnterior, saldoNuevo);
end //
delimiter ;