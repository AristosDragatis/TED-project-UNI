package laf2111;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.*;
import java.sql.*;

@WebServlet("/controller")
public class Controller extends HttpServlet {

    String driver = "org.sqlite.JDBC";
    String dbURL; 

    // αρχικοποίηση μονοπατιού αρχείου βάσης δεδομένων και jdbc driver
    public void init() { 
    	String dbpath = "C:/TED/workspace/eclipse/2111/laf2111/src/main/webapp/WEB-INF/laf.db";
        dbURL = "jdbc:sqlite:" + dbpath;
    }

    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

    	// αρχικοποίηση session
        HttpSession session = req.getSession();
        req.setCharacterEncoding("utf-8");

        Connection dbCon = null;
        PreparedStatement stmt = null;

        String description = req.getParameter("description");
        String finder = req.getParameter("finder");
        String location = req.getParameter("location");
        String id = req.getParameter("id");  // Id από το κουμπί διαγραφής

        String errorMessage = null;
        String successMessage = null;

        try {
        	// παίρνουμε το connection για να κάνουμε τις απαραίτητες ενέργειες στη βάση.
            Class.forName(driver);
            dbCon = DriverManager.getConnection(dbURL);

            if (id != null && !id.isEmpty()) {
                // Διαγραφή εγγραφής με βάση το id
                String deleteQry = "DELETE FROM LostAndFound WHERE id = ?";
                stmt = dbCon.prepareStatement(deleteQry);
                stmt.setString(1, id);
                
                int rowsDeleted = stmt.executeUpdate();
                System.out.println("Deleted " + rowsDeleted + " row(s)");

                successMessage = "Η διαγραφή ολοκληρώθηκε.";
                req.setAttribute("successmsg", successMessage);
                // Ανακατεύθυνση στη σελίδα εμφάνισης αντικειμένων με χρήση RequestDispatcher
                RequestDispatcher dispatcher = req.getRequestDispatcher("view_all.jsp");
                dispatcher.forward(req, res);
            } else {
            	// Εισαγωγή στη βάση δεδομένων
                String insertQry = "INSERT INTO LostAndFound (description, finder, location) VALUES (?, ?, ?)";
                stmt = dbCon.prepareStatement(insertQry);
                stmt.setString(1, description);
                stmt.setString(2, finder);
                stmt.setString(3, location);

                int rowsInserted = stmt.executeUpdate();
                System.out.println("Inserted " + rowsInserted + " row(s)");
                successMessage = "Η εισαγωγή ολοκληρώθηκε.";
                req.setAttribute("successmsg", successMessage);
                // ανακατεύθυνση στη σελίδα insert για εμφάνιση του μηνύματος επιτυχίας
                RequestDispatcher dispatcher = req.getRequestDispatcher("insert.jsp");
                dispatcher.forward(req, res);
            }
        } catch (Exception e) {
        	// σε περίπτωση exception κρατάμε τις τιμές των πεδίων του χρήστη.
            session.setAttribute("description", description);
            session.setAttribute("finder", finder);
            session.setAttribute("location", location);

            errorMessage = java.net.URLEncoder.encode(e.getMessage(), "UTF-8");
            req.setAttribute("errormsg", errorMessage);

            // ανακατεύθυνση στην ίδια την insert ώστε να εμφανιστεί το μήνυμα αποτυχίας.
            RequestDispatcher dispatcher = req.getRequestDispatcher("insert.jsp");
            dispatcher.forward(req, res);
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (dbCon != null) dbCon.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        // καθαρίζουμε τις τιμές των πεδίων στο τέλος.
        session.removeAttribute("description");
        session.removeAttribute("finder");
        session.removeAttribute("location");
    }
}
