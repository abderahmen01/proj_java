<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Profils</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
  <h2 class="mt-5">Liste des Profils</h2>
  <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary mt-3">Accueil</a>
  <a href="${pageContext.request.contextPath}/profils?action=new" class="btn btn-primary mt-3">Nouveau Profil</a>
  <table class="table table-striped mt-3">
    <thead>
    <tr>
      <th>ID</th>
      <th>Libellé</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="profil" items="${profils}">
      <tr>
        <td>${profil.id}</td>
        <td>${profil.libelle}</td>
        <td>
          <a href="${pageContext.request.contextPath}/profils?action=edit&id=${profil.id}" class="btn btn-warning">Modifier</a>
          <a href="${pageContext.request.contextPath}/profils?action=delete&id=${profil.id}" class="btn btn-danger"
             onclick="return confirm('Supprimer ce profil ?')">Supprimer</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>