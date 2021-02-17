<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="ko">
<head>
<meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Login</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<script type="text/javascript" charset="utf-8" src="/js/login.js"></script>
<script type="text/javascript" src="/js/login_pub.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
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
                                <input type="password" id="userPwd" name="password" onfocus="this.placeholder=''; return true"  >
                            </div>
                            <div class="group-input gi-check">
                                <div class="gi-more">
	                                <span > <input type="checkbox" id="cb_saveId" style="height: 17px; margin-left: -266px; margin-right: -268px;" > ID 저장</span>
                                       
                                        <!-- <input type="checkbox" id="cb_saveId" name="" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}"> -->
                                    <a href="/login/ff.me" id="forget" class="forget-pass">Forget your ID&Password</a>
                                </div>
                            </div>
                            <input type="button" onclick="fLoginProc();" class="site-btn login-btn" id="btn_login" value="Sign In">
                        </form>
                        <div class="switch-login">
                            <a href="/register/chre.re" class="or-login">Or Create An Account</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- login Section End -->
</body>
<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
</html>