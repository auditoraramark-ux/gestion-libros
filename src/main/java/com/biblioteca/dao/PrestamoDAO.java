package com.biblioteca.dao;

import com.biblioteca.database.ConexionBD;
import com.biblioteca.model.Prestamo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PrestamoDAO {

    public List<Prestamo> listar() throws SQLException {
        List<Prestamo> lista = new ArrayList<>();
        String sql = "SELECT p.*, l.titulo, u.nombre FROM prestamos p " +
                     "JOIN libros l ON p.libro_id = l.id " +
                     "JOIN usuarios u ON p.usuario_id = u.id";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Prestamo p = new Prestamo(
                    rs.getInt("id"),
                    rs.getInt("libro_id"),
                    rs.getInt("usuario_id"),
                    rs.getDate("fecha_prestamo"),
                    rs.getDate("fecha_devolucion")
                );
                p.setTituloLibro(rs.getString("titulo"));
                p.setNombreUsuario(rs.getString("nombre"));
                lista.add(p);
            }
        }
        return lista;
    }

    public void insertar(Prestamo prestamo) throws SQLException {
        String sqlPrestamo = "INSERT INTO prestamos (libro_id, usuario_id, fecha_prestamo) VALUES (?, ?, ?)";
        String sqlLibro = "UPDATE libros SET disponible = false WHERE id = ?";
        
        try (Connection con = ConexionBD.getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement psP = con.prepareStatement(sqlPrestamo);
                 PreparedStatement psL = con.prepareStatement(sqlLibro)) {
                
                psP.setInt(1, prestamo.getLibroId());
                psP.setInt(2, prestamo.getUsuarioId());
                psP.setDate(3, prestamo.getFechaPrestamo());
                psP.executeUpdate();

                psL.setInt(1, prestamo.getLibroId());
                psL.executeUpdate();

                con.commit();
            } catch (SQLException e) {
                con.rollback();
                throw e;
            }
        }
    }

    public void devolver(int id, int libroId) throws SQLException {
        String sqlPrestamo = "UPDATE prestamos SET fecha_devolucion = ? WHERE id = ?";
        String sqlLibro = "UPDATE libros SET disponible = true WHERE id = ?";
        
        try (Connection con = ConexionBD.getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement psP = con.prepareStatement(sqlPrestamo);
                 PreparedStatement psL = con.prepareStatement(sqlLibro)) {
                
                psP.setDate(1, new Date(System.currentTimeMillis()));
                psP.setInt(2, id);
                psP.executeUpdate();

                psL.setInt(1, libroId);
                psL.executeUpdate();

                con.commit();
            } catch (SQLException e) {
                con.rollback();
                throw e;
            }
        }
    }
}
