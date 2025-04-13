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

        // Autoriser les ressources publiques
        if (path.startsWith("/login") || path.startsWith("/css/") || path.startsWith("/js/") || path.startsWith("/logout")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (role == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        chain.doFilter(request, response);
    }
}