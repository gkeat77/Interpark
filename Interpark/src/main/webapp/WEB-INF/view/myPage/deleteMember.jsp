<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="ko">
<head>
<meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge" />
<title>회원 탈퇴</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/myPage/mypageHeader.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/register.js"></script>
<script type="text/javascript" src="${CTX_PATH}/js/login_pub.js"></script>
<script>
/* 일반 회원가입  완료*/
function deleteMember( form ) {
	 if(!confirm("정말 탈퇴하시겠습니까?")){
		return false;
	} 
	
	$.ajax({
		url : "/mypage/deleteMember.my",
		type : "POST",
		data : $("#"+form).serialize(),
		success : function(data) {
			alert("잘가.");
			location.href = "/mypage/loginOut.do";
		},
		error : function() {
			alert("[ 탈퇴 실패 ]");
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
							<h2>탈퇴</h2>
							<input type="hidden" name="action" id="action" value="">
							
							<div class="group-input">
								<label for="pass">아이디 </label>
								<input type="text" name="loginID" id="AregisterId"  value="${member.loginID}" readonly/>
							</div>
							<div class="group-input">
								<label for="pass">비밀번호 *</label>
								<input type="password"  name="password" id="AregisterPwd" required/>
							</div>
							<br>
							<a href="javascript:deleteMember('ARegisterForm')" class="site-btn register-btn" id="RegisterCom"  style="margin-left:219px;"><span>탈퇴하기</span></a>
							<input type="button" onclick="history.go(-1);" class="site-btn register-btn" value="취소"><span></span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	
	<c:if test="${result == false}">
		비밀번호가 맞지 않습니다.
	</c:if>

</body>
</html>