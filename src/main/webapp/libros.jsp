<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Libros</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f4f4f9; }
        h1, h2 { color: #333; }
        nav { margin-bottom: 20px; background-color: #fff; padding: 15px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.05); }
        nav a { margin-right: 15px; text-decoration: none; color: #0275d8; font-weight: bold; }
        nav a:hover { text-decoration: underline; }
        form { background: white; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 400px; margin-bottom: 30px; }
        input[type="text"] { width: 100%; padding: 8px; margin: 8px 0 15px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        button { background-color: #5cb85c; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
        button:hover { background-color: #4cae4c; }
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

    <h1>Sistema de Biblioteca - Libros</h1>
    
    <h2>Agregar Nuevo Libro</h2>
    <form action="libros" method="post">
        <label>Título:</label>
        <input type="text" name="titulo" required>
        
        <label>Autor:</label>
        <input type="text" name="autor" required>
        
        <label>ISBN:</label>
        <input type="text" name="isbn" required>
        
        <button type="submit">Guardar Libro</button>
    </form>

    <h2>Listado de Libros Registrados</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Título</th>
                <th>Autor</th>
                <th>ISBN</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="libro" items="${listaLibros}">
                <tr>
                    <td>${libro.id}</td>
                    <td>${libro.titulo}</td>
                    <td>${libro.autor}</td>
                    <td>${libro.isbn}</td>
                    <td>
                        <c:choose>
                            <c:when test="${libro.disponible}">
                                <span style="color: green; font-weight: bold;">Disponible</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: red; font-weight: bold;">Prestado</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="libros?accion=eliminar&id=${libro.id}" class="btn-delete">Eliminar</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>
