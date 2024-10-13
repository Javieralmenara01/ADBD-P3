CREATE TABLE viveros (
  id_vivero SERIAL PRIMARY KEY,
  latitud DECIMAL(9,6),
  longitud DECIMAL(9,6),
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE zona (
  id_zona SERIAL,
  id_vivero INT,
  nombre VARCHAR(100),
  latitud DECIMAL(9,6),
  longitud DECIMAL(9,6),
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
  nombre VARCHAR(100),
  apellido1 VARCHAR(100),
  apellido2 VARCHAR(100),
  salario DECIMAL(10,2) CHECK(salario > 0)
);

CREATE TABLE telefono_empleados (
  id_empleado INT,
  telefono VARCHAR(15) PRIMARY KEY,
  FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE
);

CREATE TABLE clientes_plus (
  dni VARCHAR(9) PRIMARY KEY,
  nombre VARCHAR(100),
  apellido1 VARCHAR(100),
  apellido2 VARCHAR(100),
  fecha_alta DATE,
  volumen_compras_mensual DECIMAL(10,2),
  bonificacion DECIMAL(5,2)
);

CREATE TABLE telefono_cliente (
  dni VARCHAR(9),
  telefono VARCHAR(15) PRIMARY KEY,
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
  id_producto INT,
  cantidad INT CHECK(cantidad >= 0),
  PRIMARY KEY (id_zona, id_producto),
  FOREIGN KEY (id_zona) REFERENCES zona(id_zona, id_vivero) ON DELETE CASCADE,
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);

CREATE TABLE zona_empleado (
  id_trabajo SERIAL PRIMARY KEY,
  id_zona INT,
  id_producto INT,
  productividad DECIMAL(5,2) CHECK(productividad >= 0),
  puesto VARCHAR(100),
  fecha_inicial DATE,
  fecha_final DATE,
  FOREIGN KEY (id_zona) REFERENCES zona(id_zona, id_vivero) ON DELETE CASCADE,
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);