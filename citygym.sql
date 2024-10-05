-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS citygym;

-- Uso de la base de datos
USE citygym;

-- Tabla administrador
CREATE TABLE IF NOT EXISTS administrador (
    id_administrador INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(80) NOT NULL,
    usuario VARCHAR(80) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla socio
CREATE TABLE IF NOT EXISTS socio (
    id_socio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(255),
    estado ENUM('ACTIVO', 'INACTIVO') DEFAULT 'ACTIVO',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    creado_por INT,
    modificado_por INT,
    FOREIGN KEY (creado_por) REFERENCES administrador(id_administrador),
    FOREIGN KEY (modificado_por) REFERENCES administrador(id_administrador)
);

-- Tabla entrenador
CREATE TABLE IF NOT EXISTS entrenador (
    id_entrenador INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(15),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('ACTIVO', 'INACTIVO') DEFAULT 'ACTIVO',
    creado_por INT,
    modificado_por INT,
    FOREIGN KEY (creado_por) REFERENCES administrador(id_administrador),
    FOREIGN KEY (modificado_por) REFERENCES administrador(id_administrador)
);

-- Tabla plan
CREATE TABLE IF NOT EXISTS plan (
    id_plan INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    duracion INT, -- en días
    costo DECIMAL(10,2) NOT NULL,
    estado ENUM('ACTIVO', 'INACTIVO') DEFAULT 'ACTIVO',
    creado_por INT,
    modificado_por INT,
    FOREIGN KEY (creado_por) REFERENCES administrador(id_administrador),
    FOREIGN KEY (modificado_por) REFERENCES administrador(id_administrador)
);

-- Tabla socio_plan
CREATE TABLE IF NOT EXISTS socio_plan (
    id_socio INT,
    id_plan INT,
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_socio, id_plan),
    FOREIGN KEY (id_socio) REFERENCES socio(id_socio),
    FOREIGN KEY (id_plan) REFERENCES plan(id_plan)
);

-- Tabla entrenador_plan
CREATE TABLE IF NOT EXISTS entrenador_plan (
    id_entrenador INT,
    id_plan INT,
    PRIMARY KEY (id_entrenador, id_plan),
    FOREIGN KEY (id_entrenador) REFERENCES entrenador(id_entrenador),
    FOREIGN KEY (id_plan) REFERENCES plan(id_plan)
);

-- Tabla pagos
CREATE TABLE IF NOT EXISTS pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_socio INT NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto DECIMAL(10,2) NOT NULL,
    metodo_pago ENUM('Efectivo', 'Tarjeta', 'Transferencia'),
    FOREIGN KEY (id_socio) REFERENCES socio(id_socio),
    creado_por INT,
    modificado_por INT,
    FOREIGN KEY (creado_por) REFERENCES administrador(id_administrador),
    FOREIGN KEY (modificado_por) REFERENCES administrador(id_administrador)
);

