<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Employeurs</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
  <h2 class="mt-5">Liste des Employeurs</h2>
  <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary mt-3">Accueil</a>
  <a href="${pageContext.request.contextPath}/employeurs?action=new" class="btn btn-primary mt-3">Nouvel Employeur</a>
  <table class="table table-striped mt-3">

    <thead>
    <tr>
      <th>ID</th>
      <th>Nom</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="employeur" items="${employeurs}">
      <tr>
        <td>${employeur.id}</td>
        <td>${employeur.nomEmployeur}</td>
        <td>
          <a href="${pageContext.request.contextPath}/employeurs?action=edit&id=${employeur.id}" class="btn btn-warning">Modifier</a>
          <a href="${pageContext.request.contextPath}/employeurs?action=delete&id=${employeur.id}" class="btn btn-danger"
             onclick="return confirm('Supprimer cet employeur ?')">Supprimer</a>

        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>