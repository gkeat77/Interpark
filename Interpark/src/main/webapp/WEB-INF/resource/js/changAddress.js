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
			location.href = "addList.me";
		},
		error : function() {
			alert("[ 주소록 추가 실패 ]");
		}
	  });
	  
}

function selectAddress() {
  var data = {a_ID : $("#a_id").val()};
  $.ajax({
		url : "selectAddress.me",
		type : "POST",
		data : data,
		success : function(data) {
			alert(data)
		},
		error : function() {
			alert("[주소록 찾기 실패 ]");
		}
	  });
}


function editAddress(id){
	$.ajax({
		url : "editAddress.me",
		type : "POST",
		data : {A_TITLE : $("#A_TITLE").val(),
			A_AD1 : $("#Adetailaddr").val(),
			A_AD2 : $("#Aloginaddr").val(),
			A_AD3 : $("#Aloginaddr1").val(),
			A_PHONE1 : $("#AregisterPhone1").val(),
			A_PHONE2 : $("#AregisterPhone2").val(),
			A_PHONE3 : $("#AregisterPhone3").val(),
			A_NAME : $("#a_name").val(),
		},
		success : function(data) {
			alert("주소록이 수정되었습니다.");
			location.href = "addList.me";
		},
		error : function() {
			alert("[ 주소록 수정 실패 ]");
		}
	  });
	  
}