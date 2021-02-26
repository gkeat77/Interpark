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
<link rel="stylesheet" href="${CTX_PATH}/css/ticketing/booking.css" type="text/css">

${bookingStr }
<br>
${dbStr }
<br>
<div class="container">
	<input type="hidden" value='${bookingStr }' id="bookingStr">
	<input type="hidden" value='${dbStr }' id="dbStr">
	<div class="top">
		<div class="title">좌석선택</div>
		<div class="chose-date">
			<div>${db.prfnm }&nbsp;|&nbsp;${db.fcltynm }</div>
			<div class="date-time">
				<span>다른 관람일자 선택</span>
				<div>
					<input type="text" id="" name="" value="${booking.date }(${booking.day })">
					<select>
						<option value="${booking.times }">${booking.times }</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="main">
		<div class="seats" >
		
		</div>
		<div class="side">
			<div class="legend">
				<div class="title">좌석등급/잔여석</div>
				<c:forEach items="${db.seats }" var="item">
					<div><span>${item.name }</span><span>${item.price }</span></div>
				</c:forEach>
			</div>
			<div>
				<p>선택좌석</p>
				<div class="chosen"></div>
			</div>
			<Button>좌석선택완료</Button>
		</div>
	</div>

</div>

<script src="${CTX_PATH}/js/ticketing/booking.js"></script>
<jsp:include page="/WEB-INF/view/common/footer.jsp"/>