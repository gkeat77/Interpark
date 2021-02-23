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
		  <li><a href="">회원정보</a></li>
		  <li><a href="">쿠폰 </a></li>
		  <li><a href="">마일리지</a></li>
		  <li><a href="/userInfo.do?userSw=4">구매이력</a></li>
		  <li><a href="/userInfo.do?userSw=5">ORDER</a></li>
		 </ul>
		</aside>
		<!-- content -->
		<div id="container_box">
			<c:choose>
				
				
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
							<button type="button"  id="userInfo" onclick="AA()" class="site-btn place-btn">결제취소</button>
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
        $('body').css("overflow", "scroll");
   };

</script>


</html>
