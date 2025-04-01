<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Gestion Formation</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2>${not empty formation ? 'Modifier' : 'Ajouter'} Formation</h2>
  <form action="formations" method="post">
    <input type="hidden" name="action" value="add">
    <c:if test="${not empty formation}">
      <input type="hidden" name="id" value="${formation.id}">
    </c:if>
    <div class="mb-3">
      <label class="form-label">Titre</label>
      <input type="text" name="titre" value="${formation.titre}" class="form-control" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Domaine</label>
      <select name="domaineId" class="form-select">
        <c:forEach items="${domaines}" var="domaine">
          <option value="${domaine.id}" ${formation.domaine.id == domaine.id ? 'selected' : ''}>${domaine.libelle}</option>
        </c:forEach>
      </select>
    </div>
    <div class="mb-3">
      <label class="form-label">Participants</label>
      <select name="participantsIds" multiple class="form-select">
        <c:forEach items="${participants}" var="participant">
          <option value="${participant.id}"
            ${formation.participants.contains(participant) ? 'selected' : ''}>
              ${participant.nom} ${participant.prenom}
          </option>
        </c:forEach>
      </select>
    </div>
    <button type="submit" class="btn btn-success">Enregistrer</button>
  </form>
</div>
</body>
</html>