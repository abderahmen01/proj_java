<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Participants</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
  <h2 class="mt-5">Liste des Participants</h2>
  <%-- Nouveau bouton Accueil dynamique --%>
  <c:choose>
    <c:when test="${sessionScope.role == 'administrateur'}">
      <a href="${pageContext.request.contextPath}/adminDashboard.jsp" class="btn btn-secondary mt-3">Accueil</a>
    </c:when>
    <c:when test="${sessionScope.role == 'responsable'}">
      <a href="${pageContext.request.contextPath}/responsableDashboard.jsp" class="btn btn-secondary mt-3">Accueil</a>
    </c:when>
    <c:otherwise>
      <a href="${pageContext.request.contextPath}/utilisateurDashboard.jsp" class="btn btn-secondary mt-3">Accueil</a>
    </c:otherwise>
  </c:choose>

  <a href="${pageContext.request.contextPath}/participants?action=new" class="btn btn-primary mt-3">Nouveau Participant</a>
  <table class="table table-striped mt-3">
    <thead>
    <tr>
      <th>ID</th>
      <th>Nom</th>
      <th>Structure</th>
      <th>Profil</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="participant" items="${participants}">
      <tr>
        <td>${participant.id}</td>
        <td>${participant.nom} ${participant.prenom}</td>
        <td>${participant.structure.libelle}</td>
        <td>${participant.profil.libelle}</td>
        <td>
          <a href="${pageContext.request.contextPath}/participants?action=edit&id=${participant.id}" class="btn btn-warning">Modifier</a>
          <a href="${pageContext.request.contextPath}/participants?action=delete&id=${participant.id}" class="btn btn-danger"
             onclick="return confirm('Supprimer ce participant ?')">Supprimer</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>