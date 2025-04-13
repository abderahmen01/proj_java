<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
  HttpSession userSession = request.getSession(false);
  String role = (userSession != null) ? (String) userSession.getAttribute("role") : null;

  // Autoriser uniquement "responsable" et "administrateur"
  if (userSession == null || !("responsable".equals(role) || "administrateur".equals(role))) {
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

      <!-- Bouton Accueil -->
      <a class="btn btn-dark me-3"
         href="${pageContext.request.contextPath}/<%= "responsable".equals(role) ? "homeDashboard.jsp" : "adminDashboard.jsp" %>">
        <i class="fas fa-home"></i>
      </a>


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
</div>

<div class="container" style="margin-top: 80px;">
  <!-- Début de la ligne -->
  <div class="row g-4"> <!-- Ajout de gutter (espacement) -->

    <!-- Colonne 1 - Formations par domaine -->
    <div class="col-md-6">
      <div class="stat-card">
        <h4><i class="fas fa-book-open me-2"></i>Formations par domaine</h4>
        <div class="chart-container">
          <canvas id="domainChart"></canvas>
        </div>
      </div>
    </div>

    <!-- Colonne 2 - Participants par profil -->
    <div class="col-md-6">
      <div class="stat-card">
        <h4><i class="fas fa-users me-2"></i>Participants par profil</h4>
        <div class="chart-container">
          <canvas id="profileChart"></canvas>
        </div>
      </div>
    </div>

    <!-- Nouvelle Carte 3 - Formations par année -->
    <div class="col-md-6">
      <div class="stat-card">
        <h4><i class="fas fa-calendar-alt me-2"></i>Formations par année</h4>
        <canvas id="yearChart"></canvas>
      </div>
    </div>

    <!-- Nouvelle Carte 4 - Budget par domaine -->
    <div class="col-md-6">
      <div class="stat-card">
        <h4><i class="fas fa-coins me-2"></i>Budget par domaine</h4>
        <canvas id="budgetChart"></canvas>
      </div>
    </div>

  </div>
</div>

<script>
  document.addEventListener("DOMContentLoaded", function() {

    // Récupérer les données JSON
    const formationsData = JSON.parse('<c:out value="${formationsParDomaineJSON}" escapeXml="false"/>');
    const participantsData = JSON.parse('<c:out value="${participantsParProfilJSON}" escapeXml="false"/>');
    const yearsData = JSON.parse('${formationsParAnneeJSON}');
    const budgetData = JSON.parse('${budgetParDomaineJSON}');

    // Graphique "Formations par domaine"
    new Chart(document.getElementById("domainChart"), {
      type: "pie",
      data: {
        labels: Object.keys(formationsData),
        datasets: [{
          data: Object.values(formationsData),
          backgroundColor: ["#4e73df", "#1cc88a", "#36b9cc", "#f6c23e"]
        }]
      },
      options: {
        responsive: true,
        plugins: {
          legend: { position: "bottom" }
        }
      }
    });

    // Graphique "Participants par profil"
    new Chart(document.getElementById("profileChart"), {
      type: "doughnut",
      data: {
        labels: Object.keys(participantsData),
        datasets: [{
          data: Object.values(participantsData),
          backgroundColor: ["#4e73df", "#1cc88a", "#36b9cc"]
        }]
      },
      options: {
        responsive: true,
        plugins: {
          legend: { position: "bottom" }
        }
      }
    });

    // Graphique Formations par année (Bar Chart)
    new Chart(document.getElementById("yearChart"), {
      type: "bar",
      data: {
        labels: Object.keys(yearsData),
        datasets: [{
          label: "Nombre de formations",
          data: Object.values(yearsData),
          backgroundColor: "#4e73df"
        }]
      },
      options: {
        responsive: true,
        plugins: { legend: { display: false } }
      }
    });

    // Graphique Budget par domaine (Line Chart)
    new Chart(document.getElementById("budgetChart"), {
      type: "line",
      data: {
        labels: Object.keys(budgetData),
        datasets: [{
          label: "Budget (€)",
          data: Object.values(budgetData),
          borderColor: "#1cc88a",
          fill: false
        }]
      },
      options: {
        responsive: true,
        plugins: { legend: { position: "bottom" } }
      }
    });
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>