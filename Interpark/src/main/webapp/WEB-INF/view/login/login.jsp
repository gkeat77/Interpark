<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="ko">
<head>
<meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Login</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/login.js"></script>
<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript" src="${CTX_PATH}/js/login_pub.js"></script>
<script>
$(document).ready(function() {
	$("#confirm").hide();
	$("#findPwdForm").hide();
	$("#loginEmail").hide();
	$("#loginPwd").hide();
	
	// 쿠키값을 가져온다.
	var cookie_user_id = getCookie('userId');
	if (cookie_user_id != "") {
		$("#userId").val(cookie_user_id);
		$("#cb_saveId").attr("checked", true);
	}
});

/* 로그인 */
function fLoginProc(data) {
	 if ($("#cb_saveId").is(":checked")) { // 저장 체크시
		saveCookie('userId', $("#userId").val(), 7);
	} 
	// vaildation 체크
	 if (!fValidateLogin()) {
		return;
	} 
	var resultCallback = function(data) {
		fLoginProcResult(data);
	};
	callAjax("loginProc.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
}

/* 로그인 결과 */
function fLoginProcResult(data) {
	if (data.result == "SUCCESS") {
		console.log("tjdrhd?")
		location.href = "${CTX_PATH}/index.do";
	} else {
		$("<div style='text-align:center;'>" + data.resultMsg + "</div>")
				.dialog({
					modal : true,
					resizable : false,
					buttons : [ {
						text : "확인",
						click : function() {
							$(this).dialog("close");
							$("#userId").val("");
							$("#userPwd").val("");
							$("#userId").focus();
						}
					} ]
				});
		$(".ui-dialog-titlebar").hide();
	}
}

</script>
</head>

<body>
    <!-- login Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <div class="login-form">
                        <h2>Login</h2>
                        <form action="" id="myForm" method="post">
                            <div class="group-input">
                                <label for="username">ID *</label>
                                <input type="text" id="userId" name="loginID"  >
                            </div>
                            <div class="group-input">
                                <label for="pass">Password *</label>
                                <input type="text" id="userPwd" name="password" onfocus="this.placeholder=''; return true"  >
                            </div>
                            <div class="group-input gi-check">
                                <div class="gi-more">
	                                <span > <input type="checkbox" id="cb_saveId" style="height: 17px; margin-left: -266px; margin-right: -268px;" > ID 저장</span>
                                       
                                        <!-- <input type="checkbox" id="cb_saveId" name="" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}"> -->
                                    <a href="javascript:findIdPwd();" class="forget-pass">Forget your ID&Password</a>
                                </div>
                            </div>
                            <input type="button" onclick="fLoginProc();" class="site-btn login-btn" id="btn_login" value="Sign In">
                            <!-- //<a href="javascript:fLoginProc();"  id="btn_login">Sign In</a> -->
                        </form>
                        <div class="switch-login">
                            <a href="reg.do" class="or-login">Or Create An Account</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- login Section End -->
    
    <!-- 아이디 비밀번호 찾기 모달 -->
	<form id="sendForm" action="" method="post">
		<input type="hidden" name="authNumId" id="authNumId" value="" /> 
		<input type="hidden" name="authNumPwd" id="authNumPwd" value="" />
		<input type="hidden" name="ckIdcheck" id="ckIdcheck" value=""/>
		<div id="layer2" class="layerPop layerType2" style="width: 480px; height: 300px;">
			<dl>
				<dt>
					<strong>아이디/비밀번호 찾기</strong>
				</dt>
				<dd>
					<div>
						<a href="javascript:fSelectId();"  class="site-btn login-btn" id="findId" style="margin-left: 23px;"><span>아이디 찾기</span></a> 
						<a href="javascript:fSelectPwd();" class="site-btn login-btn" id="findPwd" style="margin-left: 27px;"><span>비밀번호 찾기</span></a>
					</div>
					<div>
						<br><span>* 등록되어 있는 이메일로 전송 됩니다.</span>
					</div>
				</dd>
				</dl>
				<div class="login-form">
					<!-- 아이디/비밀번호 찾기 폼 -->
					<div class="group-input" id="registerEmailId">
                       <input type="text" id="emailText" data-code="I" placeholder="가입하신 이메일을 입력하세요"  style="height: 30px; width: 288px; margin-left: 9px;" >
                       <a href="javascript:SendEmail();" class="site-btn login-btn" id="findIdSubmit"><span>아이디 전송</span></a>
                    </div>
                    <div class="group-input" id="findPwdForm">
                       <input type="text" id="email_pass_Text" placeholder="가입하신 아이디를 입력하세요" style="height: 30px; width: 238px; margin-left: 13px;" />
						<a href="javascript:pass_SendEmail();" class="site-btn login-btn" id=""><span>임시비밀번호 전송</span></a>
                    </div>
				</div>
			
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>

</body>
<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
</html>