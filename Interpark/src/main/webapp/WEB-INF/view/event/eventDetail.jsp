<!DOCTYPE html> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/view/common/header.jsp"/>
<%-- e_id: ${e_id } --%>

<div class=".wrap">
	<c:forEach var="list" items="${evBannerById }" varStatus="status">
		<img src={list.detail_banner} alt="" />
	</c:forEach>
</div>
 