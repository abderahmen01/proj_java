<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Formations</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
  <h2 class="mt-5">Liste des Formations</h2>
  <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary mt-3">Accueil</a>
  <a href="${pageContext.request.contextPath}/formations?action=new" class="btn btn-primary mt-3">Nouvelle Formation</a>
  <table class="table table-striped mt-3">
    <thead>
    <tr>
      <th>ID</th>
      <th>Titre</th>
      <th>Domaine</th>
      <th>Participants</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="formation" items="${formations}">
      <tr>
        <td>${formation.id}</td>
        <td>${formation.titre}</td>
        <td>${formation.domaine.libelle}</td>
        <td>
          <c:forEach var="participant" items="${formation.participants}">
            ${participant.nom} ${participant.prenom}<br>
          </c:forEach>
        </td>
        <td>
          <a href="${pageContext.request.contextPath}/formations?action=edit&id=${formation.id}" class="btn btn-warning">Modifier</a>
          <a href="${pageContext.request.contextPath}/formations?action=delete&id=${formation.id}" class="btn btn-danger"
             onclick="return confirm('Supprimer cette formation ?')">Supprimer</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>