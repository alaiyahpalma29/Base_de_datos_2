-- =============================================
-- TALLER 01 - BASE DE DATOS II
-- Estudiante: Alaiyah Palma
-- Tema: Lenguaje DDL y DML en MySQL
-- =============================================

-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS tienda_relacional;
USE tienda_relacional;

-- =============================================
-- TABLAS PRINCIPALES
-- =============================================

-- Tabla de categorías
CREATE TABLE Categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla de productos
CREATE TABLE Producto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id)
);

-- Tabla de pedidos
CREATE TABLE Pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATE DEFAULT (CURRENT_DATE)
);

-- Tabla de detalle del pedido
CREATE TABLE Detalle_Pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id),
    FOREIGN KEY (id_producto) REFERENCES Producto(id)
);

-- =============================================
-- SUBTIPOS DE PRODUCTO
-- =============================================

-- Subtipo: Comida
CREATE TABLE Comida (
    id_producto INT PRIMARY KEY,
    fecha_vencimiento DATE NOT NULL,
    calorias INT,
    FOREIGN KEY (id_producto) REFERENCES Producto(id)
);

-- Subtipo: Muebles
CREATE TABLE Mueble (
    id_producto INT PRIMARY KEY,
    fecha_fabricacion DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES Producto(id)
);

-- =============================================
-- INSERCIÓN DE DATOS (DML)
-- =============================================

-- Categorías
INSERT INTO Categoria (nombre) VALUES ('Comida'), ('Muebles');

-- Productos
INSERT INTO Producto (nombre, precio, id_categoria) VALUES
('Manzana', 0.50, 1),
('Silla', 35.00, 2);

-- Subtipos
INSERT INTO Comida (id_producto, fecha_vencimiento, calorias)
VALUES (1, '2025-12-31', 95);

INSERT INTO Mueble (id_producto, fecha_fabricacion)
VALUES (2, '2025-08-10');

-- Pedidos
INSERT INTO Pedido (fecha_pedido) VALUES ('2025-10-18');

-- Detalles del pedido
INSERT INTO Detalle_Pedido (id_pedido, id_producto, cantidad)
VALUES (1, 1, 10), (1, 2, 2);

-- =============================================
-- CONSULTAS DE PRUEBA
-- =============================================

-- Ver los pedidos con los productos y sus totales
SELECT p.id AS numero_pedido, pr.nombre AS producto, dp.cantidad, pr.precio,
       (dp.cantidad * pr.precio) AS total
FROM Pedido p
JOIN Detalle_Pedido dp ON p.id = dp.id_pedido
JOIN Producto pr ON dp.id_producto = pr.id;

-- Ver los productos según su categoría
SELECT c.nombre AS categoria, p.nombre AS producto, p.precio
FROM Categoria c
JOIN Producto p ON c.id = p.id_categoria;
