<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/view/common/header.jsp"/>
<jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"/>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
<link rel="stylesheet" href="${CTX_PATH}/css/ticketing/intro.css" type="text/css">

<div class="container">
	<input type="hidden" id="boxofsStr" name="boxofsStr" value='${boxofsStr }'>
	<h1>티켓팅</h1>
	<div class="main row">
		<div class="menu col-3">
			<ul class="cate">
				<li class="clickable"><a href="/ticketing/list.do?cpage=1&rows=50&shcate=AAAA">연극</a>
					<!-- <ul class="sub-cate">
						<li class="clickable">
						
						전국</a>
						</li>
						<li class="clickable"><a>서울</a></li>
						<li class="clickable"><a>지방</a></li>
						<li class="clickable"><a>랭킹순</a></li>
					</ul> -->
				</li>
				<li class="clickable"><a href="/ticketing/list.do?cpage=1&rows=50&shcate=AAAB">뮤지컬</a></li>
				<li class="clickable"><a href="/ticketing/list.do?cpage=1&rows=50&shcate=CCCA">클래식</a></li>
				<li class="clickable"><a href="/ticketing/list.do?cpage=1&rows=50&shcate=CCCB">오페라</a></li>
				<li class="clickable"><a href="/ticketing/list.do?cpage=1&rows=50&shcate=BBBA">무용</a></li>
			</ul>
		</div>
		<div class="content col-9 row">
			<div class="main-poster col-5">
				
					<img src="" alt="">
			
			</div>
			<div class="sub-poster col-7">
			
			</div>
		</div>
	</div>
	<div class="ranking row">
		<div class="top">
			<div class="title">RANKING</div>
			<div class="menu-div">
				<ul class="ranking-menu">
					<li class="active"><a>연극</a></li>
					<li><a>뮤지컬</a></li>
					<li><a>클래식</a></li>
					<li><a>오페라</a></li>
					<li><a>무용</a></li>
				</ul>
			</div>
		</div>
		<div class="bottom">
			<div class="more"><a>전체보기</a></div>
			<div class="wrapper">
				<div class="content">
				
				</div>
				<span class="next" style="font-size: 3em; color: Tomato;"> 
					<i class="fas fa-angle-right"></i>
				</span>
				<span class="prev" style="font-size: 3em; color: Tomato;"> 
					<i class="fas fa-angle-left"></i>
				</span>
			</div>
		</div>
		
	</div>
</div>

<script src="${CTX_PATH}/js/ticketing/intro.js"></script>
<jsp:include page="/WEB-INF/view/common/footer.jsp"/>