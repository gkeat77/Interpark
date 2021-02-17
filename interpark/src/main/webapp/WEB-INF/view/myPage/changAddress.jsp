<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="ko">
<head>
<meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge" />
<title>주소록 추가</title>
<link rel="stylesheet" href="${CTX_PATH}/css/popUp.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/myPage/mypageHeader.jsp"></jsp:include>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/register.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/changAddress.js"></script>
<script type="text/javascript" src="${CTX_PATH}/js/login_pub.js"></script>
</head>
<body>
	<form action="" method="post">
		<div class="register-login-section spad">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 offset-lg-3">
						<div class="register-form"  id="layerA">
							<h2>주소록 추가</h2>
							<table class="table table-striped" style="width: 175%; margin-bottom: 1rem; color: #212529; margin-left: -151px;">
								<thead style="text-align: center;">
									<tr>
										<th style="width: 104px;">배송지</th>
										<th style="width: 283px;">주소</th>
										<th style="width: 104px;">연락처</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>
								</thead>
									<c:forEach items="${ad}" var="ad">
										<tr>
											<td><input type="hidden" name="a_id" value="${ad.a_ID }" id="a_id">
											${ad.a_TITLE }</td>
											<td>${ad.a_AD1} <br> ${ad.a_AD2} <br> ${ad.a_AD3}</td>
											<td>${ad.a_PHONE1} - ${ad.a_PHONE2} - ${ad.a_PHONE3}</td>
											<td style="padding-top: 32px;"><a href="/mypage/selectAddress.my?a_id=${ad.a_ID}" class="site-btn register-btn" id="RegisterCom"><span>수정</span></a></td>
											<td style="padding-top: 32px;"><a href="javascript:deleteAddress(${ad.a_ID})" class="site-btn register-btn" id=""><span>삭제</span></a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							
							<a class="or-login" href="javascript:showPopup(true)">추가하기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	
	<!-- 주소록 추가 팝업창 -->
	<div id="popup" class="hide">
	  <div class="content">
	  	<div class="group-input">
			<label for="pass">주소 이름 </label>
			<input type="text" name="A_TITLE" id="A_TITLE" />
		</div>
	    <div class="group-input">
			<label for="pass">우편번호 </label>
			<input type="text" name="user_post" id="Adetailaddr" />
			<input type="button" value="우편번호 찾기" onclick="execDaumPostcode('Aloginaddr','Aloginaddr1','Adetailaddr')" class="address_search" />
		</div>
		<div class="group-input">
			<label for="con-pass">주소</label>
			<input type="text"  name="addr" id="Aloginaddr" />
		</div>
		<div class="group-input">
			<label for="con-pass">상세주소</label>
			<input type="text"  name="addr_detail" id="Aloginaddr1" />
		</div>
		<div class="group-input">
			<label for="con-pass">연락처</label>
			<input type="text" class="phone" name="phone1" id="AregisterPhone1" style="width: 80px;"/> <b>&nbsp;&nbsp;-</b> 
			<input type="text" class="phone" name="phone2" id="AregisterPhone2" style="width: 100px;"/> <b>&nbsp;&nbsp;-</b> 
			<input type="text" class="phone" name="phone3" id="AregisterPhone3" style="width: 100px;"/> 
		</div>
		<div class="group-input">
			<label for="con-pass">수령인</label>
			<input type="text" class="phone" name="a_name" id="a_name" style="width: 80px;"/> <b>&nbsp;&nbsp;</b> 
		</div>
	    <button onclick="addAddress()">추가하기</button>
	    <button onclick="closePopup()">닫기</button>
	  </div>
	</div>
	
	
</body>
</html>