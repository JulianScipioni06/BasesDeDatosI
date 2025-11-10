-- Ejercicio 1
create database Banco;

use Banco;

create table clientes (
	numero_cliente int primary key,
    dni int not null unique,
    apellido varchar(60) not null,
    nombre varchar(60) not null
);

create table cuentas (
	numero_cuenta int primary key,
    numero_cliente int not null,
    saldo decimal(10, 2) not null,
    foreign key (numero_cliente) references clientes(numero_cliente)
);

create table movimientos (
	numero_movimiento int primary key auto_increment,
    numero_cuenta int not null,
    fecha date not null,
    tipo enum('CREDITO', 'DEBITO') not null,
    importe decimal(10, 2) not null,
    foreign key (numero_cuenta) references cuentas(numero_cuenta)
);

create table historial_movimientos (
	id int primary key auto_increment,
    numero_cuenta int not null,
    numero_movimiento int not null,
    saldo_anterior decimal(10, 2) not null,
    saldo_actual decimal(10, 2) not null,
    foreign key (numero_cuenta) references cuentas(numero_cuenta),
    foreign key (numero_movimiento) references movimientos(numero_movimiento)
);
