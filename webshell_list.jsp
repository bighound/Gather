<%@ page import="java.io.*" %>
<%
    String path = request.getParameter("path");
    if (path == null || path.trim().isEmpty()) {
        path = "."; // Directorio actual si no se pasa parámetro
    }

    File dir = new File(path);
    if (dir.exists() && dir.isDirectory()) {
        out.println("<h3>Contenido de: " + dir.getCanonicalPath() + "</h3>");
        File[] files = dir.listFiles();
        if (files != null) {
            out.println("<ul>");
            for (File file : files) {
                String name = file.getName();
                String fullPath = file.getCanonicalPath();
                if (file.isDirectory()) {
                    out.println("<li>[DIR] <a href='?path=" + fullPath + "'>" + name + "</a></li>");
                } else {
                    out.println("<li>[FILE] " + name + "</li>");
                }
            }
            out.println("</ul>");
        } else {
            out.println("<p>No se pudo listar contenido del directorio.</p>");
        }
    } else {
        out.println("<p>Ruta inválida o no es un directorio: " + path + "</p>");
    }
%>


<%@ page import="java.io.*" %>
<%
    String ruta = request.getParameter("ver");
    if (ruta == null) ruta = ".";
    File carpeta = new File(ruta);
    if (carpeta.exists() && carpeta.isDirectory()) {
        for (File f : carpeta.listFiles()) {
            out.println(f.getName() + "<br>");
        }
    }
%>
