<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    


	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
	<style>
		a:link{ color:black;
		}
		
		#payNo {
		 padding-top: 80px;
		}
	</style>
    <!-- Breadcrumb Section Begin -->
     <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text product-more">
                        <a href="/index.do"><i class="fa fa-home"></i> Home</a>
                        <a href="./shop.html">Shop</a>
                        <span>ADMIN</span>
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
                                <ul class="btn-group pagination">
								    <c:if test="${pageMaker.prev }">
								    <li>
								        <a class="page-link" href='<c:url value="/adminInfo.do?page=${pageMaker.startPage-1 }"/>'>Previous</a>
								    </li>
								    </c:if>
								    
								    <!--
								    when, search일 때 페이징 적용 위함
								    when, active 페이징 설정하기 위함
								      -->
								    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
										<c:choose>
											<c:when test="${not empty param.searchKey}"></c:when>
											<c:when test="${param.page eq pageNum }"> 
												<li class="page-item active "><a class="page-link" href='<c:url value="/adminInfo.do?page=${pageNum }"/>'>${pageNum }</a></li>
											</c:when>
											<c:otherwise>
								        			<li class="page-item "><a class="page-link" href='<c:url value="/adminInfo.do?page=${pageNum }"/>'>${pageNum }</a></li>											
											</c:otherwise>
										</c:choose>
								    </c:forEach>
								    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
								    <li class="page-item">
								        <a class="page-link" href='<c:url value="/adminInfo.do?page=${pageMaker.endPage+1 }"/>'>Next</a>
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
                            <h4>배송 or 쿠폰</h4>
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

	function goSearch () {
		var key = $('#searchKey').val();
		if(!key) {
			alert("검색어를 입력해주세요");
		}else {
			location.href='/adminInfo.do?searchKey=' + ""+key; 
		}
	}
	
	
	function userDetail(loginID) {
		//alert(loginID);

		$('#userId').html(loginID);
		var data = {
				loginID : loginID
			     };
			   
			   $.ajax({
			    url : "/userDetail.do",
			    type : "post",
			    data : data,
			    success : function(result){
					if(result.resultMsg == "success") {
						var userOrders =result.userOrders;
						
						userOrders.forEach(function (item, index, array) {
							//user
							var State = "";
							if(item.userState=="0") {
								State="입금완료";
							}else if (item.userState=="1") {
								State="배송중";
							}
							var proQty = $('.user-orders');
							/* proQty.append('<li id="payNo">'+item.payNo+'</li>'); */
							proQty.append('<li id="payNo">결제번호'+""+"<span>"+item.payNo+"</span>"+'</li>');
							proQty.append('<li id="payState" >결제상태'+""+"<span>"+State+"</span>"+'</li>');
							if(State == "입금완료") {
								proQty.append('<li id="payNo">button'+""+"<span>"+item.payNo+"</span>"+'</li>');
							}
							})
					}
			    },
			    error : function(){
			     alert("fail");
			    }
			   });
	}

	
	</script>


</html>
