# Práctica #03. Modelo Relacional Viveros.
### Autores
- Javier Almenara Herrera
- Pablo Rodríguez de La Rosa

## 1. Introducción
En esta práctica se ha realizado el modelo relacional de la base de datos de un vivero. Para ello, se ha seguido el enunciado de la práctica y se han realizado las tablas necesarias para almacenar la información de los productos, los clientes, los empleados, los pedidos, los viveros y las zonas. 

## 2. Modelo Relacional
A continuación, se muestra el modelo relacional de la base de datos de un vivero.

- **VIVEROS** (ID-VIVERO, LATITUD, LONGITUD, NOMBRE)
  - PRIMARY KEY: (ID-VIVERO)

- **ZONA** (ID-ZONA, ID-VIVERO, NOMBRE, LATITUD, LONGITUD)
  - PRIMARY KEY: (ID-ZONA, ID-VIVERO) (Esta clave compuesta permite relacionar la zona con el vivero.)
  - FOREIGN KEY: (ID-VIVERO) referencia VIVEROS(ID-VIVERO)

- **PRODUCTO** (ID-PRODUCTO, CANTIDAD, PRECIO, NOMBRE)
  - PRIMARY KEY: (ID-PRODUCTO)

- **EMPLEADO** (ID-EMPLEADO, NOMBRE, APELLIDO1, APELLIDO2, SALARIO)
  - PRIMARY KEY: (ID-EMPLEADO)

- **TELEFONO-EMPLEADOS** (ID-EMPLEADO, TELEFONO)
  - PRIMARY KEY: (TELEFONO)
  - FOREIGN KEY: (ID-EMPLEADO) referencia EMPLEADO(ID-EMPLEADO)

- **PEDIDO** (CÓDIGO, ID-EMPLEADO, FECHA-REALIZACION, PRECIO-TOTAL, DNI)
  - PRIMARY KEY: (CÓDIGO)
  - FOREIGN KEY (ID-EMPLEADO) referencia EMPLEADO(ID-EMPLEADO)
  - FOREIGN KEY (DNI) referencia CLIENTES-PLUS(DNI) 

- **CLIENTES-PLUS** (DNI, NOMBRE, APELLIDO1, APELLIDO2, FECHA-ALTA, VOLUMEN-COMPRAS-MENSUAL, BONIFICACIÓN)
  - PRIMARY KEY: (DNI)

- **TELEFONO-CLIENTE** (DNI, TELEFONO)
  - PRIMARY KEY: (TELEFONO)
  - FOREIGN KEY: (DNI) referencia CLIENTES-PLUS(DNI)

- **ZONA-PRODUCTO** (ID-ZONA, ID-PRODUCTO, CANTIDAD)
  - PRIMARY KEY: (ID-ZONA, ID-PRODUCTO)
  - FOREIGN KEY (ID-ZONA) referencia ZONA(ID-ZONA, ID-VIVERO)
  - FOREIGN KEY (ID-PRODUCTO) referencia PRODUCTO(ID-PRODUCTO)

- **ZONA-EMPLEADO** (ID-TRABAJO, ID-ZONA, ID-PRODUCTO, PRODUCTIVIDAD, PUESTO, FECHA-INICIAL, FECHA-FINAL)
  - PRIMARY KEY: (ID-TRABAJO)
  - FOREIGN KEY (ID-ZONA) referencia ZONA(ID-ZONA, ID-VIVERO)
  - FOREIGN KEY (ID-PRODUCTO) referencia PRODUCTO(ID-PRODUCTO)

## 3. Modelo Relacional en PostgreSQL
El modelo relacional se ha realizado en MySQL Workbench y se ha exportado a un archivo .sql. A continuación, se muestra el modelo relacional de la base de datos de un vivero.

```sql

-- Crear un tipo enumerado para los posibles puestos de empleados
CREATE TYPE puesto_enum AS ENUM (
  'Gerente',
  'Supervisor',
  'Operario',
  'Jardinero',
  'Vendedor'
);

CREATE TABLE viveros (
  id_vivero SERIAL PRIMARY KEY,
  latitud DECIMAL(9,6) NOT NULL CHECK (latitud >= -90 AND latitud <= 90),  -- Latitud válida
  longitud DECIMAL(9,6) NOT NULL CHECK (longitud >= -180 AND longitud <= 180),  -- Longitud válida
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE zona (
  id_zona SERIAL,
  id_vivero INT,
  nombre VARCHAR(100) NOT NULL,
  latitud DECIMAL(9,6) NOT NULL CHECK (latitud >= -90 AND latitud <= 90),  -- Latitud válida
  longitud DECIMAL(9,6) NOT NULL CHECK (longitud >= -180 AND longitud <= 180),  -- Longitud válida
  PRIMARY KEY (id_zona, id_vivero),
  FOREIGN KEY (id_vivero) REFERENCES viveros(id_vivero) ON DELETE CASCADE
);

CREATE TABLE producto (
  id_producto SERIAL PRIMARY KEY,
  cantidad INT CHECK(cantidad >= 0),
  precio DECIMAL(10,2) CHECK(precio > 0),
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE empleado (
  id_empleado SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  salario DECIMAL(10,2) CHECK(salario > 0),
  puesto puesto_enum NOT NULL  -- Columna que utiliza el tipo enumerado puesto_enum
);

CREATE TABLE telefono_empleados (
  id_empleado INT,
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
  dni VARCHAR(9),
  telefono VARCHAR(9) CHECK(LENGTH(telefono) = 9) PRIMARY KEY,
  FOREIGN KEY (dni) REFERENCES clientes_plus(dni) ON DELETE CASCADE
);

CREATE TABLE pedido (
  codigo SERIAL PRIMARY KEY,
  id_empleado INT,
  fecha_realizacion DATE,
  precio_total DECIMAL(10,2),
  dni VARCHAR(9),
  FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE,
  FOREIGN KEY (dni) REFERENCES clientes_plus(dni) ON DELETE CASCADE
);

CREATE TABLE zona_producto (
  id_zona INT,
  id_vivero INT,
  id_producto INT,
  cantidad INT CHECK(cantidad >= 0),
  PRIMARY KEY (id_zona, id_vivero, id_producto),
  FOREIGN KEY (id_zona, id_vivero) REFERENCES zona(id_zona, id_vivero) ON DELETE CASCADE,
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);

CREATE TABLE zona_empleado (
  id_trabajo SERIAL PRIMARY KEY,
  id_zona INT,
  id_vivero INT,
  id_producto INT,
  productividad DECIMAL(5,2) CHECK(productividad >= 0),
  puesto puesto_enum NOT NULL,  -- Usando el enumerado para especificar el puesto en la tabla zona_empleado
  fecha_inicial DATE NOT NULL,
  fecha_final DATE CHECK ((fecha_final >= fecha_inicial) AND (fecha_final <= CURRENT_DATE)),
  FOREIGN KEY (id_zona, id_vivero) REFERENCES zona(id_zona, id_vivero) ON DELETE CASCADE,
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);
```

## 4. Conclusiones
En esta práctica se ha realizado el modelo relacional de la base de datos de un vivero. Para ello, se han seguido las indicaciones del enunciado y se han creado las tablas necesarias para almacenar la información de los productos, los clientes, los empleados, los pedidos, los viveros y las zonas. Además, se ha exportado el modelo relacional a un archivo .sql para poder ejecutarlo en PostgreSQL.

## 5. Bibliografía
- Universidad de La Laguna (2024). *Práctica #03. Modelo Relacional Viveros*. [Enlace](https://docs.google.com/document/d/1a-C_griQTXsbsi3FKcWMJlCHEsr1gzfoeN5IiVD2hpc/edit#heading=h.gjdgxs)