-- CONSULTAS SIN JOIN
USE ejercicio1_tp2;
-- 1. ¿Qué socios tienen barcos amarrados en un número de amarre mayor que 10?
SELECT s.id_socio, s.nombre, b.numero_amarre FROM Socios as s, Barcos as b WHERE s.id_socio = b.id_socio AND numero_amarre > 10;

-- 2. ¿Cuáles son los nombres de los barcos y sus cuotas de aquellos barcos cuyo socio se llama 'Juan Pérez'?
SELECT socio.nombre, barco.nombre AS Nombre_Barco, barco.cuota FROM Barcos AS barco, Socios AS socio WHERE barco.id_socio = socio.id_socio AND socio.nombre = 'Juan Pérez';

-- 3. ¿Cuántas salidas ha realizado el barco con matrícula 'ABC123'?
SELECT matricula, COUNT(*) AS Total_Salidas FROM Salidas WHERE matricula IN (SELECT matricula FROM Barcos WHERE matricula = 'ABC123');

-- 4. Lista los barcos que tienen una cuota mayor a 500 y sus respectivos socios.
SELECT s.nombre, b.nombre, b.numero_amarre, b.cuota FROM Barcos AS b, Socios AS s WHERE b.id_socio = s.id_socio AND b.cuota > 500;

-- 5. ¿Qué barcos han salido con destino a 'Mallorca'?
SELECT b.matricula, b.nombre, s.destino FROM Barcos AS b, Salidas AS s WHERE b.matricula = s.matricula AND s.destino = 'Mallorca';

-- 6. ¿Qué patrones (nombre y dirección) han llevado un barco cuyo socio vive en 'Barcelona'?
SELECT patron_nombre, patron_direccion FROM Salidas WHERE matricula IN 
(SELECT matricula FROM Barcos
  WHERE id_socio IN ( SELECT id_socio FROM Socios
    WHERE direccion LIKE '%Barcelona%'
  )
);

-- ///////////////////////////////////////////////////////////////////////////////////////////////

-- CONSULTAS CON JOIN

-- 1. ¿Qué socios tienen barcos amarrados en un número de amarre mayor que 10?
SELECT s.id_socio, s.nombre, b.numero_amarre FROM Socios AS s JOIN Barcos AS b ON s.id_socio = b.id_socio WHERE numero_amarre > 10;

-- 2. ¿Cuáles son los nombres de los barcos y sus cuotas de aquellos barcos cuyo socio se llama 'Juan Pérez'?
SELECT socio.nombre, barco.nombre AS Nombre_Barco, barco.cuota FROM Barcos AS barco JOIN Socios AS socio ON barco.id_socio = socio.id_socio WHERE socio.nombre = 'Juan Pérez';

-- 3. ¿Cuántas salidas ha realizado el barco con matrícula 'ABC123'?
SELECT Salidas.matricula, COUNT(*) AS Total_Salidas FROM Salidas INNER JOIN Barcos ON Salidas.matricula = Barcos.matricula WHERE Barcos.matricula = 'ABC123';

-- 4. Lista los barcos que tienen una cuota mayor a 500 y sus respectivos socios.
SELECT s.nombre, b.nombre, b.numero_amarre, b.cuota FROM Barcos AS b JOIN Socios AS s ON b.id_socio = s.id_socio WHERE b.cuota > 500 ORDER BY b.cuota ASC;

-- 5. ¿Qué barcos han salido con destino a 'Mallorca'?
SELECT b.matricula, b.nombre, s.destino FROM Barcos AS b JOIN Salidas AS s ON b.matricula = s.matricula WHERE s.destino = 'Mallorca';

-- SELECT patron_nombre, patron_direccion FROM Salidas WHERE matricula IN 
SELECT s.patron_nombre, s.patron_direccion FROM Salidas AS s 
JOIN Barcos AS b ON b.matricula = s.matricula
JOIN Socios AS soc ON b.id_socio = soc.id_socio
WHERE soc.direccion LIKE '%Barcelona%'; 









