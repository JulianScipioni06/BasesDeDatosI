-- 1. ¿Cuál es el nombre y la dirección de los procuradores que han trabajado en un asunto abierto?
SELECT p.nombre, p.direccion FROM Procuradores AS p JOIN Asuntos_Procuradores AS ap ON p.id_procurador = ap.id_procurador 
JOIN Asuntos AS a ON ap.numero_expediente = a.numero_expediente
WHERE a.estado = 'Abierto';

-- 2. ¿Qué clientes han tenido asuntos en los que ha participado el procurador Carlos López?
SELECT c.nombre FROM Clientes AS c
JOIN Asuntos AS a ON c.dni = a.dni_cliente
JOIN Asuntos_Procuradores AS ap ON a.numero_expediente = ap.numero_expediente
JOIN Procuradores as p ON p.id_procurador = ap.id_procurador
WHERE p.nombre = 'Carlos López';

-- 3. ¿Cuántos asuntos ha gestionado cada procurador?
SELECT p.nombre, COUNT(ap.numero_expediente) AS Total_Asuntos FROM Procuradores AS p JOIN Asuntos_Procuradores AS ap ON p.id_procurador = ap.id_procurador GROUP BY p.nombre;

-- 4. Lista los números de expediente y fechas de inicio de los asuntos de los clientes que viven en Buenos Aires.
SELECT c.nombre, c.direccion, a.numero_expediente, a.fecha_inicio FROM Asuntos AS a JOIN Clientes AS c ON a.dni_cliente = c.dni WHERE c.direccion LIKE '%Buenos Aires%'