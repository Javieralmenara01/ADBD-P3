-- Universidad de La Laguna
-- Asignatura: ADBD
-- Práctica 3: Modelo Relacional. Viveros
-- Fecha: 17/10/2024

-- Autores: 
---  Javier Almenara Herrera 
---  Pablo Rodríguez de la Rosa

-- Descripción: Este archivo contiene las inserciones de datos en las tablas de la base de datos.

-- Inserciones de datos en la tabla de viveros
DELETE FROM viveros;

INSERT INTO viveros 
VALUES 
(0, 28.4694, -16.2546, 'Vivero de La Laguna'),
(1, 28.6023, -16.7093, 'Vivero de Santa Cruz de Tenerife'),
(2, 28.1235, -15.4363, 'Vivero de Las Palmas de Gran Canaria'),
(3, 28.9260, -13.6518, 'Vivero de Arrecife'),
(4, 28.1486, -17.2473, 'Vivero de Los Llanos de Aridane');

SELECT * FROM viveros;

-- Inserciones de datos en la tabla de zonas
DELETE FROM zona;

INSERT INTO zona
VALUES 
(0, 0, 'Zona Norte La Laguna', 28.4745, -16.3208),
(1, 0, 'Zona Centro La Laguna', 28.4636, -16.2549),
(2, 1, 'Zona Sur Santa Cruz', 28.5874, -16.7029),
(3, 1, 'Zona Este Santa Cruz', 28.6105, -16.7143),
(4, 2, 'Zona Centro Las Palmas', 28.1277, -15.4310),
(5, 2, 'Zona Sur Las PalmAND as', 28.0978, -15.4319),
(6, 3, 'Zona Norte Arrecife', 28.9294, -13.6613),
(7, 3, 'Zona Centro Arrecife', 28.9232, -13.6501),
(8, 4, 'Zona Oeste Los Llanos', 28.1498, -17.2547),
(9, 4, 'Zona Este Los Llanos', 28.1436, -17.2415);

SELECT * FROM zona;


-- Inserciones de datos en la tabla de productos
DELETE FROM producto;

INSERT INTO producto
VALUES
(0, 100, 5.00, 'Maceta de barro'),
(1, 50, 10.00, 'Maceta de plástico'),
(2, 200, 2.00, 'Semillas de tomate'),
(3, 150, 3.00, 'Semillas de lechuga'),
(4, 300, 1.00, 'Semillas de perejil');

SELECT * FROM producto;

-- Inserciones de datos en la tabla de empleados
DELETE FROM empleado;

INSERT INTO empleado
VALUES
(0, 'Javier', 'Almenara', 'Herrera', 1500.00, 'Gerente'),
(1, 'Pablo', 'Rodríguez', 'Rosa', 1200.00, 'Supervisor'),
(2, 'María', 'García', 'Pérez', 1000.00, 'Operario'),
(3, 'Carlos', 'González', 'Martín', 900.00, 'Jardinero'),
(4, 'Ana', 'Hernández', 'Gómez', 800.00, 'Vendedor');

SELECT * FROM empleado;

-- Inserciones de datos en la tabla de teléfonos de empleados
DELETE FROM telefono_empleados;

INSERT INTO telefono_empleados
VALUES
(0, '922123456'),
(0, '922654321'),
(1, '922987654'),
(1, '922456789'),
(2, '922987123'),
(3, '928123456'),
(4, '922654381'),
(4, '928987654');

SELECT * FROM telefono_empleados;


-- Inserciones de datos en la tabla de clientes plus
DELETE FROM clientes_plus;

INSERT INTO clientes_plus
VALUES
('78424892F', 'Juan', 'García', 'Pérez', '16-OCT-2019', 0.0, 0.0),
('51236985X', 'María', 'López', 'Sánchez', '05-MAR-2020', 250.75, 150.5),
('89345678Y', 'Carlos', 'Rodríguez', 'Martín', '20-JUN-2021', 100.0, 50.0),
('42187965Z', 'Ana', 'González', 'Ruiz', '12-SEP-2018', 300.0, 200.0),
('36587412T', 'Pedro', 'Fernández', 'García', '08-JAN-2022', 75.25, 25.0);

SELECT * FROM clientes_plus;

-- Inserciones de datos en la tabla de teléfonos de clientes
DELETE FROM telefono_cliente;

INSERT INTO telefono_cliente
VALUES
('78424892F', '922123456'),
('78424892F', '922654321'),
('51236985X', '922987654'),
('51236985X', '922456789'),
('89345678Y', '922987123'),
('42187965Z', '928123456'),
('36587412T', '922654381'),
('36587412T', '928987654');
INSERT INTO zona_producto
VALUES
(3, 0, 0, 3, 150, 3.00, 'Semillas de lechuga'),
(4, 0, 0, 4, 300, 1.00, 'Semillas de perejil');
VALUES
(3, 3, '25-MAR-2024', 29.99),
(4, 4, '29-FEB-2024', 9.99);

SELECT * FROM pedido;

-- Inserciones de datos en la tabla de zonas de empleados
DELETE FROM zona_empleado;

INSERT INTO zona_empleado
VALUES
(0, 0, 0, 0, 0.0, 'Gerente', '17-JAN-2022'),
(1, 0, 0, 1, 0.0, 'Supervisor', '16-FEB-2022'),
(2, 0, 0, 2, 0.0, 'Operario', '17-JAN-2022');

INSERT INTO zona_empleado
VALUES
(3, 0, 0, 3, 0.0, 'Jardinero', '17-JAN-2022', '12-DEC-2023'),
(4, 0, 0, 4, 0.0, 'Vendedor', '17-JAN-2022', '12-DEC-2023');

SELECT * FROM zona_empleado;

-- Inserciones de datos en la tabla de zonas de productos
DELETE FROM zona_producto;

INSERT INTO zona_producto
VALUES
(0, 0, 0, 10),
(0, 0, 1, 20),
(1, 1, 2, 45),
(1, 1, 3, 30),
(2, 2, 4, 50),
(2, 2, 5, 25),
(3, 3, 6, 15),
(3, 3, 7, 10),
(2, 4, 8, 30),
(1, 4, 9, 20);


SELECT * FROM zona_producto;