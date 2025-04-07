package tn.gs.projet.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getRequestURI().substring(request.getContextPath().length());

        // Autoriser login, logout et les ressources statiques
        if (path.startsWith("/login")
                || path.startsWith("/login.jsp")
                || path.startsWith("/domaines.jsp")
                || path.startsWith("/employeurs.jsp")
                || path.startsWith("/formateurs.jsp")
                || path.startsWith("/formations.jsp")
                || path.startsWith("/participants.jsp")
                || path.startsWith("/profils.jsp")
                || path.startsWith("/roles.jsp")
                || path.startsWith("/structures.jsp")
                || path.startsWith("/utilisateurs.jsp")
                || path.startsWith("/logout")
                || path.startsWith("/css/")
                || path.startsWith("/js/")
                || path.equals("/adminDashboard.jsp")) {
            chain.doFilter(request, response);
            return;
        }

        // Vérifier la session
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (role == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        chain.doFilter(request, response);
    }
}
