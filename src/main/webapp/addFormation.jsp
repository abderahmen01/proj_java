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

    <!-- Titre -->
    <div class="mb-3">
      <label class="form-label">Titre</label>
      <input type="text" name="titre" value="${formation.titre}" class="form-control" required>
    </div>

    <!-- Domaine -->
    <div class="mb-3">
      <label class="form-label">Domaine</label>
      <select name="domaineId" class="form-select">
        <c:forEach items="${domaines}" var="domaine">
          <option value="${domaine.id}" ${formation.domaine.id == domaine.id ? 'selected' : ''}>${domaine.libelle}</option>
        </c:forEach>
      </select>
    </div>

    <!-- Année -->
    <div class="mb-3">
      <label class="form-label">Année</label>
      <input type="number" name="annee" value="${formation.annee}" class="form-control" min="2024" max="2100" required>
    </div>

    <!-- Durée (jours) -->
    <div class="mb-3">
      <label class="form-label">Durée (jours)</label>
      <input type="number" name="duree" value="${formation.duree}" class="form-control" min="1" required>
    </div>

    <!-- Budget -->
    <div class="mb-3">
      <label class="form-label">Budget (€)</label>
      <input type="number" name="budget" value="${formation.budget}" class="form-control" step="any" required>
    </div>

    <!-- Participants -->
    <div class="mb-3">
      <label class="form-label">Participants</label>
      <div class="row">
        <c:forEach items="${participants}" var="participant">
          <div class="col-md-4">
            <div class="form-check">
              <input class="form-check-input"
                     type="checkbox"
                     name="participantId"
                     value="${participant.id}"
                ${formation.participants.contains(participant) ? 'checked' : ''}
                     id="participant_${participant.id}">
              <label class="form-check-label" for="participant_${participant.id}">
                  ${participant.nom} ${participant.prenom}
              </label>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>

    <button type="submit" class="btn btn-success">Enregistrer</button>
  </form>
</div>
</body>
</html>