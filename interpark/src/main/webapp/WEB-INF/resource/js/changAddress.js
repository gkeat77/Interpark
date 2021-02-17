function showPopup(hasFilter) {
	const popup = document.querySelector('.hide');
  
  if (hasFilter) {
  	popup.classList.add('has-filter');
  } 
  
  
  popup.classList.remove('hide');
}

function closePopup() {
	const popup = document.querySelector('.hide');
  popup.classList.add('hide');
}

function addAddress(){
	$.ajax({
		url : "/mypage/addAddress.my",
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
			location.href = "/mypage/addList.my";
		},
		error : function() {
			alert("[ 주소록 추가 실패 ]");
		}
	  });
	  
}

function deleteAddress(id){
	$.ajax({
		url : "/mypage/deleteAddress.my",
		type : "POST",
		data : {A_ID : id},
		success : function(data) {
			alert("주소록이 삭제되었습니다.");
			location.href = "/mypage/addList.my";
		},
		error : function() {
			alert("[ 주소록 삭제 실패 ]");
		}
	  });
	  
}

