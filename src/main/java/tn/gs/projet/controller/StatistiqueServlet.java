package tn.gs.projet.controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import tn.gs.projet.dao.FormationDao;
import tn.gs.projet.dao.ParticipantDao;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "StatistiqueServlet", urlPatterns = "/responsable")
public class StatistiqueServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FormationDao formationDao = new FormationDao();
        ParticipantDao participantDao = new ParticipantDao();

        // Domain statistics
        List<Object[]> domainStats = formationDao.getFormationsByDomain();
        request.setAttribute("domainStats", domainStats);

        // Yearly statistics
        List<Object[]> yearlyStats = formationDao.getFormationsByYear();
        request.setAttribute("yearlyStats", yearlyStats);

        // Profile statistics
        List<Object[]> profileStats = participantDao.getParticipantsByProfil();
        request.setAttribute("profileStats", profileStats);

        // Structure statistics
        List<Object[]> structureStats = participantDao.getParticipantsByStructure();
        request.setAttribute("structureStats", structureStats);

        request.getRequestDispatcher("/WEB-INF/views/responsableDashboard.jsp").forward(request, response);
        System.out.println("Domain Stats: " + domainStats.size());
        System.out.println("Yearly Stats: " + yearlyStats.size());
// Repeat for profile/structure stats
    }


}
