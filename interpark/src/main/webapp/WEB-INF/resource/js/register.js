
// 유효값 검사
var idCheckResult = "" ;

function AfValidateStudent() {
	var chk = checkNotEmpty(
			[
				    [ "AregisterName"  ,"이름을 입력해 주세요."     ]
				,	[ "AregisterId"    ,"아이디를 입력해 주세요."    ]
				,	[ "AregisterPwd"   ,"비밀번호를 입력해 주세요."   ]
				,	[ "AregisterPwdOk" ,"비밀번호 확인을 입력해 주세요."] 	
				,	[ "Aloginaddr"     ,"주소를 입력해 주세요."     ] 
				,	[ "Aloginaddr1"    ,"상세주소를 입력해 주세요."   ] 					    
				,	[ "Adetailaddr"    ,"우편번호를 입력해 주세요."   ] 	
				,	[ "AregisterPhone1","연락처를 입력해 주세요."    ]
				,	[ "AregisterPhone2","연락처를 입력해 주세요."    ]
				,	[ "AregisterPhone3","연락처를 입력해 주세요."    ]
				,	[ "AregisterEmail1","이메일을 입력해 주세요."    ]
			    ,	[ "AregisterBank","환불받을 은행이름을 입력해 주세요."    ]
			    ,	[ "AregisterAccount","환불계좌번호를 입력해 주세요."    ]
			]
	);
	if (!chk) { return; }
	
	// 이름 체크
	var  name   = $("#AregisterName").val();
	var $name   = $('#AregisterName');
	if(name.length > 10){
		alert("이름은 10자 이하로 입력해주세요.");
	    ($name).focus();
	    return;
	}
	//id 체크
	var  Id   = $("#AregisterId").val();
	var $Id   = $('#AregisterId');	
	if(Id.length < 5 || Id.length > 20){
		alert("아이디는 5~20 자로 입력해주세요.");
	   ($Id).focus();
	   return;
	}
	
	//비밀번호 체크
	var  pass1   = $("#AregisterPwd"  ).val();
	var  pass2   = $("#AregisterPwdOk").val();
	var $pass2   = $('#AregisterPwdOk');
	
	if(pass1.length < 5 || pass1.length > 15 ){
		alert("비밀번호는 5~15 글자로 입력해주세요");
	   ($pass2).focus();
	   return;
	}
	if(pass1 != pass2){
		alert("비밀번호가 일치하지 않습니다");
	   ($$pass2).focus();
	   return;
	}	
	//연락처 체크
	var  phone1   = $("#AregisterPhone1").val();
	var $phone1   = $('#AregisterPhone1');	
	if(phone1.length != 3 ){
		alert("연락처 형식을 맞춰주세요");
	    ($phone1).focus();
	    return;
	}	
	var  phone2   = $("#AregisterPhone2").val();
	var $phone2   = $('#AregisterPhone2');	
	if(phone2.length != 4 ){
		alert("연락처 형식을 맞춰주세요");
	    ($phone2).focus();
	    return;
	}
	var  phone3   = $("#AregisterPhone3").val();
	var $phone3   = $('#AregisterPhone3');	
	if(phone3.length != 4 ){
		alert("연락처 형식을 맞춰주세요");
	    ($phone3).focus();
	    return;
	}
	
	// 이메일 체크
	var  pattern_spc = /[~!#$%^&*()_+|<>?:{}]/;
	var  Email1   = $("#AregisterEmail1").val();
	var $Email1   = $('#AregisterEmail1');

	if(pattern_spc.test(Email1)){
		alert("이메일에 특수 문자를 사용하실 수 없습니다.");
		($Email1).focus();
		return;
	}
	return true;
}
	
	


/* 회원가입  신규등록*/
function AfPopModalLsmCod(loginID) {
	var frm = $("#ARegisterForm");
	if (loginID == null || loginID == "") {
		frm.find("input[name=action]").val("I");
		gfModalPop("#layerA");
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
//우편번호 api
// 우편번호 찾기 화면을 넣을 element
var element_layer = document.getElementById('layer');

function closeDaumPostcode() {
    // iframe을 넣은 element를 안보이게 한다.
    element_layer.style.display = 'none';
}
function execDaumPostcode() {
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
			document.getElementById('Adetailaddr').value = data.zonecode;
			document.getElementById('Aloginaddr').value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById('Aloginaddr1').focus();
		}
	}).open({ });
}

 /* 이메일 인증 */
/*function SendComplete() {
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
} */

	function IDCheck( form ) {
		$.ajax({
			url : "/register/id_check.re",
			type : "POST",
			async : true ,
			//data : $('#ARegisterForm').serialize(),
			data : $("#"+form).serialize(),
			success : function(data) {
				if(data.OK=="N"){
					$("#id_check").html("중복된 아이디가 있습니다.");
				}else if(data.OK=="Y"){
					ACompleteRegister(form);				}
			},
			error : function() {
				alert("중복된 아이디가 있습니다");
			}
		});		
	}
	
	function emailCheck( form ) {
		$.ajax({
			url : "/register/id_check.re",
			type : "POST",
			async : true ,
			//data : $('#ARegisterForm').serialize(),
			data : $("#"+form).serialize(),
			success : function(data) {
				if(data.OK=="N"){
					alert("중복된  이메일이라니까!!!!!!!!!!!!!!!!!!!");
				}else if(data.OK=="Y"){
					ACompleteRegister(form);				}
			},
			error : function() {
				alert("중복된 아이디가 있습니다");
			}
		});		
	}

	/* 일반 회원가입  완료*/
	function ACompleteRegister( form ) {
		$.ajax({
			url : "/register/aregister.re",
			type : "POST",
			data : $("#"+form).serialize(),
			success : function(data) {
				alert("회원가입이 완료 되었습니다");
				location.href = "/login/login.me";
			},
			error : function() {
				alert("[ 회원 신규 등록 에러 ]");
			}
		});
	}


	//생일 선택
	function Today(year,mon,day){
	  if(year == "null" && mon == "null" && day == "null"){       
	  today = new Date();
	  this_year=today.getFullYear();
	  this_month=today.getMonth();
	  this_month+=1;
	  
	  if(this_month <10) 
	 	 this_month="0" + this_month;

	  this_day=today.getDate();
	  if(this_day<10) 
	 	 this_day="0" + this_day;     
	}
	else{  
	  var this_year = eval(year);
	  var this_month = eval(mon); 
	  var this_day = eval(day);
	}

	montharray=new Array(31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31); 
	maxdays = montharray[this_month-1]; 
	//아래는 윤달을 구하는 것
	if (this_month==2) { 
	   if ((this_year/4)!=parseInt(this_year/4)) maxdays=28; 
	   else maxdays=29; 
	} 

	document.writeln("<select name='year' size=1 style=width:80px; height:20px; onChange='dateSelect(this.form,this.form.month.selectedIndex);'>");
	for(i=this_year-50;i<this_year+1;i++){//현재 년도에서 과거로 5년까지 미래로 5년까지를 표시함
	   if(i==this_year) document.writeln("<OPTION VALUE="+i+ " selected >" +i); 
	   else document.writeln("<OPTION VALUE="+i+ ">" +i); 
	 }    
	document.writeln("</select>&nbsp;&nbsp;년&nbsp;&nbsp;");      
	document.writeln("<select name='month' size=1 style=width:50px; height:20px; onChange='dateSelect(this.form,this.selectedIndex);'>");
	for(i=1;i<=12;i++){ 
	   if(i<10){
	      if(i==this_month) 
	     	 document.writeln("<OPTION VALUE=0" +i+ " selected >0"+i); 
	      else 
	     	 document.writeln("<OPTION VALUE=0" +i+ ">0"+i);
	   }else{
	      if(i==this_month) 
	     	 document.writeln("<OPTION VALUE=" +i+ " selected >" +i);  
	      else document.writeln("<OPTION VALUE=" +i+ ">" +i);  
	   }                     
	}         
	document.writeln("</select>&nbsp;&nbsp;월&nbsp;&nbsp;");
	document.writeln("<select name='day' size=1 style=width:50px; height:20px;>");
	for(i=1;i<=maxdays;i++){ 
	   if(i<10){
	      if(i==this_day) 
	     	 document.writeln("<OPTION VALUE=0" +i+ " selected >0"+i); 
	      else 
	     	 document.writeln("<OPTION VALUE=0" +i+ ">0"+i); 
	   }else{
	      if(i==this_day) 
	     	 document.writeln("<OPTION VALUE=" +i+ " selected } >"+i); 
	      else 
	     	 document.writeln("<OPTION VALUE=" +i+ ">" +i);  
	   }                     
	 }         
	document.writeln("</select>&nbsp;&nbsp;일&nbsp;&nbsp;"); 
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




