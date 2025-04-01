<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Gestion Utilisateur</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2>${not empty utilisateur ? 'Modifier' : 'Ajouter'} Utilisateur</h2>
  <form action="utilisateurs" method="post">
    <input type="hidden" name="action" value="add">
    <c:if test="${not empty utilisateur}">
      <input type="hidden" name="id" value="${utilisateur.id}">
    </c:if>
    <div class="mb-3">
      <label class="form-label">Login</label>
      <input type="text" name="login" value="${utilisateur.login}" class="form-control" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Mot de passe</label>
      <input type="password" name="password" class="form-control" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Rôle</label>
      <select name="roleId" class="form-select">
        <c:forEach items="${roles}" var="role">
          <option value="${role.id}" ${utilisateur.role.id == role.id ? 'selected' : ''}>${role.nom}</option>
        </c:forEach>
      </select>
    </div>
    <button type="submit" class="btn btn-success">Enregistrer</button>
  </form>
</div>
</body>
</html>