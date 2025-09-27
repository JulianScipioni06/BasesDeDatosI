CREATE DATABASE ejercicio1_tp2;

USE ejercicio1_tp2;

CREATE TABLE Socios(
  id_socio INT PRIMARY KEY NOT NULL,
  nombre VARCHAR(100),
  direccion VARCHAR(255)
);

CREATE TABLE Barcos(
  matricula VARCHAR(20) PRIMARY KEY NOT NULL,
  nombre VARCHAR(100),
  numero_amarre INT,
  cuota DECIMAL(10, 2),
  id_socio INT NOT NULL,
  FOREIGN KEY (id_socio) REFERENCES Socios(id_socio)
);

CREATE TABLE Salidas(
  id_salida INT PRIMARY KEY NOT NULL,
  matricula VARCHAR(20) NOT NULL,
  fecha_salida DATE,
  hora_salida DATETIME,
  destino VARCHAR(100),
  patron_nombre VARCHAR(100),
  patron_direccion VARCHAR(255),
  FOREIGN KEY (matricula) REFERENCES Barcos(matricula)
);



