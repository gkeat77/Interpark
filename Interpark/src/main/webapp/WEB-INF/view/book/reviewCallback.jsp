<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<c:if test="${totalCnt eq 0 }">
		<div style="padding:100px">
				<h3 class="text-center" >해당 상품의 리뷰가 없습니다.</h3>
		</div>		 
	</c:if>
<c:if test="${totalCnt > 0 }">
	<c:forEach items="${reviewList }" var="list">
       <div class="co-item">
         <div class="avatar-text">
             <div class="at-rating">
				<c:if test="${list.rStar == 1}"><img src="${CTX_PATH }/img/star/star1.png" class="starImg"></c:if>
				<c:if test="${list.rStar == 2}"><img src="${CTX_PATH }/img/star/star2.png" class="starImg"></c:if>
				<c:if test="${list.rStar == 3}"><img src="${CTX_PATH }/img/star/star3.png" class="starImg"></c:if>
				<c:if test="${list.rStar == 4}"><img src="${CTX_PATH }/img/star/star4.png" class="starImg"></c:if>
				<c:if test="${list.rStar == 5}"><img src="${CTX_PATH }/img/star/star5.png" class="starImg"></c:if>
             </div>
             <h5>${list.rTitle == 5} <span>${list.rDate }</span></h5>
             <div class="at-reply">${list.rContent == 5}</div>
         </div>
     </div>
	</c:forEach>
</c:if>

<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />     