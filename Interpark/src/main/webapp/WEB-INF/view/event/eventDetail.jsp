<!DOCTYPE html> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/view/common/header.jsp"/>

<head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.3.min.js"></script>
      
      <style type="text/css">
			.wrap {   position: relative;  width: 100%;  margin: 0 auto 0 auto;  text-align: center;}
			.img{   width: 960px;  aspect-ratio: auto 960 / 2240; height: 2240px;}
    
      </style>
 </head>
<%--  evBannerById: ${evBannerById } --%>
<div class="wrap">
	<c:forEach var="list" items="${evBannerById }" varStatus="status">
		<img class="img" src="${list.detail_banner}" />
	</c:forEach>
</div>
<div>test</div>
  <jsp:include page="/WEB-INF/view/common/footer.jsp"/>