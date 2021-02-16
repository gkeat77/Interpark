<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="ko">
<head>
<meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge" />
<title>주소록 수정</title>
<link rel="stylesheet" href="${CTX_PATH}/css/popUp.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/myPage/mypageHeader.jsp"></jsp:include>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/register.js"></script>
<script type="text/javascript" src="${CTX_PATH}/js/login_pub.js"></script>
</head>
<script>
function editAddress(){
	$.ajax({
		url : "/mypage/editAddress.my",
		type : "POST",
		data : {A_TITLE : $("#A_TITLE").val(),
			A_AD1 : $("#Adetailaddr").val(),
			A_AD2 : $("#Aloginaddr").val(),
			A_AD3 : $("#Aloginaddr1").val(),
			A_PHONE1 : $("#AregisterPhone1").val(),
			A_PHONE2 : $("#AregisterPhone2").val(),
			A_PHONE3 : $("#AregisterPhone3").val(),
			A_NAME : $("#a_name").val(),
			A_ID : $("#a_id").val()
		},
		success : function(data) {
			alert("주소록이 수정되었습니다.");
			location.href = "/mypage/addList.my";
		},
		error : function() {
			alert("[ 주소록 수정 실패 ]");
		}
	  });
	  
}
</script>
<body>
	<form action="" method="post">
		<div class="register-login-section spad">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 offset-lg-3">
						<div class="register-form"  id="layerA">
							<input type="hidden" name="A_ID" id="a_id" value="${ad.a_ID }" >
							<div class="group-input">
								<label for="pass">주소 이름 </label>
								<input type="text" name="A_TITLE" id="A_TITLE" value="${ad.a_TITLE }"/>
							</div>
						    <div class="group-input">
								<label for="pass">우편번호 </label>
								<input type="text" name="user_post" id="Adetailaddr" value="${ad.a_AD1 }"/>
								<input type="button" value="우편번호 찾기" onclick="execDaumPostcode('Aloginaddr','Aloginaddr1','Adetailaddr')" class="address_search" />
							</div>
							<div class="group-input">
								<label for="con-pass">주소</label>
								<input type="text"  name="addr" id="Aloginaddr" value="${ad.a_AD2 }"/>
							</div>
							<div class="group-input">
								<label for="con-pass">상세주소</label>
								<input type="text"  name="addr_detail" id="Aloginaddr1" value="${ad.a_AD3 }"/>
							</div>
							<div class="group-input">
								<label for="con-pass">연락처</label>
								<input type="text" class="phone" name="phone1" id="AregisterPhone1" style="width: 80px;" value="${ad.a_PHONE1 }"/> <b>&nbsp;&nbsp;-</b> 
								<input type="text" class="phone" name="phone2" id="AregisterPhone2" style="width: 100px;" value="${ad.a_PHONE2 }"/> <b>&nbsp;&nbsp;-</b> 
								<input type="text" class="phone" name="phone3" id="AregisterPhone3" style="width: 100px;" value="${ad.a_PHONE3 }"/> 
							</div>
							<div class="group-input">
								<label for="con-pass">수령인</label>
								<input type="text" class="phone" name="a_name" id="a_name" style="width: 80px;" value="${ad.a_NAME}"/> <b>&nbsp;&nbsp;</b> 
							</div>
						    <button onclick="editAddress()">수정하기</button>
						    <button onclick="closePopup()">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>

</body>
</html>