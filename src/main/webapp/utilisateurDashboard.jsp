<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
  HttpSession userSession = request.getSession(false);
  if (userSession == null || !"simple_utilisateur".equals(userSession.getAttribute("role"))) {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
  }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard Utilisateur - Gestion</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

  <style>
    .quick-action-card {
      background: white;
      border-radius: 15px;
      padding: 25px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      transition: transform 0.3s;
      text-align: center;
    }
    .quick-action-card:hover {
      transform: translateY(-5px);
    }
  </style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark fixed-top">
  <div class="container-fluid">
    <button class="btn btn-dark" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarMenu">
      <i class="fas fa-bars"></i>
    </button>
    <a class="navbar-brand mx-auto" href="#">
      <img src="https://cdn-icons-png.flaticon.com/512/1974/1974346.png" alt="Logo" style="height:40px">
      Espace Utilisateur
    </a>
  </div>
</nav>

<div class="offcanvas offcanvas-start bg-dark text-white" tabindex="-1" id="sidebarMenu">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title">Menu Rapide</h5>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
  </div>
  <div class="offcanvas-body">
    <ul class="nav flex-column">
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/formateurs"><i class="fas fa-chalkboard-teacher"></i> Formateurs</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/formations"><i class="fas fa-book-open"></i> Formations</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/participants"><i class="fas fa-user-graduate"></i> Participants</a></li>
      <li class="nav-item mt-4"> <!-- marge supérieure pour séparation -->
        <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-sign-out-alt"></i> Déconnexion
        </a>
      </li>
    </ul>
  </div>
</div>

<div class="container" style="margin-top: 80px;">

  <div class="row g-4">
    <!-- Carte Ajout Rapide Formateur -->
    <div class="col-md-4">
      <div class="quick-action-card">
        <i class="fas fa-user-plus fa-3x text-primary mb-3"></i>
        <h5>Nouveau Formateur</h5>
        <a href="${pageContext.request.contextPath}/formateurs?action=new" class="btn btn-primary mt-2">Ajouter</a>
      </div>
    </div>

    <!-- Carte Création Formation -->
    <div class="col-md-4">
      <div class="quick-action-card">
        <i class="fas fa-calendar-plus fa-3x text-success mb-3"></i>
        <h5>Nouvelle Formation</h5>
        <a href="${pageContext.request.contextPath}/formations?action=new" class="btn btn-success mt-2">Créer</a>
      </div>
    </div>

    <!-- Carte Inscription Participant -->
    <div class="col-md-4">
      <div class="quick-action-card">
        <i class="fas fa-user-check fa-3x text-info mb-3"></i>
        <h5>Inscrire Participant</h5>
        <a href="${pageContext.request.contextPath}/participants?action=new" class="btn btn-info mt-2">Inscrire</a>
      </div>
    </div>
  </div>

  <!-- Section Dernières Formations -->
  <section class="my-5">
    <h4 class="mb-4"><i class="fas fa-history me-2"></i>Dernières Formations</h4>
    <div class="list-group">
      <c:forEach items="${formations}" var="formation" end="4">
        <a href="#" class="list-group-item list-group-item-action">
            ${formation.titre} - ${formation.domaine.libelle}
        </a>
      </c:forEach>
    </div>
  </section>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>