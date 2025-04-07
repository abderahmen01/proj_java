<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Structures</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
  <h2 class="mt-5">Liste des Structures</h2>
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

  <a href="${pageContext.request.contextPath}/structures?action=new" class="btn btn-primary mt-3">Nouvelle Structure</a>
  <table class="table table-striped mt-3">
    <thead>
    <tr>
      <th>ID</th>
      <th>Libellé</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="structure" items="${structures}">
      <tr>
        <td>${structure.id}</td>
        <td>${structure.libelle}</td>
        <td>
          <a href="${pageContext.request.contextPath}/structures?action=edit&id=${structure.id}" class="btn btn-warning">Modifier</a>
          <a href="${pageContext.request.contextPath}/structures?action=delete&id=${structure.id}" class="btn btn-danger"
             onclick="return confirm('Supprimer cette structure ?')">Supprimer</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>