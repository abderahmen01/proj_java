<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || !"responsable".equals(userSession.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Responsable</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .chart-container {
            height: 400px;
            position: relative;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container-fluid d-flex justify-content-between align-items-center">

        <!-- Gauche : burger + menu utilisateur -->
        <div class="d-flex align-items-center">
            <button class="btn btn-dark me-3" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarMenu">
                <i class="fas fa-bars"></i>
            </button>

            <!-- Menu utilisateur -->
            <div class="dropdown">
                <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
                   id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-user-circle fa-2x me-2"></i>
                    <span>Bonjour, <strong><%= userSession.getAttribute("login") %> !</strong></span>
                </a>
                <ul class="dropdown-menu dropdown-menu-start text-small shadow" aria-labelledby="userDropdown">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Déconnexion</a></li>
                </ul>
            </div>
        </div>

        <!-- Milieu : Logo -->
        <a class="navbar-brand mx-auto" href="#">
            <img src="https://cdn-icons-png.flaticon.com/512/1974/1974346.png" alt="Logo" style="height:40px">
            Tableau de Bord Responsable
        </a>

    </div>
</nav>

<div class="offcanvas offcanvas-start bg-dark text-white" tabindex="-1" id="sidebarMenu">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title">Menu</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/stats">
                    <i class="fas fa-chart-pie"></i> Statistiques
                </a>
            </li>
        </ul>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>