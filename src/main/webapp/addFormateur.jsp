<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Gestion Formateur</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2>${not empty formateur ? 'Modifier' : 'Ajouter'} Formateur</h2>
  <form action="formateurs" method="post">
    <input type="hidden" name="action" value="add">
    <c:if test="${not empty formateur}">
      <input type="hidden" name="id" value="${formateur.id}">
    </c:if>
    <div class="mb-3">
      <label class="form-label">Nom</label>
      <input type="text" name="nom" value="${formateur.nom}" class="form-control" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Prénom</label>
      <input type="text" name="prenom" value="${formateur.prenom}" class="form-control" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Email</label>
      <input type="email" name="email" value="${formateur.email}" class="form-control" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Téléphone</label>
      <input type="tel" name="tel" value="${formateur.tel}" class="form-control" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Type</label>
      <select name="type" class="form-select">
        <option value="interne" ${formateur.type == 'interne' ? 'selected' : ''}>Interne</option>
        <option value="externe" ${formateur.type == 'externe' ? 'selected' : ''}>Externe</option>
      </select>
    </div>
    <div class="mb-3">
      <label class="form-label">Employeur</label>
      <select name="employeurId" class="form-select">
        <c:forEach items="${employeurs}" var="employeur">
          <option value="${employeur.id}" ${formateur.employeur.id == employeur.id ? 'selected' : ''}>
              ${employeur.nomEmployeur}
          </option>
        </c:forEach>
      </select>
    </div>
    <button type="submit" class="btn btn-success">Enregistrer</button>
  </form>
</div>
</body>
</html>