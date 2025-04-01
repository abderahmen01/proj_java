<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Gestion Domaine</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div>
        <h2><c:out value="${not empty domaine ? 'Modifier' : 'Ajouter'}"/> Domaine</h2>
    </div>
    <div class="m-3">
        <form action="${pageContext.request.contextPath}/domaines" method="post">
            <input type="hidden" name="action" value="add">
            <c:if test="${not empty domaine}">
                <input type="hidden" name="id" value="${domaine.id}">
            </c:if>
            <div class="mb-3">
                <label class="form-label">Libellé</label>
                <input type="text" name="libelle" value="${domaine.libelle}" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-success">Enregistrer</button>
        </form>
    </div>
</div>
</body>
</html>