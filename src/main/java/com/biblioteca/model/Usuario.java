package com.biblioteca.model;

public class Usuario {
    private int id;
    private String rut;
    private String nombre;
    private String email;

    public Usuario() {}

    public Usuario(int id, String rut, String nombre, String email) {
        this.id = id;
        this.rut = rut;
        this.nombre = nombre;
        this.email = email;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getRut() { return rut; }
    public void setRut(String rut) { this.rut = rut; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}
