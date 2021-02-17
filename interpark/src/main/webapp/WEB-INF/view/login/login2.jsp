<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

<!-- 우편번호 조회 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/login.js"></script>
<script type="text/javascript" src="${CTX_PATH}/js/login_pub.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		$("#confirm").hide();
		$("#loginRegister").hide();
		$("#loginEmail").hide();
		$("#loginPwd").hide();
		
	
		// 쿠키값을 가져온다.
		var cookie_user_id = getCookie('EMP_ID');
		if (cookie_user_id != "") {
			$("#EMP_ID").val(cookie_user_id);
			$("#cb_saveId").attr("checked", true);
		}

		$("#EMP_ID").focus();
		$( function() { $( "#Adatepicker" ).datepicker({dateFormat:"yymmdd"}); }).val();
		$( function() { $( "#Bdatepicker" ).datepicker({dateFormat:"yymmdd"}); }).val();
		$( function() { $( "#Ddatepicker" ).datepicker({dateFormat:"yymmdd"}); }).val();
		
	});

	/* 아이디/비밀번호 찾기 모달창 실행 */
	function findIdPwd() {
		// 모달 팝업
		gfModalPop("#layer2");
	}

	/* 회원가입 모달창 실행 */
	function fRegisterA() {
		gfModalPop("#layerA");
	}
	/* 강사 회원가입 */
	function fRegisterB() {
		gfModalPop("#layerB");
	}
	/* 관리자 회원가입 */
	function fRegisterD() {
		gfModalPop("#layerD");
	}

	/* 회원가입  신규등록*/
	function AfPopModalLsmCod(loginID) {
		var frm = $("#ARegisterForm");
		if (loginID == null || loginID == "") {
			frm.find("input[name=action]").val("I");
			gfModalPop("#layerA");
		}
	}

	/* 강사  신규등록*/
	function BfPopModalLsmCod(loginID) {
		var frm = $("#BRegisterForm");
		if (loginID == null || loginID == "") {
			frm.find("input[name=action]").val("I");
			gfModalPop("#layerB");
		}
	}

	/* 기업대표  신규등록*/
	function DfPopModalLsmCod(loginID) {
		var frm = $("#DRegisterForm");
		if (loginID == null || loginID == "") {
			frm.find("input[name=action]").val("I");
			gfModalPop("#layerD");
		}
	}

	/* 회원 가입 저장 콜백함수 */
	function fSaveRegister(data) {

		if (data.result == "SUCCESS") {
			alert(data.resultMsg);
			gfCloseModal();
		} else {
			alert(data.resultMsg);
			return false;
		}
	}
	




	// 우편번호 api
	function execDaumPostcode(loginaddr,loginaddr1,detailaddr) {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
				}
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById(detailaddr).value = data.zonecode;
				document.getElementById(loginaddr).value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById(loginaddr1).focus();
			}
		}).open({ });
	}

	/** 로그인 ID  체크 */
	function fCheckLgnId() {

		// validation 체크
		var lgn_id = $("#signForm").find("#lgn_id").val();
		if (lgn_id == "") {
			alert("아이디를 입력하세요.");
			$("#signForm").find("#lgn_id").focus();
			return;
		}
		if (!fChkId(lgn_id)) { //아이디 정규식 체크
			alert("아이디는 영문, 숫자를 포함한 7자리 이상 20자리 미만 입니다.");
			return;
		}
		// 로그인 아이디 조회
		var param = {
			lgn_id : lgn_id
		};
		var resultCallback = function(data) {
			fCheckLgnIdResult(data);
		};
		callAjax("/system/selectUsrMgr.do", "post", "json", true, param,
				resultCallback);
	}

	/** 로그인 ID 중복 체크 콜백 함수 */
	function fCheckLgnIdResult(data) {
		if (data.result == "SUCCESS") {
			$("#signForm").find("#idCheckFlag").val(data.isPossible);
			$("#signForm").find("#pwd").focus();
		}
	}

	/* 로그인 validation */
	function fValidateLogin() {

		var chk = checkNotEmpty([ [ "EMP_ID", "아이디를 입력해 주세요." ],
				[ "EMP_PWD", "비밀번호를 입력해 주세요." ] ]);
		if (!chk) {
			return;
		}
		return true;
	}

	/* 로그인 */
	function fLoginProc() {
		if ($("#cb_saveId").is(":checked")) { // 저장 체크시
			saveCookie('EMP_ID', $("#EMP_ID").val(), 7);
		} else { // 체크 해제시는 공백
			saveCookie('EMP_ID', "", 7);
		}
		// vaildation 체크
		if (!fValidateLogin()) {
			return;
		}
		var resultCallback = function(data) {
			fLoginProcResult(data);
		};
		callAjax("/loginProc.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
	}

	/* 로그인 결과 */
	function fLoginProcResult(data) {

		var lhost = data.serverName;
		if (data.result == "SUCCESS") {
			location.href = "${CTX_PATH}/dashboard/dashboard.do";
		} else {
			$("<div style='text-align:center;'>" + data.resultMsg + "</div>")
					.dialog({
						modal : true,
						resizable : false,
						buttons : [ {
							text : "확인",
							click : function() {
								$(this).dialog("close");
								$("#EMP_ID").val("");
								$("#EMP_PWD").val("");
								$("#EMP_ID").focus();
							}
						} ]
					});
			$(".ui-dialog-titlebar").hide();
		}
	}

	/*이메일 기능  (아이디 있는지 없는지 체크)*/
	function SendEmail() {
		var data = {
			"email" : $("#emailText").val(),
			"data-code" : $("#emailText").attr("data-code")
		};

		$.ajax({
			url : "/registerFindId.do",
			type : "post",
			dataType : "json",
			async : false,
			data : data,
			success : function(flag) {
				if (flag != '1') {
					alert("해당 이메일로 인증번호를 전송하였습니다.");
					$("#authNumId").val(flag);
					$("#confirm").show();
				} else if (flag == '1') {
					alert("존재하지 않는 이메일 입니다.");
				} else if (flag.length < 1) {
					alert("이메일을 입력해주세요.");
				}
			}
		});
	}

	/* 이메일 기능 (비밀번호 기능)*/
	function SendPwdEmail() {

		var data = {
			email       : $("#emailPwdText").val(),
			loginID     : $("#emailIdText").val(),
		   "data-code"  : $("#emailPwdText").attr("data-code")

		};

		console.log(data);

		$.ajax({
			url : "/registerFindPwd.do",
			type : "post",
			dataType : "json",
			async : false,
			data : data,
			success : function(flag) {

				if (flag != '1') {
					alert("해당 이메일로 임시 비밀번호를 전송하였습니다.");
					$("#authNumPwd").val(flag);
					$("#loginPwd").show();
				} else if (flag.length < 1) {
					alert("이메일을 입력해주세요.");
				} else if (flag == '1') {
					alert("이메일이 틀렸습니다.");
				}
				pwdCheck();
			}
		});
	}

	function pwdCheck() {
		var email = $("#emailPwdText");

		if (email.length < 1) {
			alert("이메일을 입력해주세요.");
		}
	}

	/* 이메일 인증 */
	function SendComplete() {
		var inputNum = $("#emailNum").val();
		var emailNum = $("#authNumId").val();
		if (inputNum.length < 1) {
			alert("인증번호를 입력해주세요.");
			return false;
		} else if (emailNum != inputNum) {
			alert("인증번호가 틀렸습니다.");
			return false;
		} else if (emailNum == inputNum) {
			alert("인증 되었습니다.");
			$("#authNumId").val('');

			// 아이디 메일 전송 함수호출
			findId();
		}
	}

	/* 이메일 비밀번호 인증 */
	function SendCompletePwd() {
		var inputPwd = $("#emailPwdNum").val();
		var emailPwdNum = $("#authNumPwd").val();
		if (inputPwd.length < 1) {
			alert("비밀번호를 입력해주세요.");
			return false;
		} else if (emailPwdNum != inputPwd) {
			alert("비밀번호가 틀렸습니다.");
			return false;
		} else if (emailPwdNum == inputPwd) {
			alert("비밀번호가 맞습니다.");
			$("#authNumPwd").val('');

			// 비밀번호 호출하는 함수
			findPwd();
		}
	}
	/* 아이디 뜨게 하는 */
	var findId = function() {
		var data = {
			"email" : $("#emailText").val()
		};
		$.ajax({
			url : '/findRegisterId.do',
			type : 'post',
			data : data,
			dataType : 'text',
			async : false,
			success : function(data) {
				// 모달 or span 
				alert("귀하의 아이디는 : " + data + "입니다");
				gfCloseModal();
			}
		});
	}

	/* 비밀번호 뜨게 하는 창 */
	var findPwd = function() {
		var data = {
			"loginID" : $("#emailIdText").val(),
			"email"   : $("#emailPwdText").val()
		};
		$.ajax({
			url : '/findRegisterPwd.do',
			type : 'post',
			data : data,
			dataType : 'text',
			async : false,
			success : function(data) {
				alert("귀하의 비밀번호는 : " + data + "입니다");
				gfCloseModal();
			}
		});
	}
	/* 비밀번호 찾기 아이디 체크 */
	function CheckIdRegister() {
		var inputid = $("#emailIdText").val();
		var ckId = $("#ckIdcheck").val();
		if (inputid.length < 1) {
			alert("가입하신 아이디를 입력해주세요.");
			return false;
		} else if (ckId != inputid) {
			alert("가입하신 아이디가 맞지 않습니다.");
			return false;
		} else if (ckId == inputid) {
			alert("가입하신 아이디가 맞습니다.");
			$("#ckIdcheck").val("");

			// 비번찾기에서 아이디 체크하는 창 (알림창)
			RegisterIdCheck();
		}
	}

	/* 비밀번호 찾기에서 아이디 체크하는 창(가입된 아이디가 알람창으로) */
	function RegisterIdCheck() {
		var loginid = $("#emailIdText").val();

		var data = {
			"loginID" : loginid
		};
		console.log(data);

		$.ajax({
			url : "/registerIdCheck.do",
			type : "post",
			dataType : "json",
			async : false,
			data : data,
			success : function(data) {
				if (loginid.length < 1) {
					alert("아이디를 입력해주세요.");
				}
				else if (data.cnt > 0) {
					alert("아이디가 존재합니다.");
				} else {
					alert("아이디가 존재하지 않습니다.");
				}

			}

		});
	}
	/* 아이디 찾기 버튼 클릭 이벤트 */
	function fSelectId() {

		gfModalPop("#layer2");
		$("#registerEmailId").show();
		$("#loginRegister").hide();
		$("#loginEmail").hide();
		$("#loginPwd").hide();

	}

	/* 비밀번호 찾기 버튼 클릭 이벤트 */
	function fSelectPwd() {

		$("#registerEmailId").hide();
		$("#confirm").hide();
		$("#loginRegister").show();
		$("#loginEmail").show();
		$("#loginPwd").hide();
		gfModalPop("#layer2");
	}

	/* 아이디 찾기 메일 인증하기 버튼 클릭 이벤트 */
	function fSelectIdOk() {
		$("#emailOk").on("click", function() {
			alert("인증이 완료 되었습니다.")
		});
	}

	/** ID 조회 */
	function fSelectData() {
		var resultCallback = function(data) {
			fSelectDataResult(data);
		};
		callAjax("/registerFindId.do", "post", "json", true, $("#modalForm")
				.serialize(), resultCallback);
	}

	/** PW 조회 */
	function fSelectDataPw() {
		var resultCallback = function(data) {
			fSelectDataResultPw(data);
		};

		callAjax("/registerFindPwd.do", "post", "json", true, $("#modalForm2")
				.serialize(), resultCallback);
	}

	/** pw 저장 */
	function fSaveData() {

		var resultCallback = function(data) {
			fSaveDataResult(data);
		};
		callAjax("/updateFindPw.do", "post", "json", true, $("#modalForm2")
				.serialize(), resultCallback);
	}

	/** 데이터 저장 콜백 함수 */
	function fSaveDataResult(data) {
		if (data.result == "SUCCESS") {
			// 응답 메시지 출력
			alert(data.resultMsg);
			location.href = "/login.do";
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
	}

	function Fclick(obj) {
		if (obj.getAttribute('class') == "none") {
			document.getElementById('genderResult').setAttribute('value', '1');
		}
	}
	
	
	function dateSelect(docForm,selectIndex) {
		watch = new Date(docForm.year.options[docForm.year.selectedIndex].text, docForm.month.options[docForm.month.selectedIndex].value,1);
		hourDiffer = watch - 86400000;
		calendar = new Date(hourDiffer);
	
		var daysInMonth = calendar.getDate();
			for (var i = 0; i < docForm.day.length; i++) {
				docForm.day.options[0] = null;
			}
			for (var i = 0; i < daysInMonth; i++) {
				docForm.day.options[i] = new Option(i+1);
		}
		document.form1.day.options[0].selected = true;
	}

</script>
 <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Muli:300,400,500,600,700,800,900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/themify-icons.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
</head>
<body>

<form id="myForm" action="" method="post">
    <div class="page-container">
        <div class="login-form-container shadow">
            <div class="login-form-right-side">
                <div class="top-logo-wrap">
                <img src="${CTX_PATH}/img/admin/login/logo_img.png">
                </div>
                <h1>훈련을 통해 나를 만든다.</h1>
                <p>Learning Management System</p>
            </div>
            <div class="login-form-left-side">
                <div class="login-top-wrap">
                </div>
                <div class="login-input-container">
                    <div class="login-input-wrap input-id">
                        <i class="far fa-envelope"></i>
						<input type="text" id="EMP_ID" name="lgn_Id" placeholder="아이디" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" style="ime-mode: inactive;" />                    
						</div>
                    <div class="login-input-wrap input-password">
                        <i class="fas fa-key"></i>
						<input type="password" id="EMP_PWD" name="pwd" placeholder="비밀번호" onfocus="this.placeholder=''; return true" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" /></div>
						<input type="checkbox" id="cb_saveId" name="" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}">
					<span class="id_save">ID 저장</span> <br>
                </div>
                		
                <div class="login-btn-wrap">
					<a class="btn_login" href="javascript:fLoginProc();" id="btn_login"><strong>로그인</strong></a>
					<a href="javascript:AfPopModalLsmCod();" id="RegisterBtn" name="modal"><strong>[회원가입]</strong></a> <a href="javascript:findIdPwd();"><strong>[아이디/비밀번호 찾기]</strong></a>
                </div>
            </div>
        </div>
    </div>
  </form>  
    
<!-- 모달팝업 -->

	<form id="ARegisterForm" action="" method="post">
		<input type="hidden" name="action" id="action" value="">
		<div id="layerA" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>학생 회원 가입</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>
						<tbody>
							<tr class="sel">
								<th scope="row" colspan="4">
									<a href="javascript:AfPopModalLsmCod();" class="btnType gray regi_a" id="btnCloseLsmCod" name="btn">학생 회원가입</a>
									<a href="javascript:BfPopModalLsmCod();" class="btnType gray regi_a" id="btnCloseLsmCod" name="btn">강사 회원가입</a>
									<a href="javascript:DfPopModalLsmCod();" class="btnType gray regi_a" id="btnCloseLsmCod" name="btn">기업 회원가입</a>
								</th>
							</tr>						
							
							<tr>
								<th scope="row">이름<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"  name="name" id="AregisterName" /></td>
								<th scope="row">아이디 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="loginID" id="AregisterId" /></td>
							</tr>
							<tr>
								<th scope="row">비밀번호 <span class="font_red">*</span></th>
								<td colspan="3"><input type="password" class="inputTxt p100" name="password" id="AregisterPwd" /></td>
							</tr>
							<tr>
								<th scope="row">비밀번호 확인<span class="font_red">*</span></th>
								<td colspan="3"><input type="password" class="inputTxt p100" name="password1" id="AregisterPwdOk" /></td>
							</tr>	
							<tr>
								<th scope="row">우편번호<span class="font_red">*</span></th>
								<td colspan="2"><input type="text" class="inputTxt p100" name="user_post" id="Adetailaddr" /></td>
								<td><input type="button" value="우편번호 찾기" onclick="execDaumPostcode('Aloginaddr','Aloginaddr1','Adetailaddr')" class="address_search" /></td>								
							</tr>
							<tr>
								<th scope="row">주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="addr" id="Aloginaddr" /></td>
							</tr>
							<tr>
								<th scope="row">상세주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="addr_detail" id="Aloginaddr1" /></td>
							</tr>
							<tr>
							<tr>
							     <th scope="row">성별 <span class="font_red">*</span></th>
					             <td colspan="3">
					             	<input type="radio" name="sex" value="M" id="AregisterSex">  &nbsp;&nbsp;&nbsp; 남  &nbsp;&nbsp;&nbsp; 
					             	<input type="radio" name="sex" value="F" id="AregisterSex">  &nbsp;&nbsp;&nbsp; 여  &nbsp;&nbsp;&nbsp; 
					             </td>
							</tr>
							<tr>
								<th scope="row">연락처 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="phone" name="tel1" id="AregisterPhone1" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="text" class="phone" name="tel2" id="AregisterPhone2" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="text" class="phone" name="tel3" id="AregisterPhone3" /> 
								</td>
							</tr>
							<tr>
								<th scope="row">생년 월일 <span class="font_red">*</span></th>
								<td colspan="3">
									<script language="javascript"> Today('null','null','null'); </script>
								</td>
							</tr>
							<tr>
								<th scope="row">주민 번호 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="pid" name="pid1" id="AregisterPid1" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="password" class="pid" name="pid2" id="AregisterPid2" />
								</td>
							</tr>	
							<tr>
								<th scope="row">이메일<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="mail" name="mail1" id="AregisterEmail1" />
										&nbsp;&nbsp; @ &nbsp;&nbsp;
									<input type="text" class="mail" name="mail2" id="AregisterEmail2" />
								</td>
							</tr>
							<input type="hidden" name="user_type" value="A" />
						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<a href="javascript:IDCheck('ARegisterForm');" class="btnType blue" id="RegisterCom" name="btn"><span>가입</span></a>
						<a href="" class="btnType gray" id="btnCloseLsmCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>

	<!-- 강사  회원가입  -->
	<form id="BRegisterForm" action="" method="post">
		<div id="layerB" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>강사 회원 가입</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>

						<tbody>
							<tr class="sel">
								<th scope="row" colspan="4">
									<a href="javascript:AfPopModalLsmCod();" class="btnType gray regi_a" id="btnCloseLsmCod" name="btn">학생 회원가입</a>
									<a href="javascript:BfPopModalLsmCod();" class="btnType gray regi_a" id="btnCloseLsmCod" name="btn">강사 회원가입</a>
									<a href="javascript:DfPopModalLsmCod();" class="btnType gray regi_a" id="btnCloseLsmCod" name="btn">기업 회원가입</a>
								</th>
							</tr>
							<tr>
								<th scope="row">이름<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="name" id="BregisterName" /></td>
								<th scope="row">아이디 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="loginID" id="BregisterId" /></td>
							</tr>
							<tr>
								<th scope="row">비밀번호 <span class="font_red">*</span></th>
								<td colspan="3"><input type="password" class="inputTxt p100" name="password" id="BregisterPwd" /></td>
							</tr>
							<tr>
								<th scope="row">비밀번호 확인<span class="font_red">*</span></th>
								<td colspan="3"><input type="password" class="inputTxt p100" name="password1" id="BregisterPwdOk" /></td>
							</tr>
							<tr>
								<th scope="row">우편번호<span class="font_red">*</span></th>
								<td colspan="2"><input type="text" class="inputTxt p100" name="user_post" id="Bdetailaddr" /></td>
								<td><input type="button" value="우편번호 찾기" onclick="execDaumPostcode('Bloginaddr','Bloginaddr1','Bdetailaddr')" class="address_search" /></td>
							</tr>							
							<tr>
								<th scope="row">주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="addr" id="Bloginaddr" /></td>
							</tr>							
							<tr>
								<th scope="row">상세주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="addr_detail" id="Bloginaddr1" /></td>
							</tr>
							<tr>
							     <th scope="row">성별 <span class="font_red">*</span></th>
					             <td colspan="3">
					             	<input type="radio" name="sex" value="M" id="BregisterSex">  &nbsp;&nbsp;&nbsp; 남  &nbsp;&nbsp;&nbsp; 
					             	<input type="radio" name="sex" value="F" id="BregisterSex">  &nbsp;&nbsp;&nbsp; 여  &nbsp;&nbsp;&nbsp; 
					             </td>
							</tr>
							<tr>
								<th scope="row">연락처 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="phone" name="tel1" id="BregisterPhone1" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="text" class="phone" name="tel2" id="BregisterPhone2" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="text" class="phone" name="tel3" id="BregisterPhone3" /> 
								</td>
							</tr>
							<tr>
								<th scope="row">생년 월일 <span class="font_red">*</span></th>
								<td colspan="3">
									<script language="javascript"> Today('null','null','null'); </script>
								</td>
							</tr>							
							<tr>
								<th scope="row">주민 번호 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text"     class="pid" name="pid1" id="BregisterPid1" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="password" class="pid" name="pid2" id="BregisterPid2" />
								</td>
							</tr>	
							<tr>
								<th scope="row">이메일<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="mail" name="mail1" id="BregisterEmail1" />
										&nbsp;&nbsp; @ &nbsp;&nbsp;
									<input type="text" class="mail" name="mail2" id="BregisterEmail2" />
								</td>
							</tr>
							<input type="hidden" name="user_type" value="D" />
						</tbody>
					</table>
					<div class="btn_areaC mt30">
						<a href="javascript:IDCheck('BRegisterForm');" class="btnType blue" id="RegisterCom" name="btn"><span>가입</span></a>
						<a href="" class="btnType gray" id="btnCloseLsmCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
		</div>
	</form>
	
		<!-- 대표 회원가입  -->
	<form id="DRegisterForm" action="" method="post">
		<div id="layerD" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>대표 회원 가입</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>

						<tbody>
							<tr class="sel">
								<th scope="row" colspan="4">
									<a href="javascript:AfPopModalLsmCod();" class="btnType gray regi_a" id="btnCloseLsmCod" name="btn">학생 회원가입</a>
									<a href="javascript:BfPopModalLsmCod();" class="btnType gray regi_a" id="btnCloseLsmCod" name="btn">강사 회원가입</a>
									<a href="javascript:DfPopModalLsmCod();" class="btnType gray regi_a" id="btnCloseLsmCod" name="btn">기업 회원가입</a>
								</th>
							</tr>
							<tr>
								<th scope="row">대표자명<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="name" id="DregisterName" /></td>
								<th scope="row">기업명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="comp_name" id="DregisterComp_name" /></td>

							</tr>
							<tr>
								<th scope="row">아이디 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="loginID" id="DregisterId" /></td>
							</tr>
							<tr>
								<th scope="row">비밀번호 <span class="font_red">*</span></th>
								<td colspan="3"><input type="password" class="inputTxt p100" name="password" id="DregisterPwd" /></td>
							</tr>
							<tr>
								<th scope="row">비밀번호 확인<span class="font_red">*</span></th>
								<td colspan="3"><input type="password" class="inputTxt p100" name="password1" id="DregisterPwdOk" /></td>
							</tr>
							<tr>
								<th scope="row">우편번호<span class="font_red">*</span></th>
								<td colspan="2"><input type="text" class="inputTxt p100" name="comp_addr2" id="DregisterComp_addr2" /></td>
								<td><input type="button" value="우편번호 찾기" onclick="execDaumPostcode('DregisterComp_addr','DregisterComp_addr1','DregisterComp_addr2')" class="address_search" /></td>
							</tr>							
							<tr>
								<th scope="row">기업 주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="comp_addr" id="DregisterComp_addr" /></td>
							</tr>
							<tr>
								<th scope="row">기업 상세주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="comp_addr1" id="DregisterComp_addr1" /></td>
							</tr>
							<tr>
							     <th scope="row">성별 <span class="font_red">*</span></th>
					             <td colspan="3">
					             	<input type="radio" name="sex" value="M" id="DregisterSex">  &nbsp;&nbsp;&nbsp; 남  &nbsp;&nbsp;&nbsp; 
					             	<input type="radio" name="sex" value="F" id="DregisterSex">  &nbsp;&nbsp;&nbsp; 여  &nbsp;&nbsp;&nbsp; 
					             </td>
							</tr>							
							<tr>
								<th scope="row">연락처 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="phone" name="tel1" id="DregisterTel1" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="text" class="phone" name="tel2" id="DregisterTel2" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="text" class="phone" name="tel3" id="DregisterTel3" /> 
								</td>
							</tr>
							
							<tr>
								<th scope="row">기업 연락처 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="phone" name="comp_tel1" id="Dregistercomp_tel1" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="text" class="phone" name="comp_tel2" id="Dregistercomp_tel2" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="text" class="phone" name="comp_tel3" id="Dregistercomp_tel3" /> 
								</td>
							</tr>
							<tr>
								<th scope="row">생년 월일 <span class="font_red">*</span></th>
								<td colspan="3">
									<script language="javascript"> Today('null','null','null'); </script>
								</td>
							</tr>
							<tr>
								<th scope="row">주민 번호 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text"     class="pid" name="pid1" id="DregisterPid1" /> <b>&nbsp;&nbsp;-&nbsp;&nbsp;</b> 
									<input type="password" class="pid" name="pid2" id="DregisterPid2" />
								</td>
							</tr>	
							<tr>
								<th scope="row">기업 이메일<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="mail" name="mail1" id="DregisterEmail1" />
										&nbsp;&nbsp; @ &nbsp;&nbsp;
									<input type="text" class="mail" name="mail2" id="DregisterEmail2" />
								</td>
							</tr>
							
														
								<input type="hidden" name="user_type" value="E" />
						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<a href="javascript:IDCheck('DRegisterForm');" class="rSubmit btnType blue" id="RegisterCom" name="btn"><span>가입</span></a>
						<a href="" class="btnType gray" id="btnCloseLsmCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
		</div>
	</form>
	
	
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
						<a href="javascript:fSelectId();"  class="btnType gray" id="findId" ><span>아이디 찾기</span></a> 
						<a href="javascript:fSelectPwd();" class="btnType gray" id="findPwd"><span>비밀번호 찾기</span></a>
					</div>
					<div>
						<br><span>* 등록되어 있는 이메일로 전송 됩니다.</span>
					</div>
				</dd>
				<dd class="content">
					<!-- 아이디/비밀번호 찾기 폼 -->
					<table class="row" id="findForm">
						<tbody>
							<tr>
								<td id="registerEmailId">
									<input type="text" id="emailText" data-code="I" placeholder="가입하신 이메일을 입력하세요" size="42" style="height: 30px;" /> 
									<a href="javascript:id_SendEmail();" class="btnType blue" id="findIdSubmit"><span>아이디 전송</span></a>
								</td>
							</tr>
						</tbody>
					</table>

					<table class="row" id="findPwdForm">
						<tbody>
							<tr>
								<td id="loginRegister">
									<input type="text" id="email_pass_Text" placeholder="가입하신 아이디를 입력하세요" size="40" style="height: 30px;" />
									<a href="javascript:pass_SendEmail();" class="btnType blue" id=""><span>임시비밀번호 전송</span></a>
								</td>
							</tr>
						</tbody>
					</table>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
	
	 <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
</body>

</html>
