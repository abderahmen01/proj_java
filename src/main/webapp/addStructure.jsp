<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Gestion Structure</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2>${not empty structure ? 'Modifier' : 'Ajouter'} Structure</h2>
  <form action="structures" method="post">
    <input type="hidden" name="action" value="add">
    <c:if test="${not empty structure}">
      <input type="hidden" name="id" value="${structure.id}">
    </c:if>
    <div class="mb-3">
      <label class="form-label">Libellé</label>
      <input type="text" name="libelle" value="${structure.libelle}" class="form-control" required>
    </div>
    <button type="submit" class="btn btn-success">Enregistrer</button>
  </form>
</div>
</body>
</html>