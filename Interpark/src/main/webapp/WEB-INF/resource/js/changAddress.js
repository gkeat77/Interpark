/* 일반 회원가입  완료*/
function userAddressAdd( form ) {
	$.ajax({
		url : "memberInfo.me",
		type : "POST",
		data : $("#"+form).serialize(),
		success : function(data) {
			alert("회원정보가 수정되었습니다.");
			location.href = "index.do";
		},
		error : function() {
			alert("[ 회원 정보 수정 실패 ]");
		}
	});
}

function showPopup(hasFilter) {
	const popup = document.querySelector('#popup');
  
  if (hasFilter) {
  	popup.classList.add('has-filter');
  } 
  
  
  popup.classList.remove('hide');
}

function closePopup() {
	const popup = document.querySelector('#popup');
  popup.classList.add('hide');
}

function addAddress(){
	$.ajax({
		url : "addAddress.me",
		type : "POST",
		data : {A_TITLE : $("#A_TITLE").val(),
				user_post : $("#Adetailaddr").val(),
				addr : $("#Aloginaddr").val(),
				addr_detail : $("#Aloginaddr1").val(),
				phone1 : $("#AregisterPhone1").val(),
				phone2 : $("#AregisterPhone2").val(),
				phone3 : $("#AregisterPhone3").val(),
				a_name : $("#a_name").val(),
		},
		success : function(data) {
			alert("주소록이 추가되었습니다.");
			location.href = "ca1.me";
		},
		error : function() {
			alert("[ 주소록 수정 실패 ]");
		}
	  });
	  
}