<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



	
	
	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
	<style>


input[type="checkbox"] {
    display:none;
}

input[type="checkbox"] + label {
    /* color:#f2f2f2; */
}

input[type="checkbox"] + label span {
    display:inline-block;
    width:19px;
    height:19px;
    margin:-2px 10px 0 0;
    vertical-align:middle;
    background:url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/210284/check_radio_sheet.png) left top no-repeat;
    cursor:pointer;
}

input[type="checkbox"]:checked + label span {
    background:url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/210284/check_radio_sheet.png) -19px top no-repeat;
}

input[type="radio"] {
    display:none;
}

input[type="radio"] + label {
    color:#f2f2f2;
    font-family:Arial, sans-serif;
}

input[type="radio"] + label span {
    display:inline-block;
    width:19px;
    height:19px;
    margin:-2px 10px 0 0;
    vertical-align:middle;
    background:url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/210284/check_radio_sheet.png) -38px top no-repeat;
    cursor:pointer;
}

input[type="radio"]:checked + label span {
    background:url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/210284/check_radio_sheet.png) -57px top no-repeat;
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
                        <span>Payment</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <c:choose>
    <c:when test="${empty member}">
    
    
    	<script>
    		alert("로그인 먼저 해주세요");
    	</script>

    </c:when>
    <c:otherwise>
    
    
    <section class="checkout-section spad">
        <div class="container">
            <form class="checkout-form" name="form">
                <div class="row">
                    <div class="col-lg-6">
                    
                    
                    	<!--
                        <div class="checkout-content">
                            <a href="#" class="content-btn">Click Here To Login</a>
                        </div>
                          -->
                        <h4>Biiling Details</h4>
                        <div class="row">
                            <div class="col-lg-12">
                                <label for="fir">이름<span>*</span></label>
                                <input type="text" name="userName" value="${userInfo.name}" readonly>
                            </div>
                            <div class="col-lg-6">
                                <label for="email">Email Address<span>*</span></label>
                                <input type="text" name="userEmail" id="userEamil" value="${userInfo.mail}" readonly>
                            </div>
                            <div class="col-lg-6">
                                <label for="phone">Phone<span>*</span></label>
                                <input type="text" name="userPhone" id="userPhone" value="${userInfo.phone1}-${userInfo.phone2}-${userInfo.phone3}" readonly>
                            </div>
                            <div class="col-lg-12">
                                <label for="zip" >우편번호</label>
                            </div>
                            <div class="col-lg-6">
                                <label for="zip"></label><br>
                                <input type="text" name="userAddress1" id="detailaddr" value="${userAddress.address1}" readonly/>
                            </div>
                            
                            <div class="col-lg-6">
                                <label for="zip"></label>
                                <input type="button" value="우편번호"
												onclick="execDaumPostcode()"
													style="width: 150px; height: 50px; margin-left:2px; visibility:hidden;" />
                            </div>
                            
                            <div class="col-lg-12">
                                <label for="town">주소<span>*</span></label>
                                <input type="text" class="inputTxt p100" name="userAddress1" id="loginaddr" value="${userAddress.address2}" readonly/>
                                
                            </div>
                            <div class="col-lg-12">
                                <label for="town">상세주소<span>*</span></label>
                                <input type="text" class="inputTxt p100"
												name="userAddress1" id="loginaddr1" value="${userAddress.address3}" readonly/>
                            </div>
                            
                            <div class="col-lg-12">
                                <%-- <label for="town">마일리지<span>:&nbsp;</span><span id="applyMileage">${userInfo.mileage}</span></label> --%>
                                <label for="town">마일리지<span>:&nbsp;</span><span id="applyMileage"><fmt:formatNumber pattern="###,###,###" value="${userInfo.mileage}"/></span></label>
                                <input type="text" class="inputTxt p100"
												name="" id="userMileage"  placeholder="사용하실 마일리지를 입력해주세요"/>
												<button type="button"  onclick="applyMileage()" class="site-btn place-btn">마일리지 적용</button>
                                    			<button type="button"  onclick="applyCancel()" class="site-btn place-btn">취소</button>
                                    
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="checkout-content">
                            <input type="text" placeholder="Choose your coupon" disabled>
                             
                             <!-- getCoupon  -->
                             <c:forEach var="getCoupon" items="${getCoupon}" varStatus="status" >
                             <input type="checkbox" id="coupon${getCoupon.couponNo}" name="cc" value="${getCoupon.couponNo}"/>
							  <label for="coupon${getCoupon.couponNo}"><span></span>${getCoupon.couponName}</label>
							  &nbsp;&nbsp;	
                             </c:forEach>
                              
							  <!-- <p> -->
							  <!-- <input type="checkbox" id="c2" name="cc" />
							  <label for="c2"><span></span>Check Box 2</label> -->
							  <!-- <p> -->
							  <br/>
    						 
                        </div>
                        
                        <div class="place-order">
                            <h4>Your Order</h4>
                            <div class="order-total">
                                <ul class="order-table">
                                    <li>Product <span>Total</span></li>
                                    	<c:set var="mileage" value="0" />
                                    	<c:set var="mileage2" value="0" />
	                                    <c:forEach var="cartList" items="${cartList}" >
	                                    	<li class="fw-normal">
	                                    	<c:if test="${fn:length(cartList.bookName) > 30}">
											    <c:out value="${fn:substring(cartList.bookName,0,30)}" />...                    
											</c:if>
											<c:if test="${fn:length(cartList.bookName) <= 30}">
											    ${cartList.bookName}
											 </c:if>
	                                    	x ${cartList.stock } 
	                                    	<span><fmt:formatNumber pattern="###,###,###" value="${cartList.stock * cartList.price}" />원</span></li>
	                                    	<c:set var="mileage" value="${cartList.mileage * cartList.stock}"/>
	                                    	<c:set var="mileage2" value="${mileage+ mileage2}"/>
	                                    </c:forEach>
                                    <!-- <li class="fw-normal">Subtotal <span>$240.00</span></li> -->
                                    <!--bookName, price, stock  -->
                                    <li class="total-price">Total <span id="paymentPrice">원</span>
                                    <li class="total-price">총 할인금액 <span id="dc">원</span>
                                    <li class="total-price">적립될 마일리지<span id="mileage"><c:out value="${mileage2}"/>원</span>
                                    <input type="hidden" value="${totalPrice}" name="totalPrice" id="totalPrice">
                                    <input type="hidden" value="${cartNos}" name="cartNos">
                                    <input type="hidden" id="totalMileage" value="${userInfo.mileage}">
                                    <input type="hidden" id="reset" value="">
                                    <input type="hidden" id="paymentSw" value="" name="paymentSw">
                                    <input type="hidden" id="balanceMileage" value="${userInfo.mileage}" name="mileage">
                                    <input type="hidden" id="earnedMileage" value="${mileage2}" name="earnedMileage">
                                    </li>
                                </ul>
                                <!--  
                                <div class="payment-check">
                                    <div class="pc-item">
                                        <label for="pc-check">
                                            Cheque Payment
                                            <input type="checkbox" id="pc-check">
                                            <span class="checkmark"></span>
                                        </label>
                                    </div>
                                    <div class="pc-item">
                                        <label for="pc-paypal">
                                            Paypal
                                            <input type="checkbox" id="pc-paypal">
                                            <span class="checkmark"></span>
                                        </label>
                                    </div>
                                </div>
                                -->
                                <div class="order-btn">
                                	<button type="button"  onclick="goPayment()" class="site-btn place-btn">Place Order</button>
                                	<button type="button"  onclick="goCancel()" class="site-btn place-btn">cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" value="${userInfo.loginID }" name="loginID" >
                <input type="hidden" value="" name="couponPrice" id="couponPrice">
                <input type="hidden" value="" name="couponNos" id="couponNos">
                <input type="hidden" value="${mileage2}" name="mileage2" id="mileage">
                <input type="hidden" value="" name="useMileage" id="useMileage">
            </form>
        </div>
    </section>
    
    
    </c:otherwise>
</c:choose>
    
    <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
    <!-- Partner Logo Section End -->

	<script>
	
	var sw=0;
	var result=0;
	
	
	
	$(document).ready(function() {
		
		$('#paymentPrice').html(comma($('#totalPrice').val())+"원");
		
		
		var oldTotal2 = $('#totalPrice').val();
		var oldTotal3 = 0;
        var TotalRem = 0;
        var dcPrc = 0
        var dcPrc2 = 0
		// check box 동적
		$("body").on("change", "[id^=coupon]", function(event) {
	        //console.log(this.id);		coupon2
	        
	        
	        // 체크박스 3개 이상 선택 x
	        cnt=0
	        $('input:checkbox[name="cc"]').each(function() {
	        	if(this.checked){
	        		cnt++;
	        		if(cnt >= 3) {
	        			alert("쿠폰은 최대 2개까지 사용할 수 있습니다");
	        			$("input:checkbox[id^='coupon']").prop("checked", false); 
	        		}
	        	}
	        });	
	        
	        
	        
	        if($("#"+this.id).is(":checked")){
	            // 체크박스 선택
	            oldTotal = fn($('#paymentPrice').html());
	            var couponNo = fn(this.id); // 함수써서 숫자만 추출
	            var data = {
	            		couponNo : couponNo
					     };
					   $.ajax({
					    url : "/couponOne.do",
					    type : "post",
					    data : data,
					    success : function(result){
							if(result.resultMsg == "success") {
								var userCoupon =result.userCoupon;
								if(userCoupon.couponRate == 0){
									// price할인 일경우
									var dcPrice = userCoupon.couponPrice;
				                	oldTotal = fn($('#paymentPrice').html());
				                	TotalRem = oldTotal-dcPrice;
				                	oldTotal3 = fn($('#paymentPrice').html());
				                	$('#paymentPrice').html(comma(TotalRem)+"원");
				                	
				                	// 화면에 할인금액 표시
									var dcshow = 0
									var dcValue = 0
									var dcValue2 = 0
									dcValue = parseInt((fn($('#dc').html())));
									dcValue = dcValue ? dcValue : 0;
									dcValue2 = parseInt(dcPrice);
									$('#dc').html(comma(dcValue+dcValue2)+"원");
									
									dcPrc2 =dcPrice;
									
								}else {
									// dc할인 일 겨우
									var dcRate = userCoupon.couponRate;
				                	oldTotal = fn($('#paymentPrice').html());
				                	TotalRem = oldTotal-oldTotal * dcRate / 100;
				                	oldTotal3 = fn($('#paymentPrice').html());
									$('#paymentPrice').html(comma(TotalRem)+"원");
									
									// 화면에 할인금액 표시
									var dcshow = 0
									var dcValue = 0
									var dcValue2 = 0
									dcValue = parseInt((fn($('#dc').html())));
									dcValue = dcValue ? dcValue : 0;
									dcValue2 = parseInt(oldTotal * dcRate / 100);
									$('#dc').html(comma(dcValue+dcValue2)+"원");
									
									dcPrc = oldTotal * dcRate / 100;
								}
							}
					    },
					    error : function(){
					     alert("fail");
					    }
					   });
	        }else{
	            // "체크박스 체크 해제!"
	            var couponNo = fn(this.id); // 함수써서 숫자만 추출
	            
	            sw=0;
	            
	            
	            $('input:checkbox[name="cc"]').each(function() {
	                if(this.checked){//체크박스 해제 했을 때 남아있는 체크박스에서 체크된 애들
	                	                	
	                	var couponNo = fn(this.value); // 함수써서 숫자만 추출
	    	            var data = {
	    	            		couponNo : couponNo
	    					     };
	    					   $.ajax({
	    					    url : "/couponOne.do",
	    					    type : "post",
	    					    data : data,
	    					    success : function(result){
	    							if(result.resultMsg == "success") {
	    								var userCoupon =result.userCoupon;
	    								if(userCoupon.couponRate == 0){
	    									// price할인 일경우
	    									var dcPrice = userCoupon.couponPrice;
	    									oldTotal = oldTotal2;
	    				                	TotalRem = oldTotal-dcPrice;
	    				                	$('#paymentPrice').html(comma(TotalRem)+"원");
	    				                	
	    				                	// 화면에 할인금액 표시
	    									var dcValue = parseInt((fn($('#dc').html())));
	    									var dcValue2 = parseInt((fn($('#userMileage').val())));
	    									dcValue = dcValue ? dcValue : 0;
	    									dcValue2 = dcValue2 ? dcValue2 : 0;	
	    									$('#dc').html(comma(dcValue-dcPrc+dcValue2)+"원");
	    									
	    								}else {
	    									// dc할인 일 겨우
	    									
	    									
	    									// 화면에 할인금액 표시
	    									var dcValue = parseInt((fn($('#dc').html())));
	    									var dcValue2 = parseInt((fn($('#userMileage').val())));
	    									dcValue = dcValue ? dcValue : 0;
	    									dcValue2 = dcValue2 ? dcValue2 : 0;	
	    									$('#dc').html(comma(dcValue-dcPrc2+dcValue2)+"원");
	    									
	    									
	    									var dcRate = userCoupon.couponRate;
	    									oldTotal = oldTotal2;
	    									TotalRem = oldTotal-oldTotal * dcRate / 100;
	    									$('#paymentPrice').html(comma(TotalRem+dcValue2)+"원");
	    									
	    									
	    								}
	    							}
	    					    },
	    					    error : function(){
	    					     alert("fail");
	    					    }
	    					   });
	                	sw=1;
	                }
	           });
				if(sw != 1) {
					// 체크박스 해제가 되었을 떄 !!
					
					// 화면에 할인금액 표시
					var dcValue = parseInt((fn($('#dc').html())));
					var dcValue2 = parseInt((fn($('#userMileage').val())));
					dcValue = dcValue ? dcValue : 0;
					dcValue2 = dcValue2 ? dcValue2 : 0;	
					$('#dc').html(comma(dcValue-dcValue+dcValue2)+"원");
					$('#paymentPrice').html(comma(parseInt(oldTotal2)-dcValue2)+"원");
					
					
					
				}else {
					var dcValue2 = parseInt((fn($('#userMileage').val())));
					dcValue2 = dcValue2 ? dcValue2 : 0;
					$('#paymentPrice').html(comma(oldTotal3-dcValue2)+"원");
				}
	        }
	    });
	 
		
		
		// 숫자만 
		var regExp = /[^0-9]/gi;    
		$("#userMileage").keyup(function(){ numCheck($(this)); });

		function numCheck(selector) {
		    var tempVal = selector.val();
		    selector.val(tempVal.replace(regExp, ""));
		}
		
		
		$("#userMileage").keypress(function (e) {
	        if (e.which == 13){
	        	applyMileage();      
	        }
	    });
		
		
		
	    
	}); // onLoad End
	
	// ------------------------
	// comm
	// ------------------------
	function removeComma(str)
	{
		n = parseInt(str.replace(/,/g,""));
		return n;
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

	// string에서 숫자만 추출
	function fn(str){
	    var res;
	    res = str.replace(/[^0-9]/g,"");
	    return res;
	}
	
	

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
	

	
	
	 
	 
	
	// ------------------------
	// function
	// ------------------------

	
	// 정규식
	var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;//이메일 정규식
	var regExp = /^\d{3}-\d{3,4}-\d{4}$/;

	
	function goPayment() {
		var confirm_val = confirm("결제금액을 확인하셨나요??");

		if(confirm_val) {
			if(!emailRule.test($("input[id='userEamil']").val())) {            
			alert("이메일 양식을 확인해주세요");
            return false;
			}
			
			if(!regExp.test($("input[id='userPhone']").val())) {            
				alert("전화번호 양식 확인해주세요");
		        return false;
			}
			
			// 현재값
			nowTotal = fn($('#paymentPrice').html());
			// 최초값
			oldTotal = $('#totalPrice').val();
			
			
			// couponPrice
			if(oldTotal - nowTotal == 0) {							// mileage x, coupon x
				$('#couponPrice').val(0);
				$('#paymentSw').val(1);
			}else if($('#paymentSw').val()==2){						
				// mileage o, coupon o
				
				// 쿠폰 사용 check
				var isSeasonChk=false;
				$('input:checkbox[name="cc"]').each(function() {
		        	if(this.checked){
		        		isSeasonChk=true;
		        	}
		        });
				
				if(isSeasonChk) {
					var mileage = parseInt($('#useMileage').val());
					$('#couponPrice').val(oldTotal - nowTotal - mileage);
					$('#paymentSw').val(4);
				}else {
					// mileage o, coupon x
					$('#couponPrice').val(0);
				}
			}else if(cnt !=0){
				$('#couponPrice').val(oldTotal - nowTotal);
				$('#paymentSw').val(3);
			}
			
			
			// couponNo
			let couponNos="";
			var couponNosArr = new Array();
				
			$('input:checkbox[name="cc"]').each(function() {
		        	if(this.checked){
		        		var couponNo = fn(this.id); // 함수써서 숫자만 추출
		        		couponNos+=couponNo+",";
		        	}
		        });	
			$('#couponNos').val(couponNos.slice(0,-1));
		
			// post
			$('#totalPrice').val(nowTotal);
			var form = document.form;
			form.method="post";
		    form.action="payment.do";
	    	form.submit();	
		    
				    
			}else {
			}
	}
	
	function goCancel() {
		location.href="/cartList.do";
	}
	
	/* 
	function mileageCheck(mileage) {
		var inputMileage = parseInt(mileage);
		var totalMileage = parseInt($('#totalMileage').val());
		
		if(totalMileage < inputMileage) {
			alert("현재 마일리지보다 큽니다");
			$('#userMileage').val(0);
		}else {
			// total에서 깎아야함
			var confirm_val = confirm("마일리지"+inputMileage+"사용하시겠습니까??");
			if(confirm_val) {
				var dbMileage;
				reset();
				oldTotal = fn($('#paymentPrice').html());
				readTotal = oldTotal - inputMileage;
				$('#paymentPrice').html(comma(readTotal)+"원");
				$('#totalMileage').val(inputMileage);
				dbMileage=(fn($('#applyMileage').html()));
				$('#applyMileage').html(dbMileage-inputMileage);
				$('#reset').val(1);
				$('#paymentSw').val(2);
			}else {
			}
			
		}
		
	}
	*/
	function reset(){
		if($('#reset').val()==1) {
			location.reload(true);	
		}
	}
	function applyMileage(){
		
		var inputMileage = $('#userMileage').val();
		var totalMileage = parseInt($('#totalMileage').val());
		if(totalMileage < inputMileage) {
			alert("현재 마일리지보다 큽니다");
			$('#userMileage').val(0);
		}else {
			var confirm_val = confirm("마일리지"+inputMileage+"사용하시겠습니까??");
			if(confirm_val) {
				reset();
				var dbMileage;
				oldTotal = fn($('#paymentPrice').html());
				readTotal = oldTotal - inputMileage;
				$('#paymentPrice').html(comma(readTotal)+"원");
				$('#useMileage').val(inputMileage);
				dbMileage=(fn($('#applyMileage').html()));
				$('#applyMileage').html(comma(dbMileage-inputMileage));
				
				// 화면에 할인금액 표시
				var dcshow = 0
				var dcValue = 0
				var dcValue2 = 0
				dcValue = parseInt((fn($('#dc').html())));
				dcValue = dcValue ? dcValue : 0;
				dcValue2 = parseInt(inputMileage);
				$('#dc').html(comma(dcValue+dcValue2)+"원");
				
				$('#balanceMileage').val(dbMileage-inputMileage);
				$('#reset').val(1);
				$('#paymentSw').val(2);
			}else {
			}
		}
		
	}
	
	
	
	
	function applyCancel(){
		location.reload(true);
	}
	
	function checkboxCheck(){
	}
	</script>


</html>
