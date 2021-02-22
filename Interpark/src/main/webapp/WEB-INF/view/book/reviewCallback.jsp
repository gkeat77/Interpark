<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>


$(document).ready(function() {
	//좋아요 버튼
	$(document).on("click",".icon_heart_alt,.icon_heart",function(){
		let rId = $(this).closest(".co-item").find(".rId").val();
		let className= $(this).attr('class');
		let likeCount =$(this).closest("div").find(".likeCount").text();
		let like;
		if(className == 'icon_heart_alt'){
			like='+1';
			$(this).removeClass();
			$(this).addClass('icon_heart');
			$(this).closest("div").find(".likeCount").text(parseInt(likeCount)+1);
			
		}else if(className == 'icon_heart'){
			like='-1';
			$(this).removeClass();
			$(this).addClass('icon_heart_alt');
			$(this).closest("div").find(".likeCount").text(parseInt(likeCount)-1);
		}
		
		$.ajax({
			type: "Post", 
			url:"/review/likeUnlike.do",
			data: {
				rId:rId,
				like:like
			},
			dataType:"Json", 
			success : function(result){
				alert(result.Msg);
			},
			error : function(a, b, c){
				alert("실패");
			}
		}); 
	});
	
	
});


</script>



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
             </div>
             <h5>${list.rTitle} <span>${list.loginId } │ ${list.rDate }</span></h5>
             <div class="at-reply">${list.rContent}</div>
              <div class="at-reply"><strong>좋아요 (<span class="likeCount">${list.rLike}</span>)</strong> │ <i class="icon_heart_alt" style="color:red"></i></div>
         </div>
     </div>
	</c:forEach>
</c:if>

<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />     