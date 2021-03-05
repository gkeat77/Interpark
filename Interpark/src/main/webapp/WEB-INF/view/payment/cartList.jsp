<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
	<style>
		
			
			
		
		.product-details .quantity .pro-qty2 {
	width: 123px;
	height: 46px;
	border: 2px solid #ebebeb;
	padding: 0 15px;
	float: left;
	margin-right: 14px;
}

.product-details .quantity .pro-qty .qtybtn2 {
	font-size: 24px;
	color: #b2b2b2;
	float: left;
	line-height: 38px;
	cursor: pointer;
	width: 18px;
}

.product-details .quantity .pro-qty2 .qtybtn.dec {
	font-size: 30px;
}

.product-details .quantity .pro-qty2 input {
	text-align: center;
	width: 52px;
	font-size: 14px;
	font-weight: 700;
	border: none;
	color: #4c4c4c;
	line-height: 40px;
	float: left;
}
	
	
	
	.cart-table table tr td.qua-col .pro-qty2 {
	width: 123px;
	height: 46px;
	border: 2px solid #ebebeb;
	padding: 0 15px;
	float: left;
}

.cart-table table tr td.qua-col .pro-qty2 .qtybtn {
	font-size: 24px;
	color: #b2b2b2;
	float: left;
	line-height: 38px;
	cursor: pointer;
	width: 18px;
}

.cart-table table tr td.qua-col .pro-qty2 .qtybtn.dec {
	font-size: 30px;
}

.cart-table table tr td.qua-col .pro-qty2 input {
	text-align: center;
	width: 52px;
	font-size: 14px;
	font-weight: 700;
	border: none;
	color: #4c4c4c;
	line-height: 40px;
	float: left;
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
                        <span>Shopping Cart</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <c:choose>
    <c:when test="${empty member}">
    
    	<script>
    		alert("로그인 먼저 해주세요");
    		location.href="/login/login.me";
    	</script>

    </c:when>	
    <c:when test="${check eq 1}">
    
    	<script>
    		alert("카트에 이미 상품이 있습니다");
    		location.href="/cartList.do";
    	</script>

    </c:when>
    
    <c:otherwise>

    <section class="shopping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="cart-table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th class="p-name">Product Name</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th><i class="ti-close" id="allCheck" onclick="allCheck()"></i>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cartList" items="${cartList}" >
                                <tr>
                                    <td class="cart-pic"><img src="${cartList.bookImg}" alt="" onclick="bookInfo(${cartList.pId})"></td>
                                    <td class="cart-title">
                                        <h5>${cartList.bookName}</h5>
                                    </td>
                                    <td class="p-price"><span id="price${cartList.cartNo }"><fmt:formatNumber pattern="###,###,###" value="${cartList.price}" />원</span></td>
                                    <td class="qua-col">
                                        <div class="quantity">
                                            <div class="pro-qty2">
                                            	<span class="dec qtybtn"  onclick="down(${cartList.cartNo})">-</span> 
                                                <input type="text" value="${cartList.stock}" id="desNum${cartList.cartNo}">
                                                <span class="inc qtybtn" onclick="add(${cartList.cartNo});">+</span> 
                                            </div>
                                        </div>
                                    </td>
                                     <td class="total-price"><span id="totalPrice${cartList.cartNo }"><fmt:formatNumber pattern="###,###,###" value="${cartList.price * cartList.stock}" />원</span></td> 
                                    <td class="close-td"><i class="ti-close" onclick="cartDel(${cartList.cartNo })"></i></td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                    </div>
                    <div class="row">
                        <div class="col-lg-4" style=visibility:hidden;>
                            <div class="cart-buttons">
                                <a href="#" class="primary-btn continue-shop">Continue shopping</a>
                                <a href="#" class="primary-btn up-cart">Update cart</a>
                            </div>
                            <div class="discount-coupon">
                                <h6>Discount Codes</h6>
                                <form action="#" class="coupon-form">
                                    <input type="text" placeholder="Enter your codes">
                                    <button type="submit" class="site-btn coupon-btn">Apply</button>
                                </form>
                            </div>
                        </div>
                        <div class="col-lg-4 offset-lg-4">
                            <div class="proceed-checkout">
                                <ul>
                                    <!-- <li class="subtotal">Subtotal <span>$240.00</span></li> -->
                                    <li class="cart-total">Total <span id="paymentPrice"></span></li>
                                </ul>
                                <a href="javascript:void(0);" onclick="goPayment()" class="proceed-btn">결제</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    
    </c:otherwise>
</c:choose>
    
    
    <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
    <!-- Partner Logo Section End -->

	<script>
	
	
	$(document).ready(function() {

	    $("body").on("change", "[id^=desNum]", function(event) {
	        console.log(this.id);
	        var vId = this.id;
	        var value = $('#'+""+vId).val();
	        console.log(value);
	    });
	    
	    totalPayment();	
	    
	    
	    
	    
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
	
	
	function cartDel(cartNo) {
		var result = confirm("카트 리스트에서 제거하시겠습니까?");
		if(result){
			var data = {
					cartNo : cartNo
			     };
			   $.ajax({
			    url : "/cartDel.do",
			    type : "post",
			    data : data,
			    success : function(result){
					if(result == "success") {
						location.reload(true);	// 삭제 후 초기화
					}else {
						 alert("회원만 사용할 수 있습니다.")
					}
			    },
			    error : function(){
			     alert("fall");
			    }
			   });
		}else{
		}
	}

	function add(cartNo) {
		var value = $('#desNum'+""+cartNo).val();
		var stock = parseInt(value)+1;
        $('#desNum'+""+cartNo).val(stock);
        var oldPrice =$('#price'+""+cartNo).html();
        oldPrice.slice(0,-1);		// 원 제거
        var realPrice = removeComma(oldPrice)*stock;
        realPrice = comma(realPrice)+"원";
        $('#totalPrice'+""+cartNo).html(realPrice);
        totalPayment();
	}
	
	function down(cartNo) {
		var value = $('#desNum'+""+cartNo).val();
		var stock = parseInt(value)-1;
		$('#desNum'+""+cartNo).val(stock);
		if(stock <=0 ) {
			$('#desNum'+""+cartNo).val("1");
		}else {
			var oldPrice =$('#price'+""+cartNo).html();
	        oldPrice.slice(0,-1);
	        var realPrice = removeComma(oldPrice)*stock;
	        realPrice = comma(realPrice)+"원";
	        $('#totalPrice'+""+cartNo).html(realPrice);
	        totalPayment();
		}
	}
	
	
	function totalPayment() {
		var cartNoList = new Array();		// forEach문 쓸려고 cartNo 가져옴
		<c:forEach items="${cartList}" var="item1">
			cartNoList.push("${item1.cartNo}");
		</c:forEach>
		
		// desNum
		
		
		// paymentTotlal
	    var paymentSum =0;
		cartNoList.forEach(function(el){
			var oldPrice = $('#totalPrice'+""+el).html();
			paymentSum+=removeComma(oldPrice.slice(0,-1));
			$('#paymentPrice').html(comma(paymentSum));
		});
	}
	
	
	function goPayment(){
		let cartNos="";	// 배열로 controller넘기는게 어려워서 string 형식으로 넘김
		let cartStocks="";
		var cartNoArr = new Array();
		
		<c:forEach items="${cartList}" var="item1">
			cartNos+=${item1.cartNo}+",";
			cartNoArr.push("${item1.cartNo}");
		</c:forEach>
		
		
		

		

		for (var i = 0; i < cartNoArr.length; i++) {
			cartStocks+=$('#desNum'+""+cartNoArr[i]).val()+",";
		}
		var price = $('#paymentPrice').html();
		var totalPrice = removeComma(price);
		
		var newForm = document.createElement('form'); 
		newForm.name = 'newForm'; 
		newForm.method = 'post'; 
		newForm.action = '/paymentForm.do'; 
		
		var input1 = document.createElement('input'); 
		input1.setAttribute("type", "hidden"); 
		input1.setAttribute("name", "totalPrice"); 
		input1.setAttribute("value", totalPrice); 
		
		var input2 = document.createElement('input'); 
		input2.setAttribute("type", "hidden"); 
		input2.setAttribute("name", "cartNos"); 
		input2.setAttribute("value", cartNos.slice(0,-1));
		
		var input3 = document.createElement('input'); 
		input3.setAttribute("type", "hidden"); 
		input3.setAttribute("name", "cartStocks"); 
		input3.setAttribute("value", cartStocks.slice(0,-1));
		
		
		newForm.appendChild(input1);
		newForm.appendChild(input2);
		newForm.appendChild(input3);
		
		document.body.appendChild(newForm);
		
		if ( !cartNos.length ){
			alert("장바구니 등록 먼저해주세요");
		}else {
			newForm.submit();	
		}
		 
	}
	
	
		
	function allCheck() {
		var confirm_val = confirm("정말 카트의 모든 목록을 삭제하시겠습니까?");
		
		
		 var checkedValue = [];
		
		<c:forEach items="${cartList}" var="item1">
			checkedValue.push("${item1.cartNo}");
		</c:forEach>
		
		
		if(confirm_val) {
			
			var data = {
					val : checkedValue
			     };
			   $.ajax({
			    url : "/cartDelAll.do",
			    type : "post",
			    data : data,
			    success : function(result){
					if(result == "success") {
						location.reload(true);	// 삭제 후 초기화
					}else {
						 alert("회원만 사용할 수 있습니다.")
					}
			    },
			    error : function(){
			     alert("fail");
			    }
			   });
		}else{
		}
		
		}
	
	// 도서 이미지 클릭시 상세정보
	function bookInfo(pId) {
		url = "/book/goodsDetail.do?pId=";	
		location.href = url+pId;
	}
	
	</script>


</html>