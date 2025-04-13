<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Rôles</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
  <h2 class="mt-5">Liste des Rôles</h2>
  <%-- Nouveau bouton Accueil dynamique --%>
  <c:choose>
    <c:when test="${sessionScope.role == 'administrateur'}">
      <a href="${pageContext.request.contextPath}/adminDashboard.jsp" class="btn btn-secondary mt-3">Accueil</a>
    </c:when>
    <c:when test="${sessionScope.role == 'responsable'}">
      <a href="${pageContext.request.contextPath}/homeDashboard.jsp" class="btn btn-secondary mt-3">Accueil</a>
    </c:when>
    <c:otherwise>
      <a href="${pageContext.request.contextPath}/utilisateurDashboard.jsp" class="btn btn-secondary mt-3">Accueil</a>
    </c:otherwise>
  </c:choose>

  <a href="${pageContext.request.contextPath}/roles?action=new" class="btn btn-primary mt-3">Nouveau Rôle</a>
  <table class="table table-striped mt-3">
    <thead>
    <tr>
      <th>ID</th>
      <th>Nom</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="role" items="${roles}">
      <tr>
        <td>${role.id}</td>
        <td>${role.nom}</td>
        <td>
          <a href="${pageContext.request.contextPath}/roles?action=edit&id=${role.id}" class="btn btn-warning">Modifier</a>
          <a href="${pageContext.request.contextPath}/roles?action=delete&id=${role.id}" class="btn btn-danger"
             onclick="return confirm('Supprimer ce rôle ?')">Supprimer</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>