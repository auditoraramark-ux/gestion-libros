# Gestión Libros - Administrador de Catálogos de Lectura

API REST diseñada para la persistencia, inventario y catalogación eficiente de obras literarias, estructurada bajo buenas prácticas de diseño técnico de software.

## Características Principales
* Implementación completa de operaciones fundamentales de creación, lectura, actualización y eliminación de registros (CRUD).
* Validación estricta de datos en los puntos de entrada del servidor mediante anotaciones para asegurar la calidad de la información.
* Abstracción limpia de la capa de datos optimizando las consultas al motor relacional.
* Flujo de ramificación ordenado bajo el estándar GitFlow para el desarrollo del repositorio.

## Patrón Arquitectónico de Entrada y Persistencia
Flujo de datos limpio desde el punto de entrada REST hasta el motor relacional:

```mermaid
graph TD
    A[Petición Externa / API Client] -->|Datos de Entrada| B[BookController]
    B -->|@Valid / Validación de Datos| C[BookService]
    C --> D[BookRepository]
    D --> E[(Base de Datos MySQL)]
```

## Estructura del Proyecto (Estructura de Directorios)
```text
src/
├── main/
│   ├── java/com/gestionlibros/
│   │   ├── controllers/ # Endpoints de la API REST (CRUD)
│   │   ├── services/    # Lógica de catalogación e inventarios
│   │   ├── repositories/# Consultas y repositorios de Spring Data JPA
│   │   └── models/      # Entidades anotadas con Hibernate Validator
│   └── resources/
│       └── application.properties # Configuración del DataSource
```

## Tecnologías Utilizadas
* Java 17
* Spring Boot
* Spring Data JPA
* Hibernate
* MySQL
