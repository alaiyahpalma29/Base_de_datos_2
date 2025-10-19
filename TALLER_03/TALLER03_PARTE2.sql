-- ==========================================
-- VISTA 1: v_DesempenoColaboradores
-- ==========================================
CREATE OR REPLACE VIEW v_DesempenoColaboradores AS
SELECT
    u.id_usuario,
    CONCAT(u.nombre, ' ', u.apellido) AS nombre_completo,
    u.cargo,
    u.salario,
    u.fecha_ingreso,
    
  
    IFNULL(SUM(f.puntos_otorgados), 0) AS total_puntos_fidelizacion_acumulados,
    
    
    IFNULL(AVG(f.puntos_otorgados), 0) AS promedio_puntos_por_actividad,
    
   
    CASE
        WHEN SUM(f.puntos_otorgados) > 500 THEN 'Excelente'
        WHEN SUM(f.puntos_otorgados) BETWEEN 200 AND 500 THEN 'Bueno'
        ELSE 'Regular'
    END AS estado_fidelizacion,
    
    
    DATEDIFF(CURDATE(), (
        SELECT MAX(l.fecha_hora_login)
        FROM login l
        WHERE l.id_usuario = u.id_usuario AND l.estado_login = 'Exitoso'
    )) AS dias_desde_ultimo_login

FROM usuarios u
LEFT JOIN fidelizacion f ON u.id_usuario = f.id_usuario
GROUP BY u.id_usuario, nombre_completo, u.cargo, u.salario, u.fecha_ingreso;



-- ==========================================
-- VISTA 2: v_ActividadesPorPerfil
-- ==========================================
CREATE OR REPLACE VIEW v_ActividadesPorPerfil AS
SELECT
    p.id_perfil,
    p.nombre_perfil,
    p.descripcion_perfil,
    
    COUNT(DISTINCT u.id_usuario) AS cantidad_usuarios_con_este_perfil,
    
    COUNT(f.id_fidelizacion) AS total_actividades_participadas_por_perfil,
    
    IFNULL(AVG(f.puntos_otorgados), 0) AS promedio_puntos_por_usuario_en_este_perfil,
    
    ROUND(
        (COUNT(f.id_fidelizacion) / (SELECT COUNT(*) FROM fidelizacion) * 100),
        2
    ) AS porcentaje_participacion_total

FROM perfiles p
LEFT JOIN usuarios u ON p.id_perfil = u.id_perfil
LEFT JOIN fidelizacion f ON u.id_usuario = f.id_usuario
GROUP BY p.id_perfil, p.nombre_perfil, p.descripcion_perfil;



-- ==========================================
-- VISTA 3: v_HistorialLoginDetallado
-- ==========================================
CREATE OR REPLACE VIEW v_HistorialLoginDetallado AS
SELECT
    u.nombre AS nombre_usuario,
    u.apellido AS apellido_usuario,
    u.cargo AS cargo_usuario,
    l.fecha_hora_login,
    l.estado_login,
    
    TIMESTAMPDIFF(
        MINUTE,
        LAG(l.fecha_hora_login) OVER (PARTITION BY l.id_usuario ORDER BY l.fecha_hora_login),
        l.fecha_hora_login
    ) AS tiempo_desde_anterior_login

FROM login l
INNER JOIN usuarios u ON l.id_usuario = u.id_usuario
ORDER BY u.id_usuario, l.fecha_hora_login;



SELECT nombre_completo, cargo, total_puntos_fidelizacion_acumulados
FROM v_DesempenoColaboradores
ORDER BY total_puntos_fidelizacion_acumulados DESC
LIMIT 5;



SELECT nombre_perfil, total_actividades_participadas_por_perfil, porcentaje_participacion_total
FROM v_ActividadesPorPerfil
ORDER BY total_actividades_participadas_por_perfil ASC
LIMIT 3;



SELECT nombre_completo, cargo, dias_desde_ultimo_login
FROM v_DesempenoColaboradores
WHERE dias_desde_ultimo_login > 30;



SELECT 
    DATE_FORMAT(fecha_hora_login, '%Y-%m') AS mes,
    SUM(CASE WHEN estado_login = 'Exitoso' THEN 1 ELSE 0 END) AS logins_exitosos,
    SUM(CASE WHEN estado_login = 'Fallido' THEN 1 ELSE 0 END) AS logins_fallidos
FROM login
GROUP BY mes
ORDER BY mes;

