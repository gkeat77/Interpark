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
	<c:forEach var="list" items="${reviewList }">
       <div class="co-item">
         <div class="avatar-text">
         <input type="hidden" class="rId"  value="${list.rId}" />     
             <div class="at-rating">
				<c:if test="${list.rStar == 1}"><img src="${CTX_PATH }/img/star/star1.png" class="starImg"></c:if>
				<c:if test="${list.rStar == 2}"><img src="${CTX_PATH }/img/star/star2.png" class="starImg"></c:if>
				<c:if test="${list.rStar == 3}"><img src="${CTX_PATH }/img/star/star3.png" class="starImg"></c:if>
				<c:if test="${list.rStar == 4}"><img src="${CTX_PATH }/img/star/star4.png" class="starImg"></c:if>
				<c:if test="${list.rStar == 5}"><img src="${CTX_PATH }/img/star/star5.png" class="starImg"></c:if>
				<c:if test="${list.loginId eq member.loginID or member.loginID eq 'admin' }">
              	<button type="button" class="btn btn-warning" onclick="freview_del('${list.rId}',${list.pId })" style="color:white	">삭제</button>
              	</c:if>
             </div>
             <h5>${list.rTitle} <span>${list.loginId } │ ${list.rDate }</span></h5>
             <div class="at-reply">${list.rContent}</div>
              <div class="at-reply"><strong>좋아요 (<span class="likeCount">${list.rLike}</span>)</strong> 
              <c:if test="${list.loginId ne member.loginID}">
              │
              <c:if test="${list.likeChk == '+1'}"> <i class="icon_heart" style="color:red"></i></c:if>
              <c:if test="${list.likeChk eq '-1' or list.likeChk eq null}"> <i class="icon_heart_alt" style="color:red"></i></c:if>
              </c:if>
              </div>
         </div>
     </div>
     <hr>
	</c:forEach>
</c:if>

<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />     