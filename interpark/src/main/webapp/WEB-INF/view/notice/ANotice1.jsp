<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="list" items="${list}" >
	<tr>
		<td>${list.title}</td>
	</tr>
</c:forEach>
