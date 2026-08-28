package com.biblioteca.controller;

import com.biblioteca.dao.UsuarioDAO;
import com.biblioteca.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/usuarios")
public class UsuarioServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        try {
            if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                usuarioDAO.eliminar(id);
                response.sendRedirect("usuarios");
            } else {
                List<Usuario> lista = usuarioDAO.listar();
                request.setAttribute("listaUsuarios", lista);
                request.getRequestDispatcher("usuarios.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String rut = request.getParameter("rut");
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");

        Usuario nuevoUsuario = new Usuario(0, rut, nombre, email);
        try {
            usuarioDAO.insertar(nuevoUsuario);
            response.sendRedirect("usuarios");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
