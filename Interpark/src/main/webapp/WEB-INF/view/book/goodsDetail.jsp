<!DOCTYPE html> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/view/common/header.jsp"/>
<jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"/>


<script>
var pageSize = 5;
var pageBlockSize = 10;

$(document).ready(function() {
	
	//타이머
	var timerdate ='${goods.sellEnd}'; 
	
	$("#countdown").countdown(timerdate, function(event) {
		$(this).html(event.strftime("<div class='cd-item'><span>%D</span> <p>일</p> </div>" + "<div class='cd-item'><span>%H</span> <p>시</p> </div>" + "<div class='cd-item'><span>%M</span> <p>분</p> </div>" + "<div class='cd-item'><span>%S</span> <p>초</p> </div>"));
	});
	//별점 표시	
	let rStar ='${goods.rStar}'	
	displayAvgStar(rStar);
	
	//리뷰
	$("#reviewPop").click(function(event){
		fInit();
		gfModalPop("#layer1");
	});
	
	//별점 버튼
	$('input[name="rStar"]').change(function(){
		let value = $(this).val();
		for (var i = 1; i <= $('input[name="rStar"]').length; i++) {
			$('#star'+i).removeClass("radioStar")
			$('#star'+i).addClass("radioNoStar")
		}
	 	for (var i = 1; i <= value; i++) {
			$('#star'+i).removeClass("radioNoStar");
			$('#star'+i).addClass("radioStar");
		}  
	});

	flist_review();
});


/** 리뷰 저장 */
function freview_regist() {

	var resultCallback = function(data) {
		freview_regist_result(data);
	};

	callAjax("/review/regist.do", "post", "json", true, $("#modalForm")
			.serialize(), resultCallback);
}

/** 리뷰 저장 콜백 함수 */
function freview_regist_result(data) {
/* 	// 목록 조회 페이지 번호
	var currentPage = "1";
	if ($("#action").val() != "I") {
		currentPage = $("#currentPage_adv").val();
	}
 */
		// 응답 메시지 출력
		alert(data.resultMsg);

		// 모달 닫기
		gfCloseModal();
	// 입력폼 초기화
	fInit();
}
//폼 초기화
function fInit(){
	for (var i = 1; i <= $('input[name="rStar"]').length; i++) {
		$('#star'+i).removeClass("radioStar")
		$('#star'+i).addClass("radioNoStar")
	}
	$("#rtitle").val('');
	$("#rContent").val('');
	
}


/** 리뷰 목록 조회 */
function flist_review(currentPage) {

	currentPage = currentPage || 1;

	// 강의 정보 설정
	let pId = $("#pId").val();

	var param = {
		pId : pId,
		currentPage : currentPage,
		pageSize : pageSize
	}

	var resultCallback = function(data) {
		flist_review_result(data, currentPage);
	};

	callAjax("/review/reviewList.do", "post", "text", true, param,
			resultCallback);
}

/** 상담 조회 콜백 함수 */
function flist_review_result(data, currentPage) {
	// 기존 목록 삭제
	$('.comment-option').empty();

	// 신규 목록 생성
	$('.comment-option').append(data);

	// 총 개수 추출
	var totalCnt = $("#totalCnt").val();

	// 페이지 네비게이션 생성
	var paginationHtml = getPaginationHtml(currentPage, totalCnt,
			pageSize, pageBlockSize, 'flist_review');
	$("#Pagination").empty().append(paginationHtml);

	// 현재 페이지 설정
	$("#currentPage").val(currentPage);

}



</script>
	<input type="hidden" id="currentPage" value="1">
	
    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text product-more">
                        <a href="./home.html"><i class="fa fa-home"></i> Home</a>
                        <a href="./shop.html">Shop</a>
                        <span>Detail</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Section Begin -->
<section class="product-shop spad page-details">
    	<div class="container">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-5">
                            <!-- 이미지 -->
                            <div class="product">
                                <img src="${goods.coverLargeUrl }" style="width: 320px; height: 375px;">
                                     <div class="pd-share">
                                    <div class="p-code"></div>
                                    <div class="pd-social">
                                        <a href="#"><i class="ti-facebook"></i></a>
                                        <a href="#"><i class="ti-twitter-alt"></i></a>
                                        <a href="#"><i class="ti-linkedin"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-7"> 
                        <!-- 상품 정보 -->
                            <div class="product-details">
                                <div class="pd-title">
                                	 <h3>${goods.title }</h3>
                                    <a href="#" class="heart-icon"><i class="icon_heart_alt"></i></a>
                                </div>
                                <div class="pd-rating">
                                	<div class="star"><p>${goods.rStar } (${goods.rCount })</p></div>
                                </div>
                                <div class="pd-desc">
                                    <p> 
                                    <span>저 : ${goods.author } 
                                    <c:if test="${goods.translator ne null and goods.translator ne ''}"> │ 역 : ${goods.translator} </c:if> 
                                     <br>출판사: ${goods.publisher }  │ 발행 : ${goods.pubDate } <br>상품번호: ${goods.pId } │  ISBN : ${goods.isbn }
                                    </span>
                                    </p>
                                    <div class="uBoder" style="width:250px;">
                                    <h4><fmt:formatNumber value="${goods.realPrice }" type="number" />원  <p>(${goods.saleRate } % 할인)</p></h4>
                                    <p><strong>적립 </strong> <fmt:formatNumber value="${goods.mileage }" type="number" />P  (${goods.mileageRate } % 적립)</p>
                                    </div>
                                </div>
                                <c:if test="${goods.sellState ne null and goods.sellState ne 'N' }">
                                <div class="quantity">
                                    <div class="pro-qty">
                                        <input type="text" value="1">
                                    </div>
                                </div>
                             	<p><strong>남은 수량: ${goods.stock }</strong></p>
                                <c:if test="${goods.sellEnd ne null and goods.sellEnd ne '' }">
                                <p><strong>남은 판매기간</strong></p>
                                <div class="countdown-timer uBoder" id="countdown">
				                </div>
				                </c:if>
                                <a href="#" class="primary-btn pd-cart text-center" style="background-color:#000000;width:200px;height:50px">카트 담기</a>
                                <a href="#" class="primary-btn pd-cart text-center" style="width:200px;height:50px">바로 구매</a>
                                </c:if>
                                <c:if test="${goods.sellState ne null and goods.sellState eq 'N' }">
                                	<h3>현재 판매중인 상품이 아닙니다.</h3>
                                </c:if> 
                            </div>
                        </div>
                    </div>
                     <!-- 상세정보  -->
                    <div class="product-tab">
                        <div class="tab-item">
                            <ul class="nav" role="tablist">
                                <li>
                                    <a class="active" data-toggle="tab" href="#tab-1" role="tab">도서 정보</a>
                                </li>
                                <li>
                               		<a data-toggle="tab" href="#tab-2" role="tab">리뷰 (${goods.rCount })</a>
                                </li>
                                <li>
                                    <a data-toggle="tab" href="#tab-3" role="tab">교환/환불/배송</a>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-item-content">
                            <div class="tab-content">
                                <div class="tab-pane fade-in active" id="tab-1" role="tabpanel">
                                    <div class="product-content">
                                        <div class="row">
                                             <div class="col-lg-12">
                                                <h5>책소개</h5><hr>
                                                <pre>${goods.description }</pre>
                                                <h5>목차</h5><hr>
                                                <pre>${goods.index }</pre>
                                                <c:if test="${goods.authorInfo ne null and goods.authorInfo ne '' }">
                                                <h5>저자소개</h5><hr>
                                                <pre>${goods.authorInfo }</pre>
                                                </c:if>
                                                <c:if test="${goods.file_nm ne null and goods.file_nm ne '' }">
                                                <h5>관련 이미지</h5><hr>
                                                <p><img src="${CTX_PATH}/file/${goods.itemId}/${goods.file_nm}"></p>
                                                </c:if>
                                            </div>
                                            <div>
                                                <img src="img/product-single/tab-desc.jpg" alt="">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-2" role="tabpanel">
                                    <div class="customer-review-option">
                                        <h4>
                                        리뷰<div class="star"><p>${goods.rStar } ( 총 ${goods.rCount} 건)</p></div><hr>
                                        </h4>
                                        <div class="comment-option"></div>
                                        <div class="paging_area" id="Pagination"></div>
                                        <div class="personal-rating">
                                            <button type="button" class="site-btn" id="reviewPop">리뷰 작성</button>
                                        </div>
                                    </div>
                                </div>
                                     <div class="tab-pane fade" id="tab-3" role="tabpanel">
                                    <div class="specification-table">
                                        <table>
                                            <tr>
                                                <td class="p-catagory">Customer Rating</td>
                                                <td>
                                                    <div class="pd-rating">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star-o"></i>
                                                        <span>(5)</span>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">Price</td>
                                                <td>
                                                    <div class="p-price">$495.00</div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">Add To Cart</td>
                                                <td>
                                                    <div class="cart-add">+ add to cart</div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">Availability</td>
                                                <td>
                                                    <div class="p-stock">22 in stock</div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">Weight</td>
                                                <td>
                                                    <div class="p-weight">1,3kg</div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">Size</td>
                                                <td>
                                                    <div class="p-size">Xxl</div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">Color</td>
                                                <td><span class="cs-color"></span></td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">Sku</td>
                                                <td>
                                                    <div class="p-code">00012</div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
    </section>
    <!-- Product Shop Section End -->

    <!-- Related Products Section End -->
    <div class="related-products spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h2>Related Products</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-sm-6">
                    <div class="product-item">
                        <div class="pi-pic">
                            <img src="img/products/women-1.jpg" alt="">
                            <div class="sale">Sale</div>
                            <div class="icon">
                                <i class="icon_heart_alt"></i>
                            </div>
                            <ul>
                                <li class="w-icon active"><a href="#"><i class="icon_bag_alt"></i></a></li>
                                <li class="quick-view"><a href="#">+ Quick View</a></li>
                                <li class="w-icon"><a href="#"><i class="fa fa-random"></i></a></li>
                            </ul>
                        </div>
                        <div class="pi-text">
                            <div class="catagory-name">Coat</div>
                            <a href="#">
                                <h5>Pure Pineapple</h5>
                            </a>
                            <div class="product-price">
                                $14.00
                                <span>$35.00</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="product-item">
                        <div class="pi-pic">
                            <img src="img/products/women-2.jpg" alt="">
                            <div class="icon">
                                <i class="icon_heart_alt"></i>
                            </div>
                            <ul>
                                <li class="w-icon active"><a href="#"><i class="icon_bag_alt"></i></a></li>
                                <li class="quick-view"><a href="#">+ Quick View</a></li>
                                <li class="w-icon"><a href="#"><i class="fa fa-random"></i></a></li>
                            </ul>
                        </div>
                        <div class="pi-text">
                            <div class="catagory-name">Shoes</div>
                            <a href="#">
                                <h5>Guangzhou sweater</h5>
                            </a>
                            <div class="product-price">
                                $13.00
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="product-item">
                        <div class="pi-pic">
                            <img src="img/products/women-3.jpg" alt="">
                            <div class="icon">
                                <i class="icon_heart_alt"></i>
                            </div>
                            <ul>
                                <li class="w-icon active"><a href="#"><i class="icon_bag_alt"></i></a></li>
                                <li class="quick-view"><a href="#">+ Quick View</a></li>
                                <li class="w-icon"><a href="#"><i class="fa fa-random"></i></a></li>
                            </ul>
                        </div>
                        <div class="pi-text">
                            <div class="catagory-name">Towel</div>
                            <a href="#">
                                <h5>Pure Pineapple</h5>
                            </a>
                            <div class="product-price">
                                $34.00
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="product-item">
                        <div class="pi-pic">
                            <img src="img/products/women-4.jpg" alt="">
                            <div class="icon">
                                <i class="icon_heart_alt"></i>
                            </div>
                            <ul>
                                <li class="w-icon active"><a href="#"><i class="icon_bag_alt"></i></a></li>
                                <li class="quick-view"><a href="#">+ Quick View</a></li>
                                <li class="w-icon"><a href="#"><i class="fa fa-random"></i></a></li>
                            </ul>
                        </div>
                        <div class="pi-text">
                            <div class="catagory-name">Towel</div>
                            <a href="#">
                                <h5>Converse Shoes</h5>
                            </a>
                            <div class="product-price">
                                $34.00
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Related Products Section End -->
 <jsp:include page="/WEB-INF/view/common/footer.jsp"/>
 
 
 		<!-- 모달팝업 -->
		<div id="mask"></div>
		<div id="layer1" class="layerPop layerType2" style="width:800px; height:650px; padding:10px; overflow:hidden;">
		<form id="modalForm">
			<input type="hidden" name="pId" value="${goods.pId }" id="pId">
			<input type="hidden" name="loginId" value="${member.loginID}">
 			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col" colspan="2" class="text-center">리뷰 작성</th>
			    </tr>
			  </thead>
			  <tbody>
			  	 <tr>
			    	<th scope="row">평점</th>
					<td>
						<label class="box-radio-input"><input type="radio" name="rStar" value="1"><span class="radioNoStar" id="star1"></span></label>
						<label class="box-radio-input"><input type="radio" name="rStar" value="2"><span class="radioNoStar" id="star2"></span></label>
						<label class="box-radio-input"><input type="radio" name="rStar" value="3"><span class="radioNoStar" id="star3"></span></label>
						<label class="box-radio-input"><input type="radio" name="rStar" value="4"><span class="radioNoStar" id="star4"></span></label>
						<label class="box-radio-input"><input type="radio" name="rStar" value="5"><span class="radioNoStar" id="star5"></span></label>
					</td>
			    </tr>
			    <tr>
			    	<th scope="row">제목</th>
					<td><input type="text" class="form-control" name="rTitle" id="rTitle"></td>
			    </tr>
			    <tr>
			    	<th scope="row">내용</th>
			    	<td><textarea class="form-control" name="rContent" style="height:320px" id="rContent"></textarea></td>
			    </tr>
			    <tr>
			    	<td colspan="2" class="text-center"><button type="button" class="btn btn-warning btn-lg" onclick="freview_regist()">작성</button> 
			    	<button type="button" class="btn btn-dark btn-lg" onclick="gfCloseModal()">취소</button></td>
			    </tr>
			  </tbody>
			</table>
			</form>
		</div>
 