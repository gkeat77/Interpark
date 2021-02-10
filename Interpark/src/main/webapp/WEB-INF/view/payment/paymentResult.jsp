<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
    <!-- Breadcrumb Section Begin -->
     <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text product-more">
                        <a href="/index.do"><i class="fa fa-home"></i> Home</a>
                        <a href="./shop.html">Shop</a>
                        <span>RESULT</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
	<body oncontextmenu="return false"><!-- 우클릭 새로고침 방지  -->
	<input type="hidden" id="uploadState" name = "uploadState" value="" />
	<!-- Contact Section Begin -->
    <section class="contact-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="contact-title">
                        <h4>결제를 진행해주시기 바랍니다 </h4>
                        <p>아래 정보를 확인해주시기 바랍니다.</p>
                    </div>
                    <div class="contact-widget">
                        <div class="cw-item">
                            <div class="ci-icon">
                                <i class="ti-cloud"></i>
                            </div>
                            <div class="ci-text">
                                <span>결제번호:</span>
                                <p>${userInfo.payNo}</p>
                            </div>
                        </div>
                        
                        
                        <div class="cw-item">
                            <div class="ci-icon">
                                <i class="ti-direction"></i>
                            </div>
                            <div class="ci-text">
                                <span>결제금액:</span>
                                <p><fmt:formatNumber pattern="###,###,###" value="${userInfo.totalPrice}" /></p>
                            </div>
                        </div>
                        
                        
                        <div class="cw-item">
                            <div class="ci-icon">
                                <i class="ti-money"></i>
                            </div>
                            <div class="ci-text">
                                <span>계좌번호:</span>
                                <p>112-223-1112452233(우리은행)</p>
                            </div>
                        </div>
                        
                        <div class="cw-item">
                            <div class="ci-icon">
                                <i class="ti-location-pin"></i>
                            </div>
                            <div class="ci-text">
                                <span>Address:</span>
                                <p>${userInfo.userAddress1 }</p>
                            </div>
                        </div>
                        
                        <div class="cw-item">
                            <div class="ci-icon">
                                <i class="ti-mobile"></i>
                            </div>
                            <div class="ci-text">
                                <span>Phone:</span>
                                <p>${userInfo.userPhone }</p>
                            </div>
                        </div>
                        <div class="cw-item">
                            <div class="ci-icon">
                                <i class="ti-email"></i>
                            </div>
                            <div class="ci-text">
                                <span>Email:</span>
                                <p>${userInfo.userEmail }</p>
                            </div>
                        </div>
                        
                        
                    </div>
                </div>
                <!-- 
                <div class="col-lg-6 offset-lg-1">
                    <div class="contact-form">
                        <div class="leave-comment">
                            <h4>Leave A Comment</h4>
                            <p>Our staff will call back later and answer your questions.</p>
                            <form action="#" class="comment-form">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <input type="text" placeholder="Your name">
                                    </div>
                                    <div class="col-lg-6">
                                        <input type="text" placeholder="Your email">
                                    </div>
                                    <div class="col-lg-12">
                                        <textarea placeholder="Your message"></textarea>
                                        <button type="submit" class="site-btn">Send message</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                 -->
            </div>
        </div>
    </section>
    <!-- Contact Section End -->    
    
    
    <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
    <!-- Partner Logo Section End -->

	<script>
	
	
	$(document).ready(function() {
	    
		
		$("#uploadState").val(1);
		
		

	    document.onkeydown = noEvent;
	    
	    
		
		
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
	
	
	
		function noEvent() { // 새로 고침 방지
										  // paymentResult페이지에서 새로고침하면 reload되면서 db중복데이터 발생
			 
	        if ($("#uploadState").val() == "1") {
	            if (event.keyCode == 116) {
	                alert("새로고침을 할 수 없습니다.");
	                event.keyCode = 2;
	                return false;
	            } else if (event.ctrlKey
	                    && (event.keyCode == 78 || event.keyCode == 82)) {
	                return false;
	            }
	        }
	    }
	
	
	
	
</script>


</html>