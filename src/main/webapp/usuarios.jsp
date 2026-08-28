<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f4f4f9; }
        h1, h2 { color: #333; }
        nav { margin-bottom: 20px; background-color: #fff; padding: 15px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.05); }
        nav a { margin-right: 15px; text-decoration: none; color: #0275d8; font-weight: bold; }
        nav a:hover { text-decoration: underline; }
        form { background: white; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 400px; margin-bottom: 30px; }
        input[type="text"], input[type="email"] { width: 100%; padding: 8px; margin: 8px 0 15px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        button { background-color: #0275d8; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
        button:hover { background-color: #025aa5; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background: white; box-shadow: 0 0 10px rgba(0,0,0,0.05); }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; }
        .btn-delete { color: #d9534f; text-decoration: none; font-weight: bold; }
        .btn-delete:hover { text-decoration: underline; }
    </style>
</head>
<body>

    <nav>
        <a href="libros">📚 Gestionar Libros</a> | 
        <a href="usuarios">👥 Gestionar Usuarios</a> |
        <a href="prestamos">🤝 Gestionar Préstamos</a>
    </nav>

    <h1>Sistema de Biblioteca - Usuarios</h1>
    
    <h2>Agregar Nuevo Usuario</h2>
    <form action="usuarios" method="post">
        <label>RUT / DNI:</label>
        <input type="text" name="rut" placeholder="12345678-9" required>
        
        <label>Nombre Completo:</label>
        <input type="text" name="nombre" required>
        
        <label>Correo Electrónico:</label>
        <input type="email" name="email" required>
        
        <button type="submit">Registrar Usuario</button>
    </form>

    <h2>Listado de Usuarios Registrados</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>RUT</th>
                <th>Nombre</th>
                <th>Email</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="usuario" items="${listaUsuarios}">
                <tr>
                    <td>${usuario.id}</td>
                    <td>${usuario.rut}</td>
                    <td>${usuario.nombre}</td>
                    <td>${usuario.email}</td>
                    <td>
                        <a href="usuarios?accion=eliminar&id=${usuario.id}" class="btn-delete">Eliminar</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>
