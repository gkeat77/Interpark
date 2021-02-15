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
						<img src="${list.coverLargeUrl}" alt=""
							style="width: 260px; height: 300px;"
						>
						<c:if test="${list.saleRate > 1 }">
							<div class="sale pp-sale">Sale</div>
						</c:if>
						<div class="icon">
							<i class="icon_heart_alt"></i>
						</div>
						<ul>
							<li class="w-icon active"><a href="#"><iclass="icon_bag_alt"></i></a></li>
							<li class="quick-view"><a href="#">상세보기</a></li>
						</ul>
					</div>
					<div class="pi-text">
						<a href="#">
							<h5>
								<strong>${list.title }</strong>
							</h5>
						</a>
						<div class="author">${list.author}저│ ${list.publisher}</div>
						<div class="product-price">
							<fmt:formatNumber value="${list.realPrice }" type="number" />원
							<c:if test="${list.saleRate > 1 }">
							(${list.saleRate}% ↓)
							<span><fmt:formatNumber value="${list.salePrice }" type="number"/>원</span>
							</c:if>
						</div>
						<div class="author">
						<c:if test="${0 <= list.rStar  and list.rStar <= 1}"><img src="${CTX_PATH}/img/star/star0.png" class="star"></c:if>
						<c:if test="${1 < list.rStar  and list.rStar < 2}"><img src="${CTX_PATH}/img/star/star1.png" class="star"></c:if>
						<c:if test="${2 <= list.rStar  and list.rStar < 4}"><img src="${CTX_PATH}/img/star/star2.png" class="star"></c:if>
						<c:if test="${4 <= list.rStar  and list.rStar < 6}"><img src="${CTX_PATH}/img/star/star3.png" class="star"></c:if>
						<c:if test="${6 <= list.rStar  and list.rStar < 8}"><img src="${CTX_PATH}/img/star/star4.png" class="star"></c:if>
						<c:if test="${8 <= list.rStar}"><img src="${CTX_PATH}/img/star/star5.png" class="star"></c:if>
						${list.rStar } │ 리뷰: ${list.rCount } 건</div>	
						<div class="catagory-name text-center">${list.description}</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	</c:if>
<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />