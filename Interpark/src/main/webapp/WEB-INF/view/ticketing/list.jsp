<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/view/common/header.jsp"/>
<jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"/>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
<link rel="stylesheet" href="${CTX_PATH}/css/ticketing/list.css" type="text/css">


<div class="container">
	<input type="hidden" value='${dbsStr }' name="dbs" id="dbs">
	<div class="list-wrap">
		<div class="menu">
			<div class="menu-title">
				<h4>${category }</h4>
			</div>
		
			<!-- <ul class="sub-cate">
				<li class="clickable">
					<a href="/ticketing/list.do?cpage=1&rows=50&shcate=AAAA">전국</a>
				</li>
				<li class="clickable"><a>서울</a></li>
				<li class="clickable"><a>지방</a></li>
			</ul> -->	
		</div>
		<div class="main">
			<div class="title">
				<h3>${category }</h3>
			</div>
			<div class="sort">
				<ul>
					<li class="rank" ><a>금일랭킹순</a></li>
					<li class="name"><a>공연이름순</a></li>
					<li class="enddate" style="background: #eee;"><a>공연종료일임박순</a></li>
				</ul>
			</div>
			<div class="list">
				<div class="title">
					<div class="prf-name">공연명</div>
					<div class="prf-place">공연장소</div>
					<div class="prf-period">공연기간</div>
				</div>
				<div class="content">
				
				</div>
			</div>
		</div>
	</div>
</div>

<script src="${CTX_PATH}/js/ticketing/list.js"></script>
<jsp:include page="/WEB-INF/view/common/footer.jsp"/>