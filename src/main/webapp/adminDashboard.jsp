<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
  // Forcer le navigateur à ne pas cacher la page
  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
  response.setHeader("Pragma", "no-cache");
  response.setDateHeader("Expires", 0);
%>

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

  <!-- Bootstrap + FontAwesome -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

  <!-- Animations + Loader CSS -->
  <style>
    /* Loader */
    #loader {
      position: fixed;
      z-index: 9999;
      background: #f8f9fa;
      width: 100%;
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .spinner {
      width: 60px;
      height: 60px;
      border: 8px solid #007bff;
      border-top: 8px solid transparent;
      border-radius: 50%;
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      to { transform: rotate(360deg); }
    }

    /* Apparition douce */
    .fade-in {
      opacity: 0;
      transform: translateY(20px);
      animation: fadeInUp 0.6s ease forwards;
    }

    @keyframes fadeInUp {
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

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
      margin-top: 56px;
    }

    .card {
      transition: transform 0.4s, box-shadow 0.4s;
      border-radius: 20px;
    }

    .card:hover {
      transform: translateY(-8px);
      box-shadow: 0 15px 25px rgba(0,0,0,0.15);
    }

    .card-title {
      font-weight: bold;
      color: #2c3e50;
    }

    .card-text {
      color: #7f8c8d;
    }

    .btn-lg {
      padding: 0.75rem 1.5rem;
      border-radius: 50px;
      font-weight: 600;
      transition: all 0.3s ease;
    }

    .btn-lg:hover {
      transform: scale(1.05);
    }

    .offcanvas {
      border-right: none;
    }

    footer {
      background: #343a40;
      color: white;
      padding: 20px 0;
      text-align: center;
      margin-top: 50px;
    }
  </style>
</head>
<body>

<!-- Loader -->
<div id="loader">
  <div class="spinner"></div>
</div>

<!-- Barre de navigation -->
<nav class="navbar navbar-dark bg-dark fixed-top">
  <div class="container-fluid d-flex justify-content-between align-items-center">

    <!-- Gauche : burger + menu utilisateur -->
    <div class="d-flex align-items-center">
      <button class="btn btn-dark me-3" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarMenu">
        <i class="fas fa-bars"></i>
      </button>

      <!-- Menu utilisateur -->
      <div class="dropdown">
        <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
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
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/utilisateurs"><i class="fas fa-users me-2"></i>Utilisateurs</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/formateurs"><i class="fas fa-chalkboard-teacher me-2"></i>Formateurs</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/formations"><i class="fas fa-book-open me-2"></i>Formations</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/participants"><i class="fas fa-user-graduate me-2"></i>Participants</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/profils"><i class="fas fa-id-badge me-2"></i>Profils</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/roles"><i class="fas fa-user-tag me-2"></i>Rôles</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/structures"><i class="fas fa-building me-2"></i>Structures</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/domaines"><i class="fas fa-layer-group me-2"></i>Domaines</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/employeurs"><i class="fas fa-briefcase me-2"></i>Employeurs</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/stats"><i class="fas fa-chart-bar me-2"></i>Statistiques</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/planification"><i class="fas fa-calendar-alt me-2"></i>Planification</a></li>
    </ul>
  </div>
</div>


<!-- Section d'en-tête -->
<header class="dashboard-header fade-in">
  <div class="container">
    <h1 class="display-4 mb-4">Bienvenue sur la plateforme de gestion de formation</h1>
    <p class="lead mb-4">Optimisez la gestion de vos programmes de formation professionnelle</p>
    <a href="${pageContext.request.contextPath}/formations" class="btn btn-primary btn-lg">
      Voir les formations disponibles
    </a>
  </div>
</header>

<!-- Contenu principal -->
<div class="container my-5 fade-in">
  <div class="row g-4">


    <!-- Formateurs -->
    <div class="col-md-6">
      <div class="card shadow-lg border-0">
        <img src="https://images.unsplash.com/photo-1580894732444-8ecded7900cd?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
             class="card-img-top" style="height: 250px; object-fit: cover;">
        <div class="card-body text-center">
          <h3 class="card-title mb-3"><i class="fas fa-chalkboard-teacher me-2"></i>Gestion des Formateurs</h3>
          <p class="card-text">Découvrez notre équipe de formateurs experts et gérez leurs profils</p>
          <a href="${pageContext.request.contextPath}/formateurs" class="btn btn-primary btn-lg">Voir les formateurs</a>
        </div>
      </div>
    </div>

    <!-- Nouvelle carte Formations Planifiées -->
    <div class="col-md-4">
      <div class="card shadow-lg border-0">
        <img src="https://images.unsplash.com/photo-1542744095-291d1f67b221?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
             class="card-img-top"
             style="height: 180px; object-fit: cover;">
        <div class="card-body text-center">
          <h3 class="card-title mb-3">
            <i class="fas fa-calendar-check me-2"></i>Planning
          </h3>
          <p class="card-text">
            Consultez le calendrier des formations programmées
          </p>
          <a href="${pageContext.request.contextPath}/formationsPlanifiees"
             class="btn btn-info btn-lg">
            Voir le planning
          </a>
        </div>
      </div>
    </div>

    <!-- Participants -->
    <div class="col-md-6">
      <div class="card shadow-lg border-0">
        <img src="https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
             class="card-img-top"
             style="height: 180px; object-fit: cover;">
        <div class="card-body text-center">
          <h3 class="card-title mb-3"><i class="fas fa-user-graduate me-2"></i>Gestion des Participants</h3>
          <p class="card-text">Suivez et managez les inscriptions des participants aux formations</p>
          <a href="${pageContext.request.contextPath}/participants" class="btn btn-success btn-lg">Voir les participants</a>
        </div>
      </div>
    </div>
  </div>
</div>



<!-- Footer -->
<footer>
  <div class="container">
    <p>&copy; 2025 SkillForge - Tous droits réservés.</p>
  </div>
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Masquer le loader une fois la page chargée
  window.addEventListener("load", function() {
    const loader = document.getElementById("loader");
    loader.style.opacity = 0;
    loader.style.visibility = "hidden";
    loader.style.transition = "opacity 0.5s ease-out";
  });
</script>
</body>
</html>
