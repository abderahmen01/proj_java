package tn.gs.projet.controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import tn.gs.projet.dao.*;
import tn.gs.projet.model.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/formations")
public class FormationServlet extends HttpServlet {
    private FormationDao formationDao;
    private DomaineDao domaineDao;
    private ParticipantDao participantDao;

    @Override
    public void init() {
        formationDao = new FormationDao();
        domaineDao = new DomaineDao();
        participantDao = new ParticipantDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") == null ? "list" : request.getParameter("action");
        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "add":
                    addEditFormation(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteFormation(request, response);
                    break;
                default:
                    listFormations(request, response);
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    private void listFormations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("formations", formationDao.findAll());
        request.getRequestDispatcher("/formations.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("domaines", domaineDao.findAll());
        request.setAttribute("participants", participantDao.findAll());
        request.getRequestDispatcher("/addFormation.jsp").forward(request, response);
    }

    private void addEditFormation(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Formation formation = new Formation();
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            formation = formationDao.findById(Long.parseLong(id));
        }
        formation.setTitre(request.getParameter("titre"));
        formation.setDomaine(domaineDao.findById(Long.parseLong(request.getParameter("domaineId"))));
        // Gérer les participants (ManyToMany)
        formationDao.saveOrUpdate(formation);
        response.sendRedirect("formations?action=list");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Formation formation = formationDao.findById(id);
        request.setAttribute("formation", formation);
        request.setAttribute("domaines", domaineDao.findAll());
        request.setAttribute("participants", participantDao.findAll());
        request.getRequestDispatcher("/addFormation.jsp").forward(request, response);
    }

    private void deleteFormation(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        formationDao.delete(id);
        response.sendRedirect("formations?action=list");
    }
}
