<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // Forcer le navigateur à ne pas cacher la page
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

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
        #annualChart {
            min-height: 400px;
            background: white;
            border-radius: 8px;
            padding: 1rem;
        }
        .chart-container {
            margin: 2rem 0;
            border: 1px solid #dee2e6;
            border-radius: 12px;
            overflow: hidden;
        }
        .stat-card {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
            margin: 2rem auto;
            max-width: 800px;
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
            Tableau de Bord
        </a>
        <div class="dropdown">
            <a href="#" class="text-white dropdown-toggle" data-bs-toggle="dropdown">
                <i class="fas fa-user-circle fa-2x me-2"></i>
                <span>Bonjour, <strong>${sessionScope.login}</strong></span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Déconnexion</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="offcanvas offcanvas-start bg-dark text-white" id="sidebarMenu">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title">Menu</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/stats">
                    <i class="fas fa-chart-pie me-2"></i> Statistiques
                </a>
            </li>
        </ul>
    </div>
</div>

<div class="container" style="margin-top: 100px;">
    <div class="stat-card">
        <h4><i class="fas fa-chart-line me-2"></i>Statistiques Annuelles</h4>
        <div class="chart-container">
            <canvas id="annualChart"></canvas>
        </div>
    </div>
</div>

<!-- 🔽 Injecter le JSON dans une balise sécurisée -->
<script id="jsonData" type="application/json">
    ${formationsParAnneeJSON}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        try {
            const rawData = JSON.parse(document.getElementById("jsonData").textContent);
            console.log("✅ Données reçues :", rawData);

            const years = Object.keys(rawData)
                .map(year => parseInt(year))
                .sort((a, b) => a - b);
            const counts = years.map(year => rawData[year]);

            new Chart(document.getElementById('annualChart'), {
                type: 'line',
                data: {
                    labels: years.map(y => y.toString()),
                    datasets: [{
                        label: 'Nombre de formations',
                        data: counts,
                        borderColor: '#4e73df',
                        backgroundColor: 'rgba(78, 115, 223, 0.1)',
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    plugins: { legend: { display: false } },
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: { display: true, text: 'Nombre de formations' }
                        },
                        x: {
                            title: { display: true, text: 'Années' }
                        }
                    }
                }
            });

        } catch (error) {
            console.error('❌ Erreur JSON ou graphique :', error);
            document.getElementById('annualChart').outerHTML = `
                <div class="alert alert-danger text-center m-4">
                    Aucune donnée disponible ou erreur d'affichage.
                </div>
            `;
        }
    });
</script>

</body>
</html>
