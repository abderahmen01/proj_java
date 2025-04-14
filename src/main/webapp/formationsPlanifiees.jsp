<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Formations Planifiées</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>


<div class="container mt-5">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="text-primary">
      <i class="fas fa-calendar-check me-2"></i>Formations Planifiées
    </h2>
    <a href="${pageContext.request.contextPath}/planification"
       class="btn btn-primary">
      <i class="fas fa-plus-circle me-2"></i>Nouvelle Planification
    </a>
    <!-- Bouton Accueil dynamique -->
    <div class="mb-4">
      <c:choose>
        <c:when test="${sessionScope.role == 'administrateur'}">
          <a href="${pageContext.request.contextPath}/adminDashboard.jsp"
             class="btn btn-outline-secondary">
            <i class="fas fa-home"></i> Accueil
          </a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/utilisateurDashboard.jsp"
             class="btn btn-outline-secondary">
            <i class="fas fa-home"></i> Accueil
          </a>
        </c:otherwise>
      </c:choose>
    </div>

  </div>

  <div class="card shadow">
    <div class="card-body">
      <table class="table table-hover">
        <thead class="thead-light">
        <tr>
          <th>Titre</th>
          <th>Dates</th>
          <th>Formateur</th>
          <th>Participants</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${formationsPlanifiees}" var="formation">
          <tr>
            <td>${formation.titre}</td>
            <td>
                                <span class="badge bg-info">
                                    ${formation.dateDebut} → ${formation.dateFin}
                                </span>
            </td>
            <td>${formation.formateur.nom}</td>
            <td>${formation.participants.size()}</td>
            <td>
              <c:if test="${not empty formation.dateDebut}">
                <a href="${pageContext.request.contextPath}/formations?action=deletePlanification&id=${formation.id}"
                   class="btn btn-sm btn-danger"
                   onclick="return confirm('Voulez-vous vraiment supprimer la planification ?');">
                  <i class="fas fa-trash"></i> Supprimer
                </a>
              </c:if>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>
</body>
</html>