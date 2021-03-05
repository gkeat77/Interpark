<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<c:if test="${totalCnt eq 0 }">
		<div style="padding:100px">
				<h3 class="text-center" >데이터가 존재하지 않습니다.</h3>
		</div>		 
	</c:if>

	<c:if test="${totalCnt > 0 }">
	<div class="row">
		<c:forEach var="list" items="${goodsList }">
			<div class="col-lg-4 col-sm-6">
				<div class="product-item">
					<div class="pi-pic">
						<img src="${list.coverLargeUrl}"  style="width: 300px; height: 320px;" onClick="selectBook('${list.pId}')">
						<c:if test="${list.saleRate > 1 }">
							<div class="sale pp-sale">${list.saleRate}% 할인</div>
						</c:if>
						<div class="icon">
							<i class="icon_heart_alt"></i>
						</div>
						<ul>
						<!--카트 /  구매 버튼 링크  -->
							<li class="w-icon active"><a href="javascript:void(0);" onclick="goCart(${list.pId})">CART</a></li>
							<li class="quick-view"><a href="javascript:void(0);" onclick="goBuy(${list.pId})">BUY</a></li>
						</ul>
					</div>
					<div class="pi-text">
						<a href="#" onClick="selectBook('${list.pId}')">
							<h5>
								<strong>${list.title } </strong>
							</h5>
						</a>
						<div class="author">${list.author}저│ ${list.publisher}</div>
						<div class="product-price">
							<fmt:formatNumber value="${list.realPrice }" type="number" />원
						</div>
						<div class="author">
						<c:set var="rStar" value="${list.rStar+((list.rStar%1>0.5)?(1-(list.rStar%1))%1:-(list.rStar%1))}"/>
                            <c:if test="${0 <= rStar and rStar < 1}"><img src="${CTX_PATH }/img/star/star0.png" class="starImg"></c:if>
                            <c:if test="${1 <= rStar and rStar < 2}"><img src="${CTX_PATH }/img/star/star1.png" class="starImg"></c:if>
                            <c:if test="${2 <= rStar and rStar < 3}"><img src="${CTX_PATH }/img/star/star2.png" class="starImg"></c:if>
                            <c:if test="${3 <= rStar and rStar < 4}"><img src="${CTX_PATH }/img/star/star3.png" class="starImg"></c:if>
                            <c:if test="${4 <= rStar and rStar < 5}"><img src="${CTX_PATH }/img/star/star4.png" class="starImg"></c:if>
                            <c:if test="${rStar eq 5}"><img src="${CTX_PATH }/img/star/star5.png" class="starImg"></c:if>
                            ${list.rStar } │ 리뷰: ${list.rCount } 건
                        </div>
						<div class="catagory-name text-center">${list.description}</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	</c:if>
<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />