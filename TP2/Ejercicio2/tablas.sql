-- CREATE DATABASE ejercicio2_tp2;

-- USE ejercicio2_tp2;

-- Creamos Tabla Clientes
CREATE TABLE Clientes(
  dni INT PRIMARY KEY,
  nombre VARCHAR(100),
  direccion VARCHAR(50)
);

-- Creamos Tabla Asuntos
CREATE TABLE Asuntos(
  numero_expediente INT PRIMARY KEY,
  dni_cliente INT,
  fecha_inicio DATE,
  fecha_fin DATE,
  estado VARCHAR(10),
  FOREIGN KEY (dni_cliente) REFERENCES Clientes(dni)
);

-- Creamos Tabla Procuradores
CREATE TABLE Procuradores(
  id_procurador INT PRIMARY KEY,
  nombre VARCHAR(100),
  direccion VARCHAR(50)
);

-- Creamos Tabla Asuntos Procuradores
CREATE TABLE Asuntos_Procuradores(
  numero_expediente INT,
  id_procurador INT,
  FOREIGN KEY (numero_expediente) REFERENCES Asuntos(numero_expediente),
  FOREIGN KEY (id_procurador) REFERENCES procuradores(id_procurador)
);