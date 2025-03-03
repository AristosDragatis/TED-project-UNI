<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Εμφάνισω Όλων</title>
</head>
<body>
	<h1 style="text-align:center">Εμφάνιση Αντικειμένων</h1>
	<% 
        String driver = "org.sqlite.JDBC";
        String dbpath = "C:\\TED\\workspace\\eclipse\\2111\\laf2111\\src\\main\\webapp\\WEB-INF\\laf.db";
        String dbURL = "jdbc:sqlite:" + dbpath;
        String qry = "SELECT id, description, finder, location FROM LostAndFound";
        String[] columns = new String[] { "id", "description", "finder", "location" };
        String[] columnsVisible = new String[] { "ΚΩΔΙΚΟΣ", "ΠΕΡΙΓΡΑΦΗ", "ΕΥΡΩΝ", "ΤΟΠΟΘΕΣΙΑ" };

        Connection dbCon = null;
        Statement stmt = null;
        ResultSet rs = null;
        

        try {
            Class.forName(driver);
            dbCon = DriverManager.getConnection(dbURL);
            stmt = dbCon.createStatement();
            rs = stmt.executeQuery(qry);

            out.println("<table border='1'>");
            out.println("<tr>");
            for (String header : columnsVisible) {
                out.println("<th>" + header + "</th>");
            }
            out.println("</tr>");

            while (rs.next()) {
                out.println("<tr>");

                // Εκτύπωση όλων των κελιών
                for (String col : columns) {
                    out.println("<td>" + rs.getString(col) + "</td>"); 
                }
                // εκτώπωση κουμπιού Διαγραφή δίπλα από κάθε εγγραφή
                out.println("<td>");
                out.println("<form method='post' action='controller'>" +
                            "<input type='hidden' name='id' value='" + rs.getString("id") + "'>" +
                            "<button type='submit' onclick=\"return confirm('Είστε σίγουρος;')\")>Διαγραφή</button>" +
                            "</form>");
                out.println("</td>");

                out.println("</tr>");
            }
            out.println("</table>");
        } catch (Exception e) {
            out.println("<p>Σφάλμα: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (dbCon != null) dbCon.close();
            } catch (SQLException e) {
                out.println("<p>Σφάλμα κατά το κλείσιμο της σύνδεσης: " + e.getMessage() + "</p>");
            }
        }
    %>
    
    <% if (request.getAttribute("successmsg") != null) { %>
    <p style="color:green;"><%= request.getAttribute("successmsg") %></p>
	<% } %>
	
	<% if (request.getAttribute("errormsg") != null) { %>
	    <p style="color:red;"><%= request.getAttribute("errormsg") %></p>
	<% } %>
	<a href="index.jsp">Επιστροφή στην αρχική σελίδα</a>
    <br>
	<footer style = "position:center; bottom:0; text-align:center;">
        <p><strong>Δημιουργήθηκε από Αριστείδης Δραγάτης 2111</strong></p>
    </footer>
</body>
</html>
