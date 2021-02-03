<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    


	
	
	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
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
                                <input type="text" name="userName">
                            </div>
                            <div class="col-lg-6">
                                <label for="email">Email Address<span>*</span></label>
                                <input type="text" name="userEmail" id="userEamil">
                            </div>
                            <div class="col-lg-6">
                                <label for="phone">Phone<span>*</span></label>
                                <input type="text" name="userPhone" id="userPhone">
                            </div>
                            <div class="col-lg-12">
                                <label for="zip" style=visibility:hidden;>우편번호</label>
                            </div>
                            <div class="col-lg-6">
                                <label for="zip"></label><br>
                                <input type="text" name="userAddress1" id="detailaddr" />
                            </div>
                            
                            <div class="col-lg-6">
                                <label for="zip"></label>
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
                            
                            <div class="col-lg-12">
                                <div class="create-item">
                                	<!--
                                    <label for="acc-create">
                                        Create an account?
                                        <input type="checkbox" id="acc-create">
                                        <span class="checkmark"></span>
                                    </label>
                                      -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                    	<!--  
                        <div class="checkout-content">
                            <input type="text" placeholder="Enter Your Coupon Code">
                        </div>
                        -->
                        <div class="place-order">
                            <h4>Your Order</h4>
                            <div class="order-total">
                                <ul class="order-table">
                                    <li>Product <span>Total</span></li>
	                                    <c:forEach var="cartList" items="${cartList}" >
	                                    	<li class="fw-normal">${cartList.bookName} x ${cartList.stock } <span><fmt:formatNumber pattern="###,###,###" value="${cartList.stock * cartList.price}" />원</span></li>
	                                    </c:forEach>
                                    <!-- <li class="fw-normal">Subtotal <span>$240.00</span></li> -->
                                    <!--bookName, price, stock  -->
                                    <li class="total-price">Total <span><fmt:formatNumber pattern="###,###,###" value="${totalPrice}" />원</span>
                                    <input type="hidden" value="${totalPrice}" name="totalPrice">
                                    <input type="hidden" value="${cartNos}" name="cartNos">
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
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </section>
    
    
    
    <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
    <!-- Partner Logo Section End -->

	<script>
	
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
	
	
	
	
	$(document).ready(function() {


		
	 
		
	    
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
	

	
	// ------------------------
	// function
	// ------------------------

	
	// 정규식
	var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;//이메일 정규식
	var regExp = /^\d{3}-\d{3,4}-\d{4}$/;

	
	function goPayment() {
		

		if(!emailRule.test($("input[id='userEamil']").val())) {            
					alert("이메일 양식을 확인해주세요");
		            return false;
		}
		
		if(!regExp.test($("input[id='userPhone']").val())) {            
			alert("전화번호 양식 확인해주세요");
            return false;
}
		
		
		
		
		var form = document.form;
		form.method="post";
	    form.action="payment.do";
	    form.submit();
	    
	    
	}
	</script>


</html>
