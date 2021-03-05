$(document).ready(function() {
	// 쿠키값을 가져온다.
	var cookie_user_id = getCookie('userId');
	if (cookie_user_id != "") {
		$("#userId").val(cookie_user_id);
		$("#cb_saveId").attr("checked", true);
	}
});
/* 로그인 !!*/
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
	callAjax("/login/loginProc.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
}

/* 로그인 결과 */
function fLoginProcResult(data) {
	if (data.result == "SUCCESS") {
		console.log("redirectUrl:"+data.redirectUrl);
		location.href = data.redirectUrl;
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

/** 로그인 ID 중복 체크 콜백 함수 */
function fCheckLgnIdResult(data) {
	if (data.result == "SUCCESS") {
		$("#myForm").find("#idCheckFlag").val(data.isPossible);
		$("#myForm").find("#userPwd").focus();
	}
}

/* 로그인 validation */
function fValidateLogin() {
	var chk = checkNotEmpty([ [ "userId", "아이디를 입력해 주세요." ],
			[ "userPwd", "비밀번호를 입력해 주세요." ] ]);
	if (!chk) {
		return;
	}
	return true;
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
		url : "findPass.do",
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
	callAjax("/registerFindId.do", "post", "json", true, $("#modalForm").serialize(), resultCallback);
}

/** PW 조회 */
function fSelectDataPw() {
	var resultCallback = function(data) {
		fSelectDataResultPw(data);
	};

	callAjax("/registerFindPwd.do", "post", "json", true, $("#modalForm2").serialize(), resultCallback);
}

/** pw 저장 */
function fSaveData() {

	var resultCallback = function(data) {
		fSaveDataResult(data);
	};
	callAjax("/updateFindPw.do", "post", "json", true, $("#modalForm2").serialize(), resultCallback);
}

/** 데이터 저장 콜백 함수 */
function fSaveDataResult(data) {
	if (data.result == "SUCCESS") {
		// 응답 메시지 출력
		alert(data.resultMsg);
		location.href = "/login/login.me";
	} else {
		// 오류 응답 메시지 출력
		alert(data.resultMsg);
	}
}


