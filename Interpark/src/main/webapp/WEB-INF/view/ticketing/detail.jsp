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
<link rel="stylesheet" href="${CTX_PATH}/css/ticketing/detail.css" type="text/css">

<div class="container">
	<input type="hidden" id="dbStr" value='${dbStr }'>
	<div class="title">
		<div><h4>${db.prfnm }</h4></div>
		<div><a href="/ticketing/intro.do">티켓팅 메인으로</a></div>
	</div>
	<div class="main">
		<div class="poster"><img src="${db.poster }" alt="${db.prfnm }" style="width:300px;"></div>
		<div class="feature">
			<div class="place">
				<div>장소</div>
				<div>${db.fcltynm }</div>
			</div>
			<div class="period">
				<div>공연기간</div>
				<div>${db.prfpdfrom }~${db.prfpdto }</div>
			</div>
			<div class="runtime">
				<div>공연시간</div>
				<div>${db.prfruntime }</div>
			</div>
			<div class="age">
				<div>관람연령</div>
				<div>${db.prfage }</div>
			</div>
			<div class="price">
				<div>가격</div>
				<div>${db.pcseguidance }</div>
			</div>
		</div>
		<div class="booking">
			<div class="calendar"></div>
			<div class="dtguidance">${db.dtguidance }</div>
			<button class="booking-btn">예매하기</button>
		</div>
	</div>
	<div class="tabs">
		<ul>
			<li class="info"><a>공연정보</a></li>
			<li class="addedInfo"><a>부가정보</a></li>
			<li class="review" style="background: #bbb; color: white;"><a>관람후기()</a></li>
			<li class="qna"><a>Q&A()</a></li>
		</ul>
	</div>
	<div class="tab-content">
		<div class="info" style="display:none;">info</div>
		<div class="addedInfo" style="display:none;">addedInfo</div>
		<div class="review" ></div>
		<div class="qna" style="display:none;"></div>
	</div>

</div>

<script src="${CTX_PATH}/js/ticketing/detail.js"></script>
<jsp:include page="/WEB-INF/view/common/footer.jsp"/>