-- Universidad de La Laguna
-- Asignatura: ADBD
-- Práctica 3: Modelo Relacional. Viveros
-- Fecha: 17/10/2024

-- Autores: 
---  Javier Almenara Herrera 
---  Pablo Rodríguez de la Rosa

DROP TABLE IF EXISTS zona_empleado;
DROP TABLE IF EXISTS zona_producto;
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS telefono_cliente;
DROP TABLE IF EXISTS clientes_plus;
DROP TABLE IF EXISTS telefono_empleados;
DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS zona;
DROP TABLE IF EXISTS viveros;
DROP TYPE IF EXISTS puesto_enum;

-- Crear un tipo enumerado para los posibles puestos de empleados
CREATE TYPE puesto_enum AS ENUM (
  'Gerente',
  'Supervisor',
  'Operario',
  'Jardinero',
  'Vendedor'
);

CREATE TABLE viveros (
  id_vivero VARCHAR(5) PRIMARY KEY,  -- Código de 5 dígitos
  latitud DECIMAL(9,6) NOT NULL CHECK (latitud >= -90 AND latitud <= 90),  -- Latitud válida
  longitud DECIMAL(9,6) NOT NULL CHECK (longitud >= -180 AND longitud <= 180),  -- Longitud válida
  nombre VARCHAR(100) NOT NULL
  CONSTRAINT id_vivero_valido CHECK (id_vivero ~ '^V[0-9]{4}$')  -- Código de 5 dígitos
);

CREATE TABLE zona (
  id_zona VARCHAR(5) CHECK (id_zona ~ '^Z[0-9]{4}$'),  -- Código de 5 dígitos
  id_vivero VARCHAR(5) CHECK (id_vivero ~ '^V[0-9]{4}$'),  -- Código de 5 dígitos
  nombre VARCHAR(100) NOT NULL,
  latitud DECIMAL(9,6) NOT NULL CHECK (latitud >= -90 AND latitud <= 90),  -- Latitud válida
  longitud DECIMAL(9,6) NOT NULL CHECK (longitud >= -180 AND longitud <= 180),  -- Longitud válida
  PRIMARY KEY (id_zona, id_vivero),
  FOREIGN KEY (id_vivero) REFERENCES viveros(id_vivero) ON DELETE CASCADE
);

CREATE TABLE producto (
  id_producto VARCHAR(5) PRIMARY KEY CHECK (id_producto ~ '^P[0-9]{4}$'),  -- Código de 5 dígitos
  cantidad INT CHECK(cantidad >= 0),
  precio DECIMAL(10,2) CHECK(precio > 0),
  nombre VARCHAR(100) NOT NULL

);

CREATE TABLE empleado (
  id_empleado VARCHAR(5) PRIMARY KEY CHECK (id_empleado ~ '^E[0-9]{4}$'),  -- Código de 5 dígitos
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  salario DECIMAL(10,2) CHECK(salario > 0),
  puesto puesto_enum NOT NULL  -- Columna que utiliza el tipo enumerado puesto_enum
);

CREATE TABLE telefono_empleados (
  id_empleado VARCHAR(5) CHECK (id_empleado ~ '^E[0-9]{4}$'),
  telefono VARCHAR(9) CHECK(LENGTH(telefono) = 9) PRIMARY KEY,
  FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE
);

CREATE TABLE clientes_plus (
  dni VARCHAR(9) PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  fecha_alta DATE NOT NULL CHECK(fecha_alta <= CURRENT_DATE),
  volumen_compras_mensual DECIMAL(10,2) CHECK(volumen_compras_mensual >= 0),
  bonificacion DECIMAL(5,2) CHECK(bonificacion >= 0)
  CONSTRAINT dni_valido CHECK (dni ~ '^[0-9]{8}[A-Z]$')
);

CREATE TABLE telefono_cliente (
  dni VARCHAR(9) CHECK (dni ~ '^[0-9]{8}[A-Z]$'),
  telefono VARCHAR(9) CHECK(LENGTH(telefono) = 9) PRIMARY KEY,
  FOREIGN KEY (dni) REFERENCES clientes_plus(dni) ON DELETE CASCADE
);

CREATE TABLE pedido (
  codigo VARCHAR(10) PRIMARY KEY CHECK (codigo ~ '^PE[0-9]{8}$'),
  id_empleado VARCHAR(5) CHECK (id_empleado ~ '^E[0-9]{4}$'),
  fecha_realizacion DATE,
  precio_total DECIMAL(10,2),
  dni VARCHAR(9) CHECK (dni ~ '^[0-9]{8}[A-Z]$'),
  FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE,
  FOREIGN KEY (dni) REFERENCES clientes_plus(dni) ON DELETE CASCADE
);

CREATE TABLE zona_producto (
  id_zona VARCHAR(5) CHECK (id_zona ~ '^Z[0-9]{4}$'),
  id_vivero VARCHAR(5) CHECK (id_vivero ~ '^V[0-9]{4}$'),
  id_producto VARCHAR(5) CHECK (id_producto ~ '^P[0-9]{4}$'),
  cantidad INT CHECK(cantidad >= 0),
  PRIMARY KEY (id_zona, id_vivero, id_producto),
  FOREIGN KEY (id_zona, id_vivero) REFERENCES zona(id_zona, id_vivero) ON DELETE CASCADE,
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);

CREATE TABLE zona_empleado (
  id_trabajo SERIAL PRIMARY KEY,
  id_zona VARCHAR(5) CHECK (id_zona ~ '^Z[0-9]{4}$'),
  id_vivero VARCHAR(5) CHECK (id_vivero ~ '^V[0-9]{4}$'),
  id_producto VARCHAR(5) CHECK (id_producto ~ '^P[0-9]{4}$'),
  productividad DECIMAL(5,2) CHECK(productividad >= 0),
  puesto puesto_enum NOT NULL,  -- Usando el enumerado para especificar el puesto en la tabla zona_empleado
  fecha_inicial DATE NOT NULL,
  fecha_final DATE CHECK ((fecha_final >= fecha_inicial) AND (fecha_final <= CURRENT_DATE)),
  FOREIGN KEY (id_zona, id_vivero) REFERENCES zona(id_zona, id_vivero) ON DELETE CASCADE,
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);