<!DOCTYPE html> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/view/common/header.jsp"/>
<jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"/>


<script>
$(document).ready(function() {
	var timerdate ='${goods.sellEnd}'; 
	
		$("#countdown").countdown(timerdate, function(event) {
		    $(this).html(event.strftime("<div class='cd-item'><span>%D</span> <p>일</p> </div>" + "<div class='cd-item'><span>%H</span> <p>시</p> </div>" + "<div class='cd-item'><span>%M</span> <p>분</p> </div>" + "<div class='cd-item'><span>%S</span> <p>초</p> </div>"));
		});
}); 

</script>

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
                                	 <h3>${goods.title }</h3> <p class="star"></p>
                                    <a href="#" class="heart-icon"><i class="icon_heart_alt"></i></a>
                                </div>
                                <div class="pd-rating">
									<c:if test="${0 <= goods.rStar  and goods.rStar <= 1}"><img src="${CTX_PATH}/img/star/star0.png" class="star"></c:if>
									<c:if test="${1 < goods.rStar  and goods.rStar < 2.5}"><img src="${CTX_PATH}/img/star/star1.png" class="star"></c:if>
									<c:if test="${2.5 <= goods.rStar  and goods.rStar < 4.5}"><img src="${CTX_PATH}/img/star/star2.png" class="star"></c:if>
									<c:if test="${4.5 <= goods.rStar  and goods.rStar < 6.5}"><img src="${CTX_PATH}/img/star/star3.png" class="star"></c:if>
									<c:if test="${6.5 <= goods.rStar  and goods.rStar < 8.5}"><img src="${CTX_PATH}/img/star/star4.png" class="star"></c:if>
									<c:if test="${8.5 < goods.rStar}"><img src="${CTX_PATH}/img/star/star5.png" class="star"></c:if>
                                    <span>${goods.rStar } (${goods.rCount })</span>
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
                                        리뷰 
											<c:if test="${0 <= goods.rStar  and goods.rStar <= 1}"><img src="${CTX_PATH}/img/star/star0.png" class="star"></c:if>
											<c:if test="${1 < goods.rStar  and goods.rStar < 2.5}"><img src="${CTX_PATH}/img/star/star1.png" class="star"></c:if>
											<c:if test="${2.5 <= goods.rStar  and goods.rStar < 4.5}"><img src="${CTX_PATH}/img/star/star2.png" class="star"></c:if>
											<c:if test="${4.5 <= goods.rStar  and goods.rStar < 6.5}"><img src="${CTX_PATH}/img/star/star3.png" class="star"></c:if>
											<c:if test="${6.5 <= goods.rStar  and goods.rStar < 8.5}"><img src="${CTX_PATH}/img/star/star4.png" class="star"></c:if>
											<c:if test="${8.5 < goods.rStar}"><img src="${CTX_PATH}/img/star/star5.png" class="star"></c:if>
		                                    <span>${goods.rStar } ( 총 ${goods.rCount} 건)</span>
                                        </h4>
                                        <div class="comment-option">
                                            <div class="co-item">
                                                <div class="avatar-pic">
                                                    <img src="img/product-single/avatar-1.png" alt="">
                                                </div>
                                                <div class="avatar-text">
                                                    <div class="at-rating">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star-o"></i>
                                                    </div>
                                                    <h5>Brandon Kelley <span>27 Aug 2019</span></h5>
                                                    <div class="at-reply">Nice !</div>
                                                </div>
                                            </div>
                                            <div class="co-item">
                                                <div class="avatar-pic">
                                                    <img src="img/product-single/avatar-2.png" alt="">
                                                </div>
                                                <div class="avatar-text">
                                                    <div class="at-rating">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star-o"></i>
                                                    </div>
                                                    <h5>Roy Banks <span>27 Aug 2019</span></h5>
                                                    <div class="at-reply">Nice !</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="personal-rating">
                                            <h6>Your Ratind</h6>
                                            <div class="rating">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star-o"></i>
                                            </div>
                                        </div>
                                        <div class="leave-comment">
                                            <h4>리뷰 쓰기</h4>
                                            <form action="#" class="comment-form">
                                                <div class="row">
                                                    <div class="col-lg-6">
                                                        <input type="text" placeholder="Name">
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <input type="text" placeholder="Email">
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <textarea placeholder="Messages"></textarea>
                                                        <button type="submit" class="site-btn">리뷰 작성</button>
                                                    </div>
                                                </div>
                                            </form>
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