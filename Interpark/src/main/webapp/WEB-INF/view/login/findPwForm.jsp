<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script>
function findPw(){
	$.ajax({
		url : '/login/findPass.me',
		type : 'post',
		data : {loginID : $("#loginID").val(),
			mail : $("#mail").val()},
		dataType : 'json',
		success : function(data) {
			alert("귀하의 비밀번호는 : " + "입니다");
		}
	});
}
</script>
<body>
    <div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<form action="/login/findPw.me" method="post">
				<div class="w3-center w3-large w3-margin-top">
					<h3>비밀번호 찾기</h3>
				</div>
				<div>
					<p>
						<label>ID</label>
						<input class="w3-input" type="text" id="loginID" name="loginID" required>
						<label>Email</label>
						<input class="w3-input" type="text" id="mail" name="mail" required>
					</p>
					<p class="w3-center">
						<button type="button" onclick="findPw()" id=findBtn  class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">find</button>
						<button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
					</p>
				</div>
			</form>
			<c:if test="${msg == false}">
				존재하지 않는 아이디거나 메일 등록이 안되어있습니다.
			</c:if>
		</div>
	</div>
</body>
<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
