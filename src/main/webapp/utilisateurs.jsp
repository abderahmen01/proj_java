<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Utilisateurs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h2 class="mt-5">Liste des Utilisateurs</h2>
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

    <a href="${pageContext.request.contextPath}/utilisateurs?action=new" class="btn btn-primary mt-3">Nouvel Utilisateur</a>
    <table class="table table-striped mt-3">
        <thead>
        <tr>
            <th>ID</th>
            <th>Login</th>
            <th>Rôle</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="utilisateur" items="${utilisateurs}">
            <tr>
                <td>${utilisateur.id}</td>
                <td>${utilisateur.login}</td>
                <td>${utilisateur.role.nom}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/utilisateurs?action=edit&id=${utilisateur.id}" class="btn btn-warning">Modifier</a>
                    <a href="${pageContext.request.contextPath}/utilisateurs?action=delete&id=${utilisateur.id}" class="btn btn-danger"
                       onclick="return confirm('Supprimer cet utilisateur ?')">Supprimer</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>