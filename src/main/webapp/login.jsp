<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Page de Connexion</title>
  <!-- Inclusion de Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Inclusion d'animate.css pour les animations -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
  <style>
    /* Fond de la page */
    body {
      background: #f0f2f5;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      margin: 0;
    }
    /* Carte de connexion */
    .login-card {
      width: 100%;
      max-width: 500px;
      background: #ffffff;
      border-radius: 10px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.25);
      overflow: hidden;
      padding: 2rem;
    }
    /* Titre et sous-titre */
    .login-title {
      text-align: center;
      font-size: 2rem;
      font-weight: bold;
      color: #5563DE;
      margin-bottom: 0.5rem;
    }
    .login-subtitle {
      text-align: center;
      font-size: 1.1rem;
      color: #333;
      margin-bottom: 1.5rem;
    }
    /* Champs de saisie et bouton agrandis */
    .form-control {
      font-size: 1.1rem;
      padding: 0.75rem;
    }
    .btn {
      font-size: 1.1rem;
      padding: 0.75rem;
    }
    /* Bouton avec effet de survol */
    .btn-primary:hover {
      transform: scale(1.05);
      transition: transform 0.2s;
    }
  </style>
</head>
<body>
<div class="login-card animate__animated animate__fadeInUp">
  <div class="login-title">Bienvenue</div>
  <div class="login-subtitle">Veuillez vous connecter pour continuer</div>
  <c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
  </c:if>
  <form action="${pageContext.request.contextPath}/login" method="post">
    <div class="mb-3">
      <label class="form-label">Login</label>
      <input type="text" name="login" class="form-control" placeholder="Votre identifiant" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Mot de passe</label>
      <input type="password" name="password" class="form-control" placeholder="Votre mot de passe" required>
    </div>
    <div class="d-grid">
      <button type="submit" class="btn btn-primary">Se connecter</button>
    </div>
  </form>
</div>
<!-- Inclusion du script Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
