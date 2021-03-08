<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
	<style>
		 body { font-family:'맑은 고딕', verdana; padding:0; margin:0; }
		 ul { padding:0; margin:0; list-style:none;  }
		
		 div#root { width:90%; margin:0 auto; }
		 
		 header#header { font-size:60px; padding:20px 0; }
		 header#header h1 a { color:#000; font-weight:bold; }
		 
		 nav#nav { padding:10px; text-align:right; }
		 nav#nav ul li { display:inline-block; margin-left:10px; }
		
		   section#container { padding:20px 0; border-top:2px solid #eee; border-bottom:2px solid #eee; }
		 section#container::after { content:""; display:block; clear:both; }
		 aside { float:left; width:200px; }
		 div#container_box { float:right; width:calc(100% - 200px - 20px); }
		 
		 aside ul li { text-align:center; margin-bottom:10px; }
		 
		 footer#footer { background:#f9f9f9; padding:20px; }
		 footer#footer ul li { display:inline-block; margin-right:10px; }
		 
		  aside ul li a { display:block; width:100%; padding:10px 0; color: #000; background:#eee;}
		  aside ul li a:hover { background:#eee; }
		  
		  #userInfo{
			padding: 13px 40px 11px;
			background: #6666FF;
			border-color: #6666FF;
		  	margin-bottom: 50px;
		  	margin-top: 20px;
		  }
		  
		   #userInfo2{
			padding: 13px 40px 11px;
			background: #6666FF;
			border-color: #6666FF;
		  	margin-bottom: 50px;
		  	margin-top: 20px;
		  	visibility: hidden;
		  }
		  
		  #pay{
		  	color: blue;
		  }
 	
 	
 	
 	/* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
                   
        }
    
        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 50%; /* Could be more or less, depending on screen size */
            -webkit-overflow-scrolling: touch;   
        }
        
        
 		
 
	</style>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
    <!-- Breadcrumb Section Begin -->
     <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text product-more">
                        <a href="/index.do"><i class="fa fa-home"></i> Home</a>
                        <a href="./shop.html">Shop</a>
                        <span>Info</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <input type="hidden" id="loginID" value="${member.loginID}">
	<input type="hidden" id="uploadState" name = "uploadState" value="" />
	<!-- Contact Section Begin -->
    <section class="contact-section spad">
  

        <div class="container">
         <div class="row">
                <div class="col-lg-12">
                    <div class="contact-title">
                        <h4>회원정보</h4>
                        <p>아래 정보를 확인해주시기 바랍니다.</p>
                    </div>
                    
                </div>
            </div>
        <!-- aside -->  
	   <section id="container">    
		 <aside>
		 <ul>
		  <li><a href="/mypage/my.my">회원정보 수정</a></li>
		  <li><a href="/userInfo.do?userSw=2">주소록</a></li>
		  <!-- <li><a href="">쿠폰  & 마일리지</a></li> -->
		  <li><a href="/userInfo.do?userSw=4">구매이력</a></li>
		  <li><a href="/userInfo.do?userSw=5">ORDER</a></li>
		 </ul>
		</aside>
		<!-- content -->
		<div id="container_box">
			<c:choose>
				
				
				<c:when test = "${result eq 2}">
					

					<c:if test="${empty addressS}">
					<div class="contact-widget">
		               <div class="cw-item">
		                   <div class="ci-icon">
		                       <i class="ti-cloud"></i>
		                   </div>
		                   <div class="ci-text">
		                       <span>title:</span>
		                       <p><a href="javascript:void(0);" id="pay">${address.addressTitle}</a></p>
		                   </div>
		               </div>
		             </div>
		             <ul>
		             	<li>우편번호 : ${address.address1}</li>
		             	<li>주소 : ${address.address2}</li>
		             	<li>상세주소 : ${address.address3}</li>
		             </ul>
		             <button type="button"  id="userInfo" onclick="addressModify()" class="site-btn place-btn">수정하기</button>
		             <br>
		             <button type="button"  id="userInfo" onclick="addAddress()" class="site-btn place-btn">주소 추가</button>
					</c:if>
					
					<c:if test="${not empty addressS}">
							<c:forEach var="addressS" items="${addressS}" varStatus="status">
								<div class="contact-widget">
					               <div class="cw-item">
					                   <div class="ci-icon">
					                       <i class="ti-cloud"></i>
					                   </div>
					                   <div class="ci-text">
					                       <span>title:</span>
					                       <p><a href="javascript:void(0);" id="pay">
					                       <c:if test="${status.first}">( 기 본  배 송 지  ) </c:if>
					                       ${addressS.addressTitle}</a></p>
					                   </div>
					               </div>
					             </div>
					             <ul>
					             	<li>우편번호 : ${addressS.address1}</li>
					             	<li>주소 : ${addressS.address2}</li>
					             	<li>상세주소 : ${addressS.address3}</li>
					             </ul>
					             
					             <c:choose>
									<c:when test="${status.first}">
										<button type="button"  id="userInfo" onclick="delAddress2('${addressS.address3}','${addressS.addressTitle}')" class="site-btn place-btn">삭제하기</button>
										<button type="button"  id="userInfo2" onclick="" class="site-btn place-btn">AA</button>
									</c:when>
									<c:otherwise>
										<button type="button"  id="userInfo" onclick="chooseDefault('${addressS.address3}','${addressS.addressTitle}')" class="site-btn place-btn">기본 배송지 선택하기</button>
										<button type="button"  id="userInfo" onclick="delAddress2('${addressS.address3}','${addressS.addressTitle}')" class="site-btn place-btn">삭제하기</button>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<br>
							<button type="button"  id="userInfo" onclick="addAddress()" class="site-btn place-btn">주소 추가</button>
					</c:if>
					
					
				</c:when>
				
				
				
				<c:when test = "${result eq 4}">
					<p>**최신순으로 보입니다</p>
					<c:if test="${empty buyList}">
						<div class="contact-widget">
		               <div class="cw-item">
		                   <div class="ci-icon">
		                       <i class="ti-cloud"></i>
		                   </div>
		                   <div class="ci-text">
		                       <span>결제번호:</span>
		                       <p><a href="" id="pay">구매내역이 없습니다</a></p>
		                   </div>
		               </div>
		             </div>
					</c:if>
					
				 	<c:forEach var="buyList" items="${buyList}">
					<div class="contact-widget">
		               <div class="cw-item">
		                   <div class="ci-icon">
		                       <i class="ti-cloud"></i>
		                   </div>
		                   <div class="ci-text">
		                       <span>결제번호:</span>
		                       <p><a href="javascript:void(0);" id="pay" onclick="orderCart(${buyList.payNo})">${buyList.payNo}</a></p>
		                   </div>
		               </div>
		             </div>
		             <ul>
						<li>구매일자: ${buyList.regDt }</li>
						<li>결제상태: ${buyList.state}</li>
					</ul>
					
					<c:choose>
						<c:when test="${buyList.state eq '입금대기중'}">
							<button type="button"  id="userInfo2" onclick="AA()" class="site-btn place-btn">AA</button>
						</c:when>
						<c:otherwise>
							<button type="button"  id="userInfo2" onclick="aa()" class="site-btn place-btn">aa</button>
						</c:otherwise>
					</c:choose>
						
					
					</c:forEach>
				</c:when>
				 <c:when test = "${result eq 5}">
				 	<p>**입금대기중인 상태만 취소 가능합니다</p>
				 	
				 	<c:if test="${empty orders}">
						<div class="contact-widget">
		               <div class="cw-item">
		                   <div class="ci-icon">
		                       <i class="ti-cloud"></i>
		                   </div>
		                   <div class="ci-text">
		                       <span>결제번호:</span>
		                       <p><a href="" id="pay">구매내역이 없습니다</a></p>
		                   </div>
		               </div>
		             </div>
					</c:if>
					
					<c:forEach var="orders" items="${orders}">
					<div class="contact-widget">
		               <div class="cw-item">
		                   <div class="ci-icon">
		                       <i class="ti-cloud"></i>
		                   </div>
		                   <div class="ci-text">
		                       <span>결제번호:</span>
		                       <p><a href="javascript:void(0);" id="pay" onclick="orderCart(${orders.payNo})">${orders.payNo}</a></p>
		                   </div>
		               </div>
		             </div>
		             <ul>
						<li>구매일자: ${orders.regDt }</li>
						<li>결제상태: ${orders.state}</li>
					</ul>
					
					<c:choose>
						<c:when test="${orders.state eq '입금대기중'}">
							<button type="button"  id="userInfo" onclick="userCancel(${orders.payNo})" class="site-btn place-btn">결제취소</button>
						</c:when>
						<c:otherwise>
							<button type="button"  id="userInfo2" onclick="aa()" class="site-btn place-btn">aa</button>
						</c:otherwise>
					</c:choose>
						
					
					</c:forEach>
					
					
					
					
				 </c:when>
				 <c:otherwise>
				 </c:otherwise>
			</c:choose>
			
		</div>
		
		
		
		</section>
	
           
            
        </div>
        
         <!-- The Modal -->
	    <div id="myModal" class="modal">
	      <!-- Modal content -->
	      <div class="modal-content">
	                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">카트목록</span></b></span></p>
	                <p style="text-align: center; line-height: 1.5;"><br /></p>
	                <div id="cartList">
	                </div>
	                <p><br /></p>
	            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
	                <span class="pop_bt" style="font-size: 13pt;" >
	                     	닫기
	                </span>
	            </div>
      		</div>
	    </div>
		<!--End Modal-->
		
		<!-- The Modal -->
	    <div id="myModal2" class="modal">
	      <!-- Modal content -->
	      <div class="modal-content">
	                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">주소록 추가</span></b></span></p>
	                <p style="text-align: center; line-height: 1.5;"><br /></p>
	                
	                <form id="frm">
	                <div class="col-lg-12">
                         <label for="town">주소title<span>*</span></label>
                         <input type="text" class="inputTxt p100" name="title" id="title" />
                     </div>
                            
                            
	                <div class="col-lg-12">
                           <label for="zip" style=visibility:hidden;>우편번호</label>
                       </div>
                            <div class="col-lg-6">
                                <label for="zip"></label><br>
                                <input type="text" name="userAddress1" id="detailaddr" />
                                <input type="button" value="우편번호"
												onclick="execDaumPostcode()"
													style="width: 150px; height: 50px; margin-left:2px;" />
                            </div>
                            
                            
                            <div class="col-lg-12">
                                <label for="town">주소<span>*</span></label>
                                <input type="text" class="inputTxt p100" name="userAddress1" id="loginaddr" />
                                
                            </div>
                            <div class="col-lg-12">
                                <label for="town">상세주소<span>*</span></label>
                                <input type="text" class="inputTxt p100"
												name="userAddress1" id="loginaddr1" />
                            </div>
                            <br>
                            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="addAddressButton()">
	                <span class="pop_bt" style="font-size: 13pt;" >
	                     	추가하기
	                </span>
	            </div>
                            
					</form>                            
	                <p><br /></p>
	            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
	                <span class="pop_bt" style="font-size: 13pt;" >
	                     	닫기
	                </span>
	            </div>
      		</div>
	    </div>
		<!--End Modal-->
		
		
		<!-- The Modal -->
	    <div id="myModal3" class="modal">
	      <!-- Modal content -->
	      <div class="modal-content">
	                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">주소록 수정</span></b></span></p>
	                <p style="text-align: center; line-height: 1.5;"><br /></p>
	                
	                <form id="modifyForm">
	                <div class="col-lg-12">
                         <label for="town">주소title<span>*</span></label>
                         <input type="text" class="inputTxt p100" name="title2" id="title2" />
                     </div>
                            
                            
	                <div class="col-lg-12">
                           <label for="zip" style=visibility:hidden;>우편번호</label>
                       </div>
                            <div class="col-lg-6">
                                <label for="zip"></label><br>
                                <input type="text" name="userAddress1" id="detailaddr2" />
                                <input type="button" value="우편번호"
												onclick="execDaumPostcode2()"
													style="width: 150px; height: 50px; margin-left:2px;" />
                            </div>
                            
                            
                            <div class="col-lg-12">
                                <label for="town">주소<span>*</span></label>
                                <input type="text" class="inputTxt p100" name="userAddress2" id="loginaddr2" />
                                
                            </div>
                            <div class="col-lg-12">
                                <label for="town">상세주소<span>*</span></label>
                                <input type="text" class="inputTxt p100"
												name="userAddress2" id="loginaddr12" />
                            </div>
                            <br>
                            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="setAddress()">
	                <span class="pop_bt" style="font-size: 13pt;" >
	                     	수정하기
	                </span>
	            </div>
                            
					</form>                            
	                <p><br /></p>
	            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
	                <span class="pop_bt" style="font-size: 13pt;" >
	                     	닫기
	                </span>
	            </div>
      		</div>
	    </div>
		<!--End Modal-->
		
		
        							
        							
    </section>
    <!-- Contact Section End -->    
    
    
    <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
    <!-- Partner Logo Section End -->

	<script>
	
	
	$(document).ready(function() {
	    
		
		
		
	}); // onLoad End
	
	// ------------------------
	// comm
	// ------------------------


	
	
	

	// 주소 api
	function execDaumPostcode(q) {
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
				document.getElementById('detailaddr').value = data.zonecode;
				document.getElementById("loginaddr").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("loginaddr1").focus();
			}
		}).open({
			q : q
		});
	}
	

	function execDaumPostcode2(q) {
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
				document.getElementById('detailaddr2').value = data.zonecode;
				document.getElementById("loginaddr2").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("loginaddr12").focus();
			}
		}).open({
			q : q
		});
	}
	
	
	
	
	function comma(num){
    var len, point, str; 
    num = num + ""; 
    point = num.length % 3 ;
    len = num.length; 
   
    str = num.substring(0, point); 
    while (point < len) { 
        if (str != "") str += ","; 
        str += num.substring(point, point + 3); 
        point += 3; 
    } 
    return str;
}
	
	
	

	// null check
	function txtFieldCheck() {
	
	    // form안의 모든 text type 조회
	
	    var txtEle = $("#frm input[type=text]");
	
	    for (var i = 0; i < txtEle.length; i++) {
	
	        // console.log($(txtEle[i]).val());
	
	        if ("" == $(txtEle[i]).val() || null == $(txtEle[i]).val()) {
	
	            var ele_id = $(txtEle[i]).attr("id");
	
	            var label_txt = $("label[for='" + ele_id + "']").text();
	
	            console.log("id : " + ele_id + ", label : " + label_txt);
	
	            showAlert(ele_id, label_txt);
	
	            return true;
	
	        }
	
	    }
	
	}
	
	// null check
	function showAlert(ele_id, label_txt) {
	
	    alert(label_txt + " 빈값입니다 ");
	
	    // 해당 id에 focus.
	
	    $("#" + ele_id).focus();
	
	}
	
	
	function txtFieldCheck2() {
		
	    // form안의 모든 text type 조회
	
	    var txtEle = $("#modifyForm input[type=text]");
	
	    for (var i = 0; i < txtEle.length; i++) {
	
	        // console.log($(txtEle[i]).val());
	
	        if ("" == $(txtEle[i]).val() || null == $(txtEle[i]).val()) {
	
	            var ele_id = $(txtEle[i]).attr("id");
	
	            var label_txt = $("label[for='" + ele_id + "']").text();
	
	            console.log("id : " + ele_id + ", label : " + label_txt);
	
	            showAlert(ele_id, label_txt);
	
	            return true;
	
	        }
	
	    }
	
	}
	
	
	// ------------------------
	// function
	// ------------------------
	
	
	
    function orderCart(payNo){
    	 var data = {
    			 payNo : payNo
 			     };
 			   $.ajax({
 			    url : "/orderShow.do",
 			    type : "post",
 			    data : data,
 			    success : function(result){
 					if(result.resultMsg == "success") {
 						var userCarts =result.cartList;
 						
 						var proQty = $('#cartList');
 						proQty.empty();	// append전에 비운다
 						userCarts.forEach(function (item, index, array) {
							proQty.append('<p><img id=cartImg src='+item.bookImg+'></img>'+item.bookName+'<br>'+item.stock+'권</p>');
							proQty.append('<br><br>');
							//proQty.append('<p><img id="cartImg" src='+item.bookImg+'></img></p>');
							//proQty.append('<p>'+item.bookName+'</p>');
							//proQty.append('<p>'+item.stock+'권</p>');
							
 						})
					proQty.append('<p>결제된 금액: '+comma(result.totalPrice)+'</p>');
 					$('body').css("overflow", "hidden"); // 기존 body스크롤 hidden처리	
					$('#myModal').show();
 					}else {
 					}
 			    },
 			    error : function(){
 			     alert("fail");
 			    }
 			   });
    }
	
	

	// 모달 닫기	
	 function close_pop(flag) {
        $('#myModal').hide();
        $('#myModal2').hide();
        $('#myModal3').hide();
        $('body').css("overflow", "scroll");
   }
   
   
   function userCancel(payNo) {
	   
	   var confirm_val = confirm("결제를 정말 취소하시겠습니까???");

		if(confirm_val) {
			var data = {
					payNo : payNo
			     };
			   $.ajax({
			    url : "/userCancel.do",
			    type : "post",
			    data : data,
			    success : function(result){
					if(result.resultMsg == "success") {
						alert("결제가 취소 되었습니다");
						location.reload(true);
					}
			    },
			    error : function(){
			     alert("fail");
			    }
			   });
		}
		
   }
   
   function addAddress() {
	   $('#myModal2').show();
	   
   }
   
   function addAddressButton() {
	   // 빈값 확인
	   var result = txtFieldCheck() == true ? true : false;
	
	   console.log(result);
	   if(!result) {
		   
		   var title = $('#title').val();
		   var detailadr = $('#detailaddr').val();
		   var address = $('#loginaddr').val();
		   var address2 = $('#loginaddr1').val();
		   
		   var data = {
				   title : title
				   , detailadr : detailadr
				   , address : address
				   , address2 : address2
		     };
		   $.ajax({
		    url : "/addAddress.do",
		    type : "post",
		    data : data,
		    success : function(result){
				if(result.resultMsg == "success") {
					alert("주소가 등록이 되었습니다");
					location.reload(true);
				}
		    },
		    error : function(){
		     alert("fail");
		    }
		   });
		   
	   }
			   
	 
   }

   

	function addressModify() {
		// getAddress
		getAddress();
		$('#myModal3').show();
	}	



	function addressModify2(detail, title) {
	}
	
	
	// 기본배송지 수정
	function setAddress() {
		
		var result = txtFieldCheck2() == true ? true : false;
		
		   if(!result) {
			   
			   var title = $('#title2').val();
			   var detailadr = $('#detailaddr2').val();
			   var address = $('#loginaddr2').val();
			   var address2 = $('#loginaddr12').val();
			   
			   var data = {
					   title : title
					   , detailadr : detailadr
					   , address : address
					   , address2 : address2
			     };
			   $.ajax({
			    url : "/modifyAddress.do",
			    type : "post",
			    data : data,
			    success : function(result){
					if(result.resultMsg == "success") {
						alert("주소가 수정되었습니다");
						location.reload(true);
					}
			    },
			    error : function(){
			     alert("fail");
			    }
			   });
			   
			   
		   }
	}

	function delAddress2(detail, title) {

		 var confirm_val = confirm("주소록을 정말로 삭제하시겠습니까???");

		if(confirm_val) {
			var data = {
					   detail : detail
					   , title : title
			     };
			   $.ajax({
			    url : "/delAddress.do",
			    type : "post",
			    data : data,
			    success : function(result){
					if(result.resultMsg == "success") {
						alert("삭제되었습니다");
						location.reload(true);
					}else {
						alert("최초 가입한 주소는 삭제할 수 없습니다");
					}
			    },
			    error : function(){
			     alert("fail");
			    }
			   });
		}
	}
   

	function chooseDefault(detail, title) {
		var data = {
				   detail : detail
				   , title : title
		     };
		   $.ajax({
		    url : "/defaultAddress.do",
		    type : "post",
		    data : data,
		    success : function(result){
				if(result.resultMsg == "success") {
					alert("기본 주소로 설정이 되었습니다");
					location.reload(true);
				}
		    },
		    error : function(){
		     alert("fail");
		    }
		   });
		   
	}

	// 기본배송지 정보를 가져온다 for 수정하기 전에 사용자에게 보여주기 위해
	function getAddress() {
		var loginID = $('#loginID').val();
		var data = {
				loginID : loginID
		     };
		   $.ajax({
		    url : "/getAddress.do",
		    type : "post",
		    data : data,
		    success : function(result){
				if(result.resultMsg == "success") {
					var userAddress = result.userAddress;
					$('#title2').val(userAddress.addressTitle);
					$('#detailaddr2').val(userAddress.address1);
					$('#loginaddr2').val(userAddress.address2);
					$('#loginaddr12').val(userAddress.address3);
				}
		    },
		    error : function(){
		     alert("fail");
		    }
		   });
	}
</script>


</html>
