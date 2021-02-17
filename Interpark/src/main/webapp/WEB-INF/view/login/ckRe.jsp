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
function gofinId(){
	location.href='/login/ff.me';
}

function goregi(){
	$.ajax({
		url : "/register/reg.re",
		type : "POST",
		data : {mail : $("#mail").val()},
		success : function(data) {
			alert("회원가입 페이지로 이동합니다.");
			
		},
		error : function() {
			alert("[ 이메일 찾기 실패 ]");
		}
	});
}


</script>
<body>
    <div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<form action="" method="post">
				<div class="w3-center w3-large w3-margin-top">
					<h3>가입 여부 확인</h3>
				</div>
				<div>
				<c:if test="${email eq 'no'}">
					<h5>
						${ OK1 }
					</h5>
					<h5>
						${ OK2 }
					</h5>
					<p class="w3-center">
						<button type="button" onclick="gofinId()" id=findBtn  class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">findId</button>
						<button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
					</p>
				</c:if>
			</form>
			<form action="/register/reg.re" method="post">
				<c:if test="${email eq 'YES'}">
					<h5>
						${ OK3 }
					</h5>
					<h5>
						${ OK4 }
					</h5>
					<input type="hidden" value="${mail}" name="mail">
					<p class="w3-center">
						<button type="submit" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">Register</button>
						<button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
					</p>
				</c:if>
			</form>
				</div>
			
		</div>
	</div>
</body>
<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
