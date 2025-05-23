<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
  <title>Dashboard Responsable - Statistiques</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <style>
    .stat-card {
      background: white;
      border-radius: 15px;
      padding: 20px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      transition: transform 0.3s;
    }
    .stat-card:hover {
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
      Tableau de Bord Responsable
    </a>
  </div>
</nav>

<div class="offcanvas offcanvas-start bg-dark text-white" tabindex="-1" id="sidebarMenu">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title">Menu Statistiques</h5>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
  </div>
  <div class="offcanvas-body">
    <ul class="nav flex-column">
      <li class="nav-item"><a class="nav-link text-white" href="#formationsStats"><i class="fas fa-chart-line"></i> Formations</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="#participantsStats"><i class="fas fa-users"></i> Participants</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="#budgetStats"><i class="fas fa-coins"></i> Budgets</a></li>
      <li class="nav-item mt-4">
        <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-sign-out-alt"></i> Déconnexion
        </a>
      </li>
    </ul>
  </div>
</div>

<div class="container" style="margin-top: 80px;">

  <!-- Section Statistiques Formations -->
  <section id="formationsStats" class="my-5">
    <h3 class="mb-4"><i class="fas fa-book-open me-2"></i>Statistiques des Formations</h3>
    <div class="row g-4">
      <div class="col-md-6">
        <div class="stat-card">
          <h5>Répartition par domaine</h5>
          <canvas id="domainChart" width="400" height="200"></canvas>
        </div>
      </div>
      <div class="col-md-6">
        <div class="stat-card">
          <h5>Évolution annuelle</h5>
          <canvas id="yearlyChart" width="400" height="200"></canvas>
        </div>
      </div>
    </div>
  </section>

  <!-- Section Statistiques Participants -->
  <section id="participantsStats" class="my-5">
    <h3 class="mb-4"><i class="fas fa-user-graduate me-2"></i>Statistiques des Participants</h3>
    <div class="row g-4">
      <div class="col-md-6">
        <div class="stat-card">
          <h5>Répartition par profil</h5>
          <canvas id="profileChart" width="400" height="200"></canvas>
        </div>
      </div>
      <div class="col-md-6">
        <div class="stat-card">
          <h5>Structure d'origine</h5>
          <canvas id="structureChart" width="400" height="200"></canvas>
        </div>
      </div>
    </div>
  </section>

</div>

<script>
  // Domain Chart Data
  const domainLabels = [<c:forEach items="${domainStats}" var="stat">"${stat[0]}",</c:forEach>];
  const domainData = [<c:forEach items="${domainStats}" var="stat">${stat[1]},</c:forEach>];

  // Yearly Chart Data
  const yearlyLabels = [<c:forEach items="${yearlyStats}" var="stat">"${stat[0]}",</c:forEach>];
  const yearlyData = [<c:forEach items="${yearlyStats}" var="stat">${stat[1]},</c:forEach>];

  // Profile Chart Data
  const profileLabels = [<c:forEach items="${profileStats}" var="stat">"${stat[0]}",</c:forEach>];
  const profileData = [<c:forEach items="${profileStats}" var="stat">${stat[1]},</c:forEach>];

  // Structure Chart Data
  const structureLabels = [<c:forEach items="${structureStats}" var="stat">"${stat[0]}",</c:forEach>];
  const structureData = [<c:forEach items="${structureStats}" var="stat">${stat[1]},</c:forEach>];

  // Initialize Charts
  new Chart(document.getElementById('domainChart'), {
    type: 'pie',
    data: {
      labels: domainLabels,
      datasets: [{
        data: domainData,
        backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b']
      }]
    }
  });

  new Chart(document.getElementById('yearlyChart'), {
    type: 'line',
    data: {
      labels: yearlyLabels,
      datasets: [{
        label: 'Nombre de formations',
        data: yearlyData,
        borderColor: '#4e73df',
        tension: 0.4,
        fill: false
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
          ticks: { stepSize: 1 }
        }
      }
    }
  });

  new Chart(document.getElementById('profileChart'), {
    type: 'doughnut',
    data: {
      labels: profileLabels,
      datasets: [{
        data: profileData,
        backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e']
      }]
    }
  });

  new Chart(document.getElementById('structureChart'), {
    type: 'bar',
    data: {
      labels: structureLabels,
      datasets: [{
        label: 'Nombre de participants',
        data: structureData,
        backgroundColor: '#4e73df'
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
          ticks: { stepSize: 1 }
        }
      }
    }
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>