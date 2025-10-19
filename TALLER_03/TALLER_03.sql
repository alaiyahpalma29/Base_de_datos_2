-- ==========================================
-- TALLER #2 - FIDELIZACIÓN Y ANÁLISIS DE COLABORADORES
-- ==========================================

CREATE DATABASE IF NOT EXISTS bd_fidelizacion_colaboradores;
USE bd_fidelizacion_colaboradores;


-- ==========================================
-- TABLA: PERFILES
-- ==========================================
CREATE TABLE perfiles (
    id_perfil INT AUTO_INCREMENT PRIMARY KEY,
    nombre_perfil VARCHAR(50) NOT NULL,
    fecha_vigencia_perfil DATE,
    descripcion_perfil VARCHAR(150),
    encargado_perfil VARCHAR(100) 
);


-- ==========================================
-- TABLA: USUARIOS
-- ==========================================
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
    contrasena VARCHAR(100) NOT NULL,
    cargo VARCHAR(100),
    salario DECIMAL(10,2),
    fecha_ingreso DATE,
    id_perfil INT, 
    FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil)
);


-- ==========================================
-- TABLA: LOGIN
-- ==========================================
CREATE TABLE login (
    id_login INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    fecha_hora_login DATETIME,
    estado_login ENUM('Exitoso', 'Fallido'),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);


-- ==========================================
-- TABLA: FIDELIZACION
-- ==========================================
CREATE TABLE fidelizacion (
    id_fidelizacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    fecha_actividad DATE,
    tipo_actividad VARCHAR(100),
    descripcion_actividad VARCHAR(200),
    puntos_otorgados INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);




-- ==========================================
-- TABLA : USUARIO_PERFIL
-- ==========================================
CREATE TABLE usuario_perfil (
    id_usuario INT,
    id_perfil INT,
    fecha_asignacion DATE,
    PRIMARY KEY (id_usuario, id_perfil),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil)
);





-- ==========================================
-- DATOS DE PERFILES (10 registros)
-- ==========================================
INSERT INTO perfiles (nombre_perfil, fecha_vigencia_perfil, descripcion_perfil, encargado_perfil)
VALUES
('Administrador', '2025-12-31', 'Gestiona usuarios y perfiles del sistema', 'Gerente General'),
('Analista de Datos', '2025-12-31', 'Analiza información de fidelización', 'Jefe de Análisis'),
('Recursos Humanos', '2025-12-31', 'Gestiona empleados y sus perfiles', 'Directora RRHH'),
('Vendedor', '2025-12-31', 'Encargado de ventas y atención al cliente', 'Jefe de Ventas'),
('Marketing', '2025-12-31', 'Promociona productos y fideliza clientes', 'Coordinador de Marketing'),
('Soporte Técnico', '2025-12-31', 'Atiende incidencias técnicas', 'Supervisor de Soporte'),
('Desarrollador', '2025-12-31', 'Crea sistemas internos', 'Líder de Desarrollo'),
('Diseñador', '2025-12-31', 'Diseña material visual y publicitario', 'Director Creativo'),
('Contador', '2025-12-31', 'Gestiona finanzas y reportes contables', 'Gerente Financiero'),
('Asistente Administrativo', '2025-12-31', 'Apoya tareas operativas y logísticas', 'Administrador General');





-- ==========================================
-- DATOS DE USUARIOS (20 registros)
-- ==========================================
INSERT INTO usuarios (nombre, apellido, estado, contrasena, cargo, salario, fecha_ingreso, id_perfil)
VALUES
('Carlos', 'Ramírez', 'Activo', '1234', 'Administrador de Sistemas', 2500.00, '2022-03-10', 1),
('Laura', 'Gómez', 'Activo', 'abcd', 'Analista de Datos', 1800.00, '2023-01-05', 2),
('Sofía', 'Martínez', 'Activo', 'sofia22', 'Recursos Humanos', 2200.00, '2021-07-12', 3),
('Andrés', 'Pérez', 'Activo', 'andres123', 'Vendedor Senior', 1500.00, '2022-08-20', 4),
('Valeria', 'López', 'Activo', 'valeria99', 'Marketing Digital', 2000.00, '2023-02-18', 5),
('Miguel', 'Torres', 'Activo', 'miguel88', 'Soporte Técnico', 1700.00, '2022-09-25', 6),
('Camila', 'Hernández', 'Activo', 'camila77', 'Desarrollador Backend', 2600.00, '2021-04-11', 7),
('Luis', 'Fernández', 'Activo', 'luis55', 'Diseñador Gráfico', 1900.00, '2023-01-15', 8),
('Ana', 'Morales', 'Activo', 'ana44', 'Contadora General', 2300.00, '2021-06-01', 9),
('David', 'Castro', 'Activo', 'david11', 'Asistente Administrativo', 1400.00, '2022-10-10', 10),
('Elena', 'Pineda', 'Activo', 'elena22', 'Analista de Datos', 1800.00, '2023-05-05', 2),
('Pablo', 'Reyes', 'Activo', 'pablo66', 'Vendedor', 1500.00, '2022-12-01', 4),
('Lucía', 'García', 'Activo', 'lucia33', 'Marketing Creativo', 2000.00, '2023-03-22', 5),
('Javier', 'Ramos', 'Activo', 'javi99', 'Soporte Técnico', 1700.00, '2021-09-09', 6),
('Martina', 'Salazar', 'Activo', 'martina22', 'Desarrolladora Frontend', 2600.00, '2022-01-25', 7),
('Felipe', 'Ortega', 'Activo', 'felipe44', 'Diseñador UI/UX', 1900.00, '2022-07-30', 8),
('Carolina', 'Mendoza', 'Activo', 'caro77', 'Contadora Junior', 2100.00, '2023-04-19', 9),
('Tomás', 'Suárez', 'Activo', 'tomas55', 'Asistente de RRHH', 1500.00, '2023-06-11', 3),
('Isabella', 'Vega', 'Activo', 'isa88', 'Analista de Datos', 1850.00, '2022-11-23', 2),
('Ricardo', 'Flores', 'Activo', 'ricardo33', 'Vendedor', 1550.00, '2023-07-03', 4);



-- ==========================================
-- DATOS COMPLETOS DE LOGIN (100 registros)
-- ==========================================
INSERT INTO login (id_usuario, fecha_hora_login, estado_login) VALUES
(1, '2025-01-02 08:00:00', 'Exitoso'),
(1, '2025-01-03 08:05:00', 'Fallido'),
(1, '2025-01-10 08:10:00', 'Exitoso'),
(2, '2025-01-11 09:00:00', 'Exitoso'),
(2, '2025-01-18 09:10:00', 'Fallido'),
(2, '2025-02-05 09:20:00', 'Exitoso'),
(3, '2025-02-06 07:45:00', 'Exitoso'),
(3, '2025-02-10 08:10:00', 'Exitoso'),
(3, '2025-02-18 08:15:00', 'Fallido'),
(4, '2025-02-20 08:25:00', 'Exitoso'),
(4, '2025-03-01 08:30:00', 'Exitoso'),
(4, '2025-03-05 08:40:00', 'Fallido'),
(5, '2025-03-10 09:00:00', 'Exitoso'),
(5, '2025-03-15 09:15:00', 'Exitoso'),
(5, '2025-03-20 09:25:00', 'Fallido'),
(6, '2025-04-01 09:30:00', 'Exitoso'),
(6, '2025-04-05 09:45:00', 'Exitoso'),
(6, '2025-04-08 09:50:00', 'Fallido'),
(7, '2025-04-10 10:00:00', 'Exitoso'),
(7, '2025-04-15 10:10:00', 'Exitoso'),
(7, '2025-04-20 10:20:00', 'Fallido'),
(8, '2025-05-01 10:30:00', 'Exitoso'),
(8, '2025-05-05 10:40:00', 'Fallido'),
(8, '2025-05-08 10:45:00', 'Exitoso'),
(9, '2025-05-10 10:50:00', 'Exitoso'),
(9, '2025-05-15 11:00:00', 'Fallido'),
(9, '2025-05-20 11:10:00', 'Exitoso'),
(10, '2025-06-01 11:15:00', 'Exitoso'),
(10, '2025-06-05 11:20:00', 'Exitoso'),
(10, '2025-06-10 11:25:00', 'Fallido'),
(11, '2025-06-15 11:30:00', 'Exitoso'),
(11, '2025-06-20 11:40:00', 'Exitoso'),
(11, '2025-06-25 11:50:00', 'Fallido'),
(12, '2025-07-01 12:00:00', 'Exitoso'),
(12, '2025-07-05 12:10:00', 'Exitoso'),
(12, '2025-07-08 12:15:00', 'Fallido'),
(13, '2025-07-10 12:20:00', 'Exitoso'),
(13, '2025-07-15 12:25:00', 'Exitoso'),
(13, '2025-07-20 12:30:00', 'Fallido'),
(14, '2025-08-01 12:40:00', 'Exitoso'),
(14, '2025-08-05 12:45:00', 'Exitoso'),
(14, '2025-08-10 12:50:00', 'Fallido'),
(15, '2025-08-15 13:00:00', 'Exitoso'),
(15, '2025-08-18 13:10:00', 'Exitoso'),
(15, '2025-08-22 13:15:00', 'Fallido'),
(16, '2025-09-01 13:20:00', 'Exitoso'),
(16, '2025-09-05 13:25:00', 'Exitoso'),
(16, '2025-09-08 13:30:00', 'Fallido'),
(17, '2025-09-10 13:40:00', 'Exitoso'),
(17, '2025-09-15 13:45:00', 'Exitoso'),
(17, '2025-09-20 13:50:00', 'Fallido'),
(18, '2025-10-01 14:00:00', 'Exitoso'),
(18, '2025-10-05 14:05:00', 'Exitoso'),
(18, '2025-10-08 14:10:00', 'Fallido'),
(19, '2025-10-10 14:15:00', 'Exitoso'),
(19, '2025-10-12 14:20:00', 'Exitoso'),
(19, '2025-10-15 14:25:00', 'Fallido'),
(20, '2025-10-20 14:30:00', 'Exitoso'),
(20, '2025-10-25 14:35:00', 'Exitoso'),
(20, '2025-10-28 14:40:00', 'Fallido'),
(1, '2025-11-01 08:00:00', 'Exitoso'),
(2, '2025-11-02 08:10:00', 'Exitoso'),
(3, '2025-11-03 08:20:00', 'Fallido'),
(4, '2025-11-04 08:30:00', 'Exitoso'),
(5, '2025-11-05 08:40:00', 'Exitoso'),
(6, '2025-11-06 08:50:00', 'Fallido'),
(7, '2025-11-07 09:00:00', 'Exitoso'),
(8, '2025-11-08 09:10:00', 'Exitoso'),
(9, '2025-11-09 09:20:00', 'Fallido'),
(10, '2025-11-10 09:30:00', 'Exitoso'),
(11, '2025-11-11 09:40:00', 'Exitoso'),
(12, '2025-11-12 09:50:00', 'Fallido'),
(13, '2025-11-13 10:00:00', 'Exitoso'),
(14, '2025-11-14 10:10:00', 'Exitoso'),
(15, '2025-11-15 10:20:00', 'Fallido'),
(16, '2025-11-16 10:30:00', 'Exitoso'),
(17, '2025-11-17 10:40:00', 'Exitoso'),
(18, '2025-11-18 10:50:00', 'Fallido'),
(19, '2025-11-19 11:00:00', 'Exitoso'),
(20, '2025-11-20 11:10:00', 'Exitoso'),
(1, '2025-12-01 08:00:00', 'Exitoso'),
(2, '2025-12-02 08:05:00', 'Fallido'),
(3, '2025-12-03 08:10:00', 'Exitoso'),
(4, '2025-12-04 08:15:00', 'Exitoso'),
(5, '2025-12-05 08:20:00', 'Fallido'),
(6, '2025-12-06 08:25:00', 'Exitoso'),
(7, '2025-12-07 08:30:00', 'Exitoso'),
(8, '2025-12-08 08:35:00', 'Fallido'),
(9, '2025-12-09 08:40:00', 'Exitoso'),
(10, '2025-12-10 08:45:00', 'Exitoso'),
(11, '2025-12-11 08:50:00', 'Fallido'),
(12, '2025-12-12 08:55:00', 'Exitoso'),
(13, '2025-12-13 09:00:00', 'Exitoso'),
(14, '2025-12-14 09:05:00', 'Fallido'),
(15, '2025-12-15 09:10:00', 'Exitoso'),
(16, '2025-12-16 09:15:00', 'Exitoso'),
(17, '2025-12-17 09:20:00', 'Fallido'),
(18, '2025-12-18 09:25:00', 'Exitoso'),
(19, '2025-12-19 09:30:00', 'Exitoso'),
(20, '2025-12-20 09:35:00', 'Fallido');





-- ==========================================
-- DATOS DE FIDELIZACIÓN (24 registros simulados)
-- ==========================================
INSERT INTO fidelizacion (id_usuario, fecha_actividad, tipo_actividad, descripcion_actividad, puntos_otorgados)
VALUES
(1, '2025-01-15', 'Voluntariado', 'Participación en jornada ambiental', 50),
(2, '2025-01-15', 'Capacitación', 'Curso de liderazgo', 40),
(3, '2025-02-01', 'Evento Corporativo', 'Asistencia a convención anual', 30),
(4, '2025-02-15', 'Capacitación', 'Taller de ventas', 60),
(5, '2025-03-01', 'Voluntariado', 'Apoyo a fundación local', 45),
(6, '2025-03-15', 'Actividad Interna', 'Competencia de equipos', 35),
(7, '2025-04-01', 'Capacitación', 'Formación en software interno', 50),
(8, '2025-04-15', 'Voluntariado', 'Donación y apoyo logístico', 40),
(9, '2025-05-01', 'Evento Corporativo', 'Aniversario de la empresa', 30),
(10, '2025-05-15', 'Capacitación', 'Charla motivacional', 55),
(11, '2025-06-01', 'Voluntariado', 'Reforestación local', 60),
(12, '2025-06-15', 'Capacitación', 'Taller de productividad', 50),
(13, '2025-07-01', 'Actividad Interna', 'Competencia de innovación', 45),
(14, '2025-07-15', 'Evento Corporativo', 'Reconocimiento anual', 40),
(15, '2025-08-01', 'Voluntariado', 'Apoyo social comunitario', 55),
(16, '2025-08-15', 'Capacitación', 'Curso de UX/UI', 65),
(17, '2025-09-01', 'Capacitación', 'Formación contable', 40),
(18, '2025-09-15', 'Actividad Interna', 'Día del colaborador', 35),
(19, '2025-10-01', 'Voluntariado', 'Campaña solidaria', 45),
(20, '2025-10-15', 'Capacitación', 'Entrenamiento de ventas', 60),
(1, '2025-11-01', 'Evento Corporativo', 'Conferencia empresarial', 50),
(2, '2025-11-15', 'Capacitación', 'Actualización profesional', 40),
(3, '2025-12-01', 'Voluntariado', 'Jornada navideña', 55),
(4, '2025-12-15', 'Capacitación', 'Taller de cierre anual', 60);
