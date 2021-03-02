<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/view/common/header.jsp"/>
<jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"/>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet" href="${CTX_PATH}/css/ticketing/editseat.css" type="text/css">

<div class="container">
	<h3 style="text-align:center;">공연좌석 에디터</h3>
	<h5 class="prf-title" style="padding-left: 20px;">공연제목</h5>
	<input type="hidden" id="pcseguidance">
	<div class="edit-seat">
		<div class="seats">
			<div class="structure">
				<select>
					<option value="1층" selected>1층</option>
					<option value="2층">2층</option>
					<option value="3층">3층</option>
				</select>
				<input type="number" value="" name="rows" id="rows">행
				<input type="number" value="" name="cols" id="cols">열
			</div>
			<div class="contents">
				<!-- 좌석배치 -->
				
				
			</div>
		</div>
		<div class="edit">
			<div class="search-prfs">
				<input type="search" placeholder="공연제목을 입력하세요" name="search" id="search">
				<input type="button" value="검색" id="search-btn">
			</div>
			<div class="search-result">
			
			</div>
		</div>
	</div>
</div>

<script src="${CTX_PATH}/js/ticketing/editseat.js"></script>
<jsp:include page="/WEB-INF/view/common/footer.jsp"/>