<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Gestion Profil</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2>${not empty profil ? 'Modifier' : 'Ajouter'} Profil</h2>
  <form action="profils" method="post">
    <input type="hidden" name="action" value="add">
    <c:if test="${not empty profil}">
      <input type="hidden" name="id" value="${profil.id}">
    </c:if>
    <div class="mb-3">
      <label class="form-label">Libellé</label>
      <input type="text" name="libelle" value="${profil.libelle}" class="form-control" required>
    </div>
    <button type="submit" class="btn btn-success">Enregistrer</button>
  </form>
</div>
</body>
</html>