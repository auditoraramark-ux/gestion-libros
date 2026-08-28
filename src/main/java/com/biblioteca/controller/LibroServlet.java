package com.biblioteca.controller;

import com.biblioteca.dao.LibroDAO;
import com.biblioteca.model.Libro;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/libros")
public class LibroServlet extends HttpServlet {
    private LibroDAO libroDAO = new LibroDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        try {
            if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                libroDAO.eliminar(id);
                response.sendRedirect("libros");
            } else {
                List<Libro> lista = libroDAO.listar();
                request.setAttribute("listaLibros", lista);
                request.getRequestDispatcher("libros.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String isbn = request.getParameter("isbn");

        Libro nuevoLibro = new Libro(0, titulo, autor, isbn, true);
        try {
            libroDAO.insertar(nuevoLibro);
            response.sendRedirect("libros");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
