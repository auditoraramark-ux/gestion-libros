package com.biblioteca.controller;

import com.biblioteca.dao.LibroDAO;
import com.biblioteca.dao.PrestamoDAO;
import com.biblioteca.dao.UsuarioDAO;
import com.biblioteca.model.Prestamo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

@WebServlet("/prestamos")
public class PrestamoServlet extends HttpServlet {
    private PrestamoDAO prestamoDAO = new PrestamoDAO();
    private LibroDAO libroDAO = new LibroDAO();
    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        try {
            if ("devolver".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                int libroId = Integer.parseInt(request.getParameter("libroId"));
                prestamoDAO.devolver(id, libroId);
                response.sendRedirect("prestamos");
            } else {
                request.setAttribute("listaPrestamos", prestamoDAO.listar());
                request.setAttribute("listaLibros", libroDAO.listar());
                request.setAttribute("listaUsuarios", usuarioDAO.listar());
                request.getRequestDispatcher("prestamos.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int libroId = Integer.parseInt(request.getParameter("libroId"));
        int usuarioId = Integer.parseInt(request.getParameter("usuarioId"));
        Date fecha = new Date(System.currentTimeMillis());

        Prestamo nuevoPrestamo = new Prestamo(0, libroId, usuarioId, fecha, null);
        try {
            prestamoDAO.insertar(nuevoPrestamo);
            response.sendRedirect("prestamos");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
