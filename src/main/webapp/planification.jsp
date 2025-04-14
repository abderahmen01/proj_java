<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Planification des Formations</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-5">

  <div class="card border-primary mb-4">
    <div class="card-header bg-primary text-white">
      <h3 class="mb-0"><i class="fas fa-calendar-alt me-2"></i>Planification de Formation</h3>
    </div>
    <div class="card-body">
      <div class="card-body">
        <div class="alert alert-info">
          <i class="fas fa-info-circle me-2"></i>
          Sélectionnez une formation et complétez les détails
        </div>
  <!-- Formulaire de planification -->
  <form action="${pageContext.request.contextPath}/planification" method="post">
    <!-- Sélection de la formation -->
    <div class="mb-4">
      <label class="form-label">Formation à planifier :</label>
      <select name="formationId" class="form-select select2-formation" required>
        <option value="">Choisir une formation...</option>
        <c:forEach items="${formationsNonPlanifiees}" var="formation">
          <option value="${formation.id}">
              ${formation.titre} (${formation.domaine.libelle} - ${formation.annee})
          </option>
        </c:forEach>
      </select>
    </div>

    <!-- Sélection du formateur -->
    <div class="mb-4">
      <label class="form-label">Formateur :</label>
      <select name="formateurId" class="form-select select2-formateur" required>
        <option value="">Choisir un formateur...</option>
        <c:forEach items="${formateurs}" var="formateur">
          <option value="${formateur.id}">
              ${formateur.nom} ${formateur.prenom} (${formateur.type})
          </option>
        </c:forEach>
      </select>
    </div>

    <!-- Dates et lieu -->
    <div class="row mb-4">
      <div class="col-md-4">
        <label class="form-label">Date de début :</label>
        <input type="date" name="dateDebut" class="form-control" required>
      </div>
      <div class="col-md-4">
        <label class="form-label">Date de fin :</label>
        <input type="date" name="dateFin" class="form-control" required>
      </div>
      <div class="col-md-4">
        <label class="form-label">Lieu :</label>
        <input type="text" name="lieu" class="form-control" required>
      </div>
    </div>

    <!-- Validation -->
    <div class="d-grid gap-2">
      <button type="submit" class="btn btn-primary btn-lg">
        <i class="fas fa-calendar-check me-2"></i>Planifier
      </button>
    </div>
  </form>
      </div>
    </div>
</div>
  <c:if test="${not empty success}">
    <div class="alert alert-success mt-3">
      <i class="fas fa-check-circle me-2"></i>${success}
    </div>
  </c:if>
</div>
<!-- Scripts pour l'interface dynamique -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
  $(document).ready(function() {
    $('.select2-formation').select2({
      placeholder: "Rechercher une formation...",
      allowClear: true
    });

    $('.select2-formateur').select2({
      placeholder: "Rechercher un formateur...",
      allowClear: true
    });

    // Validation des dates
    $('form').submit(function(e) {
      const debut = new Date($('[name="dateDebut"]').val());
      const fin = new Date($('[name="dateFin"]').val());

      if(debut >= fin) {
        alert('La date de fin doit être postérieure à la date de début !');
        e.preventDefault();
      }
    });
  });
</script>
</body>
</html>