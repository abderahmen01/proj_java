<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Gestion Participant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div>
        <h2><c:out value="${not empty participant ? 'Modifier' : 'Ajouter'}"/> Participant</h2>
    </div>
    <div class="m-3">
        <form action="${pageContext.request.contextPath}/participants" method="post">
            <input type="hidden" name="action" value="add">
            <c:if test="${not empty participant}">
                <input type="hidden" name="id" value="${participant.id}">
            </c:if>
            <div class="mb-3">
                <label class="form-label">Nom</label>
                <input type="text" name="nom" value="${participant.nom}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Prénom</label>
                <input type="text" name="prenom" value="${participant.prenom}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" value="${participant.email}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Téléphone</label>
                <input type="tel" name="tel" value="${participant.tel}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Structure</label>
                <select name="structureId" class="form-select">
                    <c:forEach items="${structures}" var="structure">
                        <option value="${structure.id}" ${participant.structure.id == structure.id ? 'selected' : ''}>
                                ${structure.libelle}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Profil</label>
                <select name="profilId" class="form-select">
                    <c:forEach items="${profils}" var="profil">
                        <option value="${profil.id}" ${participant.profil.id == profil.id ? 'selected' : ''}>
                                ${profil.libelle}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-success">Enregistrer</button>
        </form>
    </div>
</div>
</body>
</html>