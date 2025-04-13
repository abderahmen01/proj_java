<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Domaines</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="mt-5" style="text-align: center">
        <h2>Liste des Domaines</h2>
    </div>
    <div class="mt-5">
        <%-- Nouveau bouton Accueil dynamique --%>
        <c:choose>
            <c:when test="${sessionScope.role == 'administrateur'}">
                <a href="${pageContext.request.contextPath}/adminDashboard.jsp" class="btn btn-secondary mt-3">Accueil</a>
            </c:when>
            <c:when test="${sessionScope.role == 'responsable'}">
                <a href="${pageContext.request.contextPath}/homeDashboard.jsp" class="btn btn-secondary mt-3">Accueil</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/utilisateurDashboard.jsp" class="btn btn-secondary mt-3">Accueil</a>
            </c:otherwise>
        </c:choose>

        <a href="${pageContext.request.contextPath}/domaines?action=new" class="btn btn-primary">Ajouter un Domaine</a>
    </div>
    <div class="mt-3">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>Libellé</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="domaine" items="${domaines}">
                <tr>
                    <td>${domaine.id}</td>
                    <td>${domaine.libelle}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/domaines?action=edit&id=${domaine.id}"
                           class="btn btn-warning">Modifier</a>
                        <a href="${pageContext.request.contextPath}/domaines?action=delete&id=${domaine.id}"
                           class="btn btn-danger"
                           onclick="return confirm('Supprimer ce domaine ?')">Supprimer</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>