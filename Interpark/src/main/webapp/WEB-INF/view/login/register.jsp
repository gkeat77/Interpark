<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="ko">
<head>
<meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge" />
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/register.js"></script>
<script type="text/javascript" src="${CTX_PATH}/js/login_pub.js"></script>
<script>
</script>
</head>
<body>
	<form id="ARegisterForm" action="" method="post">
		<div class="register-login-section spad">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 offset-lg-3">
						<div class="register-form"  id="layerA">
							<h2>회원 가입</h2>
							<input type="hidden" name="action" id="action" value="">
							
							<div class="group-input">
								<label for="username">이름 *</label>
								<input type="text"  name="name" id="AregisterName" />
							</div>
							<div class="group-input">
								<label for="pass">아이디 *</label>
								<input type="text" name="loginID" id="AregisterId" />
								<span id="id_check" style="text-color:led;"></span>
							</div>
							<div class="group-input">
								<label for="pass">비밀번호 *</label>
								<input type="password"  name="password" id="AregisterPwd" />
							</div>
							<div class="group-input">
								<label for="pass">비밀번호 확인 *</label>
								<input type="text" name="password1" id="AregisterPwdOk">
							</div>
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
								<label for="con-pass">연락처*</label>
								<input type="text" class="phone" name="phone1" id="AregisterPhone1" style="width: 80px;"/> <b>&nbsp;&nbsp;-</b> 
								<input type="text" class="phone" name="phone2" id="AregisterPhone2" style="width: 100px;"/> <b>&nbsp;&nbsp;-</b> 
								<input type="text" class="phone" name="phone3" id="AregisterPhone3" style="width: 100px;"/> 
							</div>
							<div class="group-input">
								<label for="con-pass">생년 월일*</label>
								<script language="javascript"> Today('null','null','null'); </script>
							</div>
							<div class="group-input">
								<label for="con-pass">이메일*</label>
								<input type="text" class="mail" name="mail" id="AregisterEmail1" reanonly value="${mail}" />
								<span id="email_check" style="text-color:led;"></span>
							</div>
							<div class="group-input">
								<label for="con-pass">환불받을 은행이름*</label>
								<input type="text" class="bkname" name="bkname" id="AregisterBank" />
							</div>
							<div class="group-input">
								<label for="con-pass">환불계좌*</label>
								<input type="text" class="account" name="account" id="AregisterAccount" />
							</div>
							<br>
							<a href="javascript:IDCheck('ARegisterForm');" class="site-btn register-btn" id="RegisterCom" style="margin-left:219px;"><span>가입</span></a>
							<div class="switch-login">
							<a href="/login/login.me" class="or-login">Or Login</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>

</body>
</html>