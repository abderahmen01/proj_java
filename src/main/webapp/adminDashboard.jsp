<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
  HttpSession userSession = request.getSession(false);
  if (userSession == null || !"administrateur".equals(userSession.getAttribute("role"))) {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
  }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard - Gestion de Formation</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Font Awesome for icons (Corrected) -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">


  <style>
    .navbar-brand img {
      height: 40px;
      margin-right: 10px;
    }
    .dashboard-header {
      background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
      url('https://images.unsplash.com/photo-1497864149936-d3163f0c0f4b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
      background-size: cover;
      background-position: center;
      height: 400px;
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      color: white;
      margin-top: 56px; /* Pour compenser la navbar fixe */
    }
    .image-section {
      background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
      url('https://via.placeholder.com/1500x500.png?text=Formateurs');
      background-size: cover;
      background-position: center;
      height: 300px;
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      color: white;
    }
    .image-section-participants {
      background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
      url('https://via.placeholder.com/1500x500.png?text=Participants');
      background-size: cover;
      background-position: center;
      height: 300px;
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      color: white;
    }
    .section-title {
      font-size: 2.5rem;
      font-weight: bold;
    }
  </style>
</head>
<body>

<!-- Barre de navigation -->
<nav class="navbar navbar-dark bg-dark fixed-top">
  <div class="container-fluid">
    <!-- Bouton pour ouvrir le menu latéral -->
    <button class="btn btn-dark" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarMenu">
      <i class="fas fa-bars"></i> <!-- This icon should now appear -->
    </button>

    <a class="navbar-brand mx-auto" href="
  <c:choose>
    <c:when test="${sessionScope.role == 'administrateur'}">
      ${pageContext.request.contextPath}/adminDashboard.jsp
    </c:when>
    <c:when test="${sessionScope.role == 'responsable'}">
      ${pageContext.request.contextPath}/responsableDashboard.jsp
    </c:when>
    <c:otherwise>
      ${pageContext.request.contextPath}/utilisateurDashboard.jsp
    </c:otherwise>
  </c:choose>
">
      <img src="https://cdn-icons-png.flaticon.com/512/1974/1974346.png" alt="Logo">
      SkillForge
    </a>
  </div>

</nav>
<!-- Sidebar Offcanvas -->
<div class="offcanvas offcanvas-start bg-dark text-white" tabindex="-1" id="sidebarMenu">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title">Menu</h5>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
  </div>
  <div class="offcanvas-body">
    <ul class="nav flex-column">
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/utilisateurs"><i class="fas fa-users"></i> Utilisateurs</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/formateurs"><i class="fas fa-chalkboard-teacher"></i> Formateurs</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/formations"><i class="fas fa-book-open"></i> Formations</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/participants"><i class="fas fa-user-graduate"></i> Participants</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/profils"><i class="fas fa-id-badge"></i> Profils</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/roles"><i class="fas fa-user-tag"></i> Roles</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/structures"><i class="fas fa-building"></i> Structures</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/domaines"><i class="fas fa-layer-group"></i> Domaines</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/employeurs"><i class="fas fa-briefcase"></i> Employeurs</a></li>
      <li class="nav-item mt-4"> <!-- marge supérieure pour séparation -->
        <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-sign-out-alt"></i> Déconnexion
        </a>
      </li>
    </ul>
  </div>
</div>

<!-- Section d'accueil avec image -->
<header class="dashboard-header">
  <div class="container">
    <h1 class="display-4 mb-4">Bienvenue sur la plateforme de gestion de formation</h1>
    <p class="lead mb-4">Optimisez la gestion de vos programmes de formation professionnelle</p>
    <a href="${pageContext.request.contextPath}/formations" class="btn btn-primary btn-lg">
      Voir les formations disponibles
    </a>
  </div>
</header>

<div class="container my-5">
  <div class="row g-4">
    <!-- Carte Formateurs -->
    <div class="col-md-6">
      <div class="card h-100 shadow-lg border-0">
        <img src="https://images.unsplash.com/photo-1580894732444-8ecded7900cd?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
             class="card-img-top"
             alt="Formateurs"
             style="height: 250px; object-fit: cover;">
        <div class="card-body text-center">
          <h3 class="card-title mb-3">
            <i class="fas fa-chalkboard-teacher me-2"></i>Gestion des Formateurs
          </h3>
          <p class="card-text">Découvrez notre équipe de formateurs experts et gérez leurs profils</p>
          <a href="${pageContext.request.contextPath}/formateurs"
             class="btn btn-primary btn-lg">
            Voir les formateurs
          </a>
        </div>
      </div>
    </div>

    <!-- Carte Participants -->
    <div class="col-md-6">
      <div class="card h-100 shadow-lg border-0">
        <img src="https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
             class="card-img-top"
             alt="Participants"
             style="height: 250px; object-fit: cover;">
        <div class="card-body text-center">
          <h3 class="card-title mb-3">
            <i class="fas fa-user-graduate me-2"></i>Gestion des Participants
          </h3>
          <p class="card-text">Suivez et managez les inscriptions des participants aux formations</p>
          <a href="${pageContext.request.contextPath}/participants"
             class="btn btn-success btn-lg">
            Voir les participants
          </a>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  .card {
    transition: transform 0.3s, box-shadow 0.3s;
    border-radius: 15px;
    overflow: hidden;
  }

  .card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.12);
  }

  .card-title {
    color: #2c3e50;
    font-weight: 600;
  }

  .card-text {
    color: #7f8c8d;
    min-height: 60px;
  }
</style>

<!-- Scripts Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>