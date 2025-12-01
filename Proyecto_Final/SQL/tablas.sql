create database sistema_ventas;

use sistema_ventas;

create table Producto (
	id_producto int primary key auto_increment,
    nombre varchar(30) unique not null,
    stock int not null,
    precio decimal(10,2) not null,
    categoria varchar(50)
);

create table Cliente (
	dni_cliente int primary key not null,
    nombre varchar(30) not null,
    apellido varchar(30) not null,
    email varchar(50) not null unique,
	telefono varchar(50) not null,
    direccion varchar(50)
);

create table Orden (
	id_orden int primary key auto_increment,
    id_producto int not null,
    dni_cliente int not null,
    fecha date not null,
    cant_unidades int not null,
    constraint fk_producto foreign key (id_producto) references Producto(id_producto)
    on update cascade on delete restrict,
    constraint fk_cliente foreign key (dni_cliente) references Cliente(dni_cliente)
    on update cascade on delete restrict
);

CREATE INDEX idx_fecha ON Orden(fecha);