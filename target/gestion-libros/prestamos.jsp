<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Préstamos</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f4f4f9; }
        h1, h2 { color: #333; }
        nav { margin-bottom: 20px; background-color: #fff; padding: 15px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.05); }
        nav a { margin-right: 15px; text-decoration: none; color: #0275d8; font-weight: bold; }
        form { background: white; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 400px; margin-bottom: 30px; }
        select, button { width: 100%; padding: 10px; margin: 8px 0 15px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        button { background-color: #f0ad4e; color: white; border: none; cursor: pointer; font-weight: bold; }
        button:hover { background-color: #ec971f; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background: white; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; }
        .btn-action { color: #0275d8; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

    <nav>
        <a href="libros">📚 Gestionar Libros</a> | 
        <a href="usuarios">👥 Gestionar Usuarios</a> |
        <a href="prestamos">🤝 Gestionar Préstamos</a>
    </nav>

    <h1>Sistema de Biblioteca - Préstamos</h1>
    
    <h2>Agendar Nuevo Préstamo</h2>
    <form action="prestamos" method="post">
        <label>Seleccionar Usuario:</label>
        <select name="usuarioId" required>
            <c:forEach var="usuario" items="${listaUsuarios}">
                <option value="${usuario.id}">${usuario.nombre} (${usuario.rut})</option>
            </c:forEach>
        </select>
        
        <label>Seleccionar Libro Disponible:</label>
        <select name="libroId" required>
            <c:forEach var="libro" items="${listaLibros}">
                <c:if test="${libro.disponible}">
                    <option value="${libro.id}">${libro.titulo} - ${libro.autor}</option>
                </c:if>
            </c:forEach>
        </select>
        
        <button type="submit">Confirmar Préstamo</button>
    </form>

    <h2>Historial de Préstamos</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Libro</th>
                <th>Usuario</th>
                <th>Fecha Préstamo</th>
                <th>Fecha Devolución</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="p" items="${listaPrestamos}">
                <tr>
                    <td>${p.id}</td>
                    <td>${p.tituloLibro}</td>
                    <td>${p.nombreUsuario}</td>
                    <td>${p.fechaPrestamo}</td>
                    <td>
                        <c:choose>
                            <c:when test="${p.fechaDevolucion != null}">${p.fechaDevolucion}</c:when>
                            <c:otherwise><span style="color: red; font-weight: bold;">Activo</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${p.fechaDevolucion == null}">
                            <a href="prestamos?accion=devolver&id=${p.id}&libroId=${p.libroId}" class="btn-action">Marcar Devolución</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>
