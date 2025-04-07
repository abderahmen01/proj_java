<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Gestion Rôle</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>${not empty role ? 'Modifier' : 'Ajouter'} Rôle</h2>
    <form action="roles" method="post">
        <input type="hidden" name="action" value="add">
        <c:if test="${not empty role and role.getClass().simpleName == 'Role'}">
            <input type="hidden" name="id" value="${role.id}">
        </c:if>
        <div class="mb-3">
            <label class="form-label">Nom du rôle</label>
            <input type="text" name="nom"
                   value="${not empty role ? role.nom : ''}"
                   class="form-control"
                   required>
        </div>
        <button type="submit" class="btn btn-success">Enregistrer</button>
    </form>
</div>
</body>
</html>