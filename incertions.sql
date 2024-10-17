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
('V0001', 28.4694, -16.2546, 'Vivero de La Laguna'),
('V0002', 28.6023, -16.7093, 'Vivero de Santa Cruz de Tenerife'),
('V0003', 28.1235, -15.4363, 'Vivero de Las Palmas de Gran Canaria'),
('V0004', 28.9260, -13.6518, 'Vivero de Arrecife'),
('V0005', 28.1486, -17.2473, 'Vivero de Los Llanos de Aridane');

SELECT * FROM viveros;

-- Inserciones de datos en la tabla de zonas
DELETE FROM zona;

INSERT INTO zona
VALUES 
('Z0001', 'V0001', 'Zona Norte La Laguna', 28.4745, -16.3208),
('Z0002', 'V0001', 'Zona Centro La Laguna', 28.4636, -16.2549),
('Z0003', 'V0002', 'Zona Sur Santa Cruz', 28.5874, -16.7029),
('Z0004', 'V0002', 'Zona Este Santa Cruz', 28.6105, -16.7143),
('Z0005', 'V0003', 'Zona Centro Las Palmas', 28.1277, -15.4310),
('Z0006', 'V0003', 'Zona Sur Las Palmas', 28.0978, -15.4319),
('Z0007', 'V0004', 'Zona Norte Arrecife', 28.9294, -13.6613),
('Z0008', 'V0004', 'Zona Centro Arrecife', 28.9232, -13.6501),
('Z0009', 'V0005', 'Zona Oeste Los Llanos', 28.1498, -17.2547),
('Z0010', 'V0005', 'Zona Este Los Llanos', 28.1436, -17.2415);

SELECT * FROM zona;


-- Inserciones de datos en la tabla de productos
DELETE FROM producto;

INSERT INTO producto
VALUES
('P0001', 100, 5.00, 'Maceta de barro'),
('P0002', 50, 10.00, 'Maceta de plástico'),
('P0003', 200, 2.00, 'Semillas de tomate'),
('P0004', 150, 3.00, 'Semillas de lechuga'),
('P0005', 300, 1.00, 'Semillas de perejil');

SELECT * FROM producto;

-- Inserciones de datos en la tabla de empleados
DELETE FROM empleado;

INSERT INTO empleado
VALUES
('E0001', 'Javier', 'Almenara', 'Herrera', 1500.00, 'Gerente'),
('E0002', 'Pablo', 'Rodríguez', 'Rosa', 1200.00, 'Supervisor'),
('E0003', 'María', 'García', 'Pérez', 1000.00, 'Operario'),
('E0004', 'Carlos', 'González', 'Martín', 900.00, 'Jardinero'),
('E0005', 'Ana', 'Hernández', 'Gómez', 800.00, 'Vendedor');

SELECT * FROM empleado;

-- Inserciones de datos en la tabla de teléfonos de empleados
DELETE FROM telefono_empleados;

INSERT INTO telefono_empleados
VALUES
('E0001', '922123456'),
('E0001', '922654321'),
('E0002', '922987654'),
('E0002', '922456789'),
('E0003', '922987123'),
('E0004', '928123456'),
('E0005', '922654381'),
('E0005', '928987654');

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

-- Inserciones de datos en la tabla de pedidos
DELETE FROM pedido;

INSERT INTO pedido
VALUES
('PE00000001', 'E0001', '25-MAR-2022', 19.99, '78424892F'),
('PE00000002', 'E0002', '29-FEB-2024', 29.99, '51236985X'),
('PE00000003', 'E0003', '25-MAR-2023', 19.99, '89345678Y'),
('PE00000004', 'E0004', '29-FEB-2024', 9.99, '42187965Z'),
('PE00000005', 'E0005', '25-MAR-2024', 29.99, '36587412T');

INSERT INTO pedido
VALUES
('PE00000006', 'E0003', '25-MAR-2024', 29.99),
('PE00000007', 'E0006', '29-FEB-2024', 9.99);

SELECT * FROM pedido;

-- Inserciones de datos en la tabla de zonas de empleados
DELETE FROM zona_empleado;

INSERT INTO zona_empleado
VALUES
(0, 'Z0001', 'V0001', 'P0001', 0.0, 'Gerente', '17-JAN-2022'),
(1, 'Z0001', 'V0001', 'P0002', 0.0, 'Supervisor', '16-FEB-2022'),
(2, 'Z0001', 'V0001', 'P0003', 0.0, 'Operario', '17-JAN-2022');

INSERT INTO zona_empleado
VALUES
(3, 'Z0001', 'V0001', 'P0004', 0.0, 'Jardinero', '17-JAN-2022', '12-DEC-2023'),
(4, 'Z0001', 'V0001', 'P0005', 0.0, 'Vendedor', '17-JAN-2022', '12-DEC-2023');

SELECT * FROM zona_empleado;

-- Inserciones de datos en la tabla de zonas de productos
DELETE FROM zona_producto;

INSERT INTO zona_producto
VALUES
('Z0001', 'V0001', 'P0001', 10),
('Z0002', 'V0001', 'P0002', 20),
('Z0003', 'V0002', 'P0003', 45),
('Z0004', 'V0002', 'P0004', 30),
('Z0005', 'V0003', 'P0004', 50),
('Z0006', 'V0003', 'P0003', 25),
('Z0007', 'V0004', 'P0003', 15),
('Z0008', 'V0004', 'P0003', 10),
('Z0009', 'V0005', 'P0002', 30),
('Z0010', 'V0005', 'P0005', 20);


SELECT * FROM zona_producto;