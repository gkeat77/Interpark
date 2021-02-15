<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="ko">
<head>
<meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge" />
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/myPage/mypageHeader.jsp"></jsp:include>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/register.js"></script>
<script type="text/javascript" src="${CTX_PATH}/js/login_pub.js"></script>
<script>
/* 일반 회원가입  완료*/
function memberInfoChange( form ) {
	$.ajax({
		url : "/mypage/memberInfo.my",
		type : "POST",
		data : $("#"+form).serialize(),
		success : function(data) {
			alert("회원정보가 수정되었습니다.");
			location.href = "loginOut.me";
		},
		error : function() {
			alert("[ 회원 정보 수정 실패 ]");
		}
	});
}
</script>
</head>
<body>
	<form action="" method="post" id="ARegisterForm">
		<div class="register-login-section spad">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 offset-lg-3">
						<div class="register-form"  id="layerA">
							<h2>회원 정보 수정</h2>
							<input type="hidden" name="action" id="action" value="">
							
							<div class="group-input">
								<label for="username">이름 </label>
								<input type="text"  name="name" id="AregisterName" value="${member.name}" readonly />
							</div>
							<div class="group-input">
								<label for="pass">아이디 </label>
								<input type="text" name="loginID" id="AregisterId" value="${member.loginID}" readonly/>
							</div>
							<div class="group-input">
								<label for="pass">비밀번호 *</label>
								<input type="password"  name="password" id="AregisterPwd" required/>
							</div>
							<div class="group-input">
								<label for="pass">비밀번호 확인 *</label>
								<input type="text" name="password1" id="AregisterPwdOk" required>
							</div>
							<div class="group-input">
								<label for="con-pass">연락처*</label>
								<input type="text" class="phone" name="phone1" id="AregisterPhone1" style="width: 80px;" value="${member.phone1}"/> <b>&nbsp;&nbsp;-</b> 
								<input type="text" class="phone" name="phone2" id="AregisterPhone2" style="width: 100px;" value="${member.phone2}"/> <b>&nbsp;&nbsp;-</b> 
								<input type="text" class="phone" name="phone3" id="AregisterPhone3" style="width: 100px;" value="${member.phone3}"/> 
							</div>
							<div class="group-input">
								<label for="con-pass">이메일*</label>
								<input type="text" class="mail" name="mail" id="AregisterEmail1" value="${member.mail}" />
							</div>
							<div class="group-input">
								<label for="con-pass">환불받을 은행이름*</label>
								<input type="text" class="bkname" name="bkname" id="AregisterBank" value="${member.bkname}"/>
							</div>
							<div class="group-input">
								<label for="con-pass">환불계좌*</label>
								<input type="text" class="account" name="account" id="AregisterAccount" value="${member.account}"/>
							</div>
							<br>
							<a href="javascript:memberInfoChange('ARegisterForm')" class="site-btn register-btn" id="RegisterCom"  style="margin-left:219px;"><span>수정</span></a>
							<input type="button" onclick="history.go(-1);" class="site-btn register-btn" value="취소"><span></span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>

</body>
</html>