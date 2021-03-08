<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

	<jsp:include page="/WEB-INF/view/common/adminHeader.jsp"></jsp:include>

	<style>
	
		  
		a:link{ 
		color:black;
		}
		
		#pay{
		  	color: blue;
		}
		
		#couponName {
		 padding-top: 80px;
		}
		#buttonPro{
			border-radius:10px;
			width: 60px;
			height: 30px;
		}
		#cartImg{
			width: 100px;
			height: 150px;
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
    <!-- Breadcrumb Section Begin -->
     <div class="breacrumb-section">
        <div class="container">
        
        	<!-- aside -->
            <jsp:include page="/WEB-INF/view/common/aside.jsp"></jsp:include>
            
            
        </div>
    </div>
    
    <c:choose>
    <c:when test="${empty member}">
    
    	<script>
    		alert("로그인 먼저 해주세요");
    		location.href="/login.me";
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
                            <input type="text" placeholder="Enter Your Coupon Code">
                        </div>
                        -->
                        <h4>검색</h4>
                        <div class="col-lg-12">
                                <label for="fir"></label>
                                <input type="text" name="searchKey" id="searchKey">
                                    <button type="button"  onclick="goSearch()" class="site-btn place-btn" style="display: block; margin: 0 auto;">검색</button>
                        </div>
                        <div class="col-lg-12">
                                <label for="fir"></label>
                                <input type="text" name="userName" style=visibility:hidden;>
                        </div>
                        <div class="place-order">
                            <h4>유저정보</h4>
                            <div class="order-total">
                                <ul class="order-table">
                                <c:forEach items="${list }" var="list">
                                	<li  style="text-transform: none;"><a id="aHover" href="javascript:void(0);" onclick="userDetail('${list.loginID}')">${list.loginID }</a></li><!--none, 대문자로 변환이 설정 되어있는거 해지  -->
                                </c:forEach>
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
                                <ul class="btn-group pagination justify-content-center" id="paging-ul">
								    <c:if test="${pageMaker.prev }">
								    <li id="paging-li">
								        <a class="page-link" href='<c:url value="/adminCoupon.do?page=${pageMaker.startPage-1 }"/>'>Previous</a>
								    </li>
								    </c:if>
								    <!--
								    when, search일 때 페이징 적용 하지 않기 위함
								    when, active 페이징 설정하기 위함
								      -->
								    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
										<c:choose>
											<c:when test="${not empty param.searchKey}"></c:when>
											<c:when test="${param.page eq pageNum }"> 
												<li id="paging-li" class="page-item active "><a class="page-link" href='<c:url value="/adminCoupon.do?page=${pageNum }"/>'>${pageNum }</a></li>
											</c:when>
											<c:otherwise>
								        			<li id="paging-li" class="page-item "><a class="page-link" href='<c:url value="/adminCoupon.do?page=${pageNum }"/>'>${pageNum }</a></li>											
											</c:otherwise>
										</c:choose>
								    </c:forEach>
								    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
								    <li id="paging-li" class="page-item">
								        <a class="page-link" href='<c:url value="/adminCoupon.do?page=${pageMaker.endPage+1 }"/>'>Next</a>
								    </li>
								    </c:if>
								</ul>


									<!--                                
								 	<div style="display: block; text-align: center;">		
										<c:if test="${paging.startPage != 1 }">
											<a href="/adminInfo.do?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
										</c:if>
										<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
											<c:choose>
												<c:when test="${p == paging.nowPage }">
													<b>${p }</b>
												</c:when>
												<c:when test="${p != paging.nowPage }">
													<a href="/adminInfo.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
												</c:when>
											</c:choose>
										</c:forEach>
										<c:if test="${paging.endPage != paging.lastPage}">
											<a href="/adminInfo.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
										</c:if>
									</div>
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
                            <h4>쿠폰</h4>
                            <div class="order-total">
                                <ul class="order-table">
                                    <li class="user-orders" id="userId">아이디<span>정보</span></li>
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
                                <!--
                                <div class="order-btn">
                                    <button type="button"  onclick="goPayment()" class="site-btn place-btn">Place Order</button>
                                </div>
                                  -->
                                  
                                  <input type="hidden" id="goCoupon">
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
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </section>
    
    </c:otherwise>
    </c:choose>
    
    <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
    <!-- Partner Logo Section End -->

	<script>
	
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
	

	// 모달 닫기	
	 function close_pop(flag) {
        $('#myModal').hide();         
        $('body').css("overflow", "scroll");
        let elm = document.getElementById('paging-ul');
        elm.style.visibility = "visible";
   };

	
   
   function pad(d) {
	    return (d < 10) ? '0' + d.toString() : d.toString();
	}

   
   
	// ------------------------
	// function
	// ------------------------

	function delivery(payNo) {
		console.log(payNo);
		var result = confirm("입금을 확인하셨습니까??");
		if(result) {
			var data = {
					payNo : payNo
				     };
				   
				   $.ajax({
				    url : "/goDelivery.do",
				    type : "post",
				    data : data,
				    success : function(result){
						if(result.resultMsg == "success") {
							
							location.reload(true);	// 삭제 후 초기화
						}
				    },
				    error : function(){
				     alert("fail");
				    }
				   });
		}
	}
	
	function goSearch () {
		var key = $('#searchKey').val();
		if(!key) {
			alert("검색어를 입력해주세요");
		}else {
			location.href='/adminInfo.do?searchKey=' + ""+key; 
		}
	}
	
	
	function userDetail(loginID) {
		$('#userId').html(loginID);
		var data = {
				loginID : loginID
			     };
			   
			   $.ajax({
			    url : "/showCoupon.do",
			    type : "post",
			    data : data,
			    success : function(result){
					if(result.resultMsg == "success") {
						var userOrders =result.showCoupon;
						$('#goCoupon').val(loginID);
						userOrders.forEach(function (item, index, array) {
							//user
							var proQty = $('.user-orders');
							proQty.append('<li id="couponName">쿠폰 이름'+""+"<span>"+item.couponName+"</span>"+'</li>');							
							if(item.couponPrice == 0) {
								proQty.append('<li id="">할인율'+""+"<span>"+item.couponRate+"%</span>"+'</li>');
							}else{
								proQty.append('<li id="">할인금액'+""+"<span>"+comma(item.couponPrice)+"원</span>"+'</li>');
							}
							proQty.append('<li id="adminButton">쿠폰 지급'+""+"<span><input type='button' id='buttonPro' value='DO' onclick='payCoupon("+item.couponNo+")'/>"+"</span>"+'</li>');
							
							})
					}
			    },
			    error : function(){
			     alert("fail");
			    }
			   });
	}
	

	function payCoupon(couponNo) {
		var loginID = $('#goCoupon').val();
		
		var result = confirm(loginID+"님에게 쿠폰을 지급하시겠습니까??");
		if(result) {
			
			couponNo = pad(couponNo);
			
			var data = {
					loginID : loginID
					, couponNo : couponNo
				     };
				   
				   $.ajax({
				    url : "/payCoupon.do",
				    type : "post",
				    data : data,
				    success : function(result){
						if(result.resultMsg == "success") {
							alert("쿠폰을 지급했습니다");							
							location.reload(true);	
						}else {
							alert("사용자가 이미 쿠폰을 지급 받았습니다");
						}
				    },
				    error : function(){
				     alert("fail");
				    }
				   });
		}
	}
	
	</script>
</html>
