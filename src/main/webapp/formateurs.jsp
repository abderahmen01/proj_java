<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Formateurs</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
  <h2 class="mt-5">Liste des Formateurs</h2>
  <%-- Nouveau bouton Accueil dynamique --%>
  <c:choose>
    <c:when test="${sessionScope.role == 'administrateur'}">
      <a href="${pageContext.request.contextPath}/adminDashboard.jsp" class="btn btn-secondary mt-3">Accueil</a>
    </c:when>
    <c:when test="${sessionScope.role == 'responsable'}">
      <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary mt-3">Accueil</a>
    </c:when>
    <c:otherwise>
      <a href="${pageContext.request.contextPath}/utilisateurDashboard.jsp" class="btn btn-secondary mt-3">Accueil</a>
    </c:otherwise>
  </c:choose>

  <a href="${pageContext.request.contextPath}/formateurs?action=new" class="btn btn-primary mt-3">Nouveau Formateur</a>
  <table class="table table-striped mt-3">
    <thead>
    <tr>
      <th>ID</th>
      <th>Nom</th>
      <th>Type</th>
      <th>Employeur</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="formateur" items="${formateurs}">
      <tr>
        <td>${formateur.id}</td>
        <td>${formateur.nom} ${formateur.prenom}</td>
        <td>${formateur.type}</td>
        <td>${formateur.employeur.nomEmployeur}</td>
        <td>
          <a href="${pageContext.request.contextPath}/formateurs?action=edit&id=${formateur.id}" class="btn btn-warning">Modifier</a>
          <a href="${pageContext.request.contextPath}/formateurs?action=delete&id=${formateur.id}" class="btn btn-danger"
             onclick="return confirm('Supprimer ce formateur ?')">Supprimer</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>