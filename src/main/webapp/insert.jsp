<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Εισαγωγή</title>
</head>
<body>
	<h1>Εισαγωγή Αντικειμένων</h1>
    <form action="controller" method="POST">
    <b>Παρακαλώ δώστε τα ακόλουθα στοιχεία: </b> <br>
    <b>Περιγραφή: </b> <input type="text" name="description" value="<%= session.getAttribute("description") != null ? session.getAttribute("description") : "" %>"><br>
    <b>Ευρών: </b> <input type="text" name="finder" value="<%= session.getAttribute("finder") != null ? session.getAttribute("finder") : "" %>"><br>
    <b>Τοποθεσία: </b> <input type="text" name="location" value="<%= session.getAttribute("location") != null ? session.getAttribute("location") : "" %>"><br>
    <input type="submit" value="Εισαγωγή">
    </form>
    <% 
        String errorMessage = (String) request.getAttribute("errormsg");
        if (errorMessage != null) {
    %>
        <strong style="color:red"> Σφάλμα εισαγωγής: <%= errorMessage %></strong>
    <% 
        }
        String successMessage = (String) request.getAttribute("successmsg");
        if (successMessage != null) {
    %>
        <strong style="color:green"><%= successMessage %></strong>
    <% 
        }
    %>
    
    <br>
    <a href="index.jsp">Επιστροφή στην αρχική σελίδα</a>
    
    <footer style = "position:center; bottom:0; text-align:center;">
        <p><strong>Δημιουργήθηκε από Αριστείδης Δραγάτης 2111</strong></p>
    </footer>
</body>
</html>