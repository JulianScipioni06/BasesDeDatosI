-- Ejercicio 5
use Banco;

delimiter //
create procedure TotalMovimientosDelMes(in cuenta int, out total decimal(10, 2))
begin
	select sum(if (upper(tipo) = 'CREDITO', importe, -importe))
    into total
    from movimientos
    where numero_cuenta = cuenta
		and month(fecha) = month(curdate())
        and year(fecha) = year(curdate());
end //
delimiter ;