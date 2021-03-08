<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

	<jsp:include page="/WEB-INF/view/common/adminHeader.jsp"></jsp:include>
	<style>
		 
		  
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
            <!-- aside -->
            <jsp:include page="/WEB-INF/view/common/aside.jsp"></jsp:include>
        </div>
    </div>
    
    
	<input type="hidden" id="uploadState" name = "uploadState" value="" />
	<!-- Contact Section Begin -->
    <section class="contact-section spad">
  

        <div class="container">
        <!-- aside -->  
	   <section id="container">    
		
		<!-- content -->
		<div id="container_box">
			<c:choose>
				
				
			
				<c:when test = "${result eq 1}">
					<p>**최신순으로 보입니다</p>
					<c:if test="${empty list}">
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
					
				 	<c:forEach var="list" items="${list}">
					<div class="contact-widget">
		               <div class="cw-item">
		                   <div class="ci-icon">
		                       <i class="ti-cloud"></i>
		                   </div>
		                   <div class="ci-text">
		                       <span>결제번호:</span>
		                       <p><a href="javascript:void(0);" id="pay" onclick="orderCart(${list.payNo})">${list.payNo}</a></p>
		                   </div>
		               </div>
		             </div>
		             <ul>
						<li>구매일자: ${list.regDt}</li>
						<li>결제상태: ${list.state}</li>
					</ul>
					<button type="button"  id="userInfo2" onclick="" class="site-btn place-btn">AA</button>
					
					</c:forEach>
					
					
				 <ul class="btn-group pagination justify-content-center" id="paging-ul">
			    <c:if test="${pageMaker.prev }">
			    <li id="paging-li">
			        <a class="page-link" href='<c:url value="/adminOrders.do?adminSw=1&page=${pageMaker.startPage-1 }"/>'>Previous</a>
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
							<li id="paging-li" class="page-item active "><a class="page-link" href='<c:url value="/adminOrders.do?adminSw=1&page=${pageNum }"/>'>${pageNum }</a></li>
						</c:when>
						<c:otherwise>
			        			<li id="paging-li" class="page-item "><a class="page-link" href='<c:url value="/adminOrders.do?adminSw=1&page=${pageNum }"/>'>${pageNum }</a></li>											
						</c:otherwise>
					</c:choose>
			    </c:forEach>
			    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
			    <li id="paging-li" class="page-item">
			        <a class="page-link" href='<c:url value="/adminOrders.do?adminSw=1&page=${pageMaker.endPage+1 }"/>'>Next</a>
			    </li>
			    </c:if>
			</ul>
						
						
						
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
	
	
	
	// ------------------------
	// function
	// ------------------------
	
	
	
    function orderCart(payNo){
    	let elm = document.getElementById('paging-ul');
   		elm.style.visibility = "hidden";
   			
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
 						var userId = ""
 						var proQty = $('#cartList');
 						proQty.empty();	// append전에 비운다
 						userCarts.forEach(function (item, index, array) {
							proQty.append('<p><img id=cartImg src='+item.bookImg+'></img>'+item.bookName+'<br>'+item.stock+'권</p>');
							proQty.append('<br><br>');
							//proQty.append('<p><img id="cartImg" src='+item.bookImg+'></img></p>');
							//proQty.append('<p>'+item.bookName+'</p>');
							//proQty.append('<p>'+item.stock+'권</p>');
							userId=item.loginID;
 						})
					proQty.append('<p>결제된 금액: '+comma(result.totalPrice)+'</p>');
					proQty.append('<p>아이디: '+userId+'</p>');
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
        let elm = document.getElementById('paging-ul');
        elm.style.visibility = "visible";
        
   }
   
   



	
	
   

	
</script>


</html>
