<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<script>
		function goCart(P) {
			var data = {
					pId : pId
			     };
			   $.ajax({
			    url : "/book/goCart.do",
			    type : "post",
			    data : data,
			    success : function(result){
					if(result.resultMsg == "success") {
						alert("카트에 등록되었습니다");
						location.reload(true);	// 삭제 후 초기화
					}else if (result.resultMsg == "cartAlready"){
						alert("카트에 이미 상품이 있습니다");
					}else {
						alert("로그인 먼저해주세요");
						location.href='/login/login.me'; 
					}
			    },
			    error : function(){
			     alert("fail");
			    }
			   });
		}
		function goBuy(pId) {
			var session = $('#session').val();
			if(session == '' || session == 'null') {
				alert("로그인 먼저해주세요");
				location.href='/login/login.me';
			}else {
				var confirm_val = confirm("결제를 진행할까요?");
				if(confirm_val){
					
					var newForm = document.createElement('form'); 
					newForm.name = 'newForm'; 
					newForm.method = 'post'; 
					newForm.action = '/cartList.do'; 
					
					var input1 = document.createElement('input'); 
					input1.setAttribute("type", "hidden"); 
					input1.setAttribute("name", "pId"); 
					input1.setAttribute("value", pId); 
					
					newForm.appendChild(input1);
					document.body.appendChild(newForm);
					newForm.submit();
				}else{
				}
			}
		}
		
	</script>
	<c:if test="${totalCnt eq 0 }">
		<div style="padding:100px">
				<h3 class="text-center" >데이터가 존재하지 않습니다.</h3>
		</div>		 
	</c:if>

	 <c:if test="${totalCnt > 0 }">
	<div class="row">
	  	<input type="hidden" value="${member}" id="session"/>
		<c:forEach var="list" items="${eventList }">
			<div class="eventList" style="margin-top: 30px;height: 297px;">
                     <div class="img">			                      	
                       <a href="javascript:moveTemplate('','','238225','','http://book.interpark.com/event/EventFntTemPlate.do?_method=GenTemplate&amp;sc.evtNo=238225&amp;bid1=Eventzone&amp;bid2=Eventbenefit&amp;bid3=mdrecomm&amp;bid4=list','002','','&amp;bid1=Eventzone&amp;bid2=Eventbenefit&amp;bid3=mdrecomm&amp;bid4=list');"></a>
                       <a href="javascript:moveTemplate('','','238225','002','http://book.interpark.com/event/EventFntTemPlate.do?_method=GenTemplate&amp;sc.evtNo=238225','002','','&amp;bid1=Eventzone&amp;bid2=Eventbenefit&amp;bid3=mdrecomm&amp;bid4=list');"><img src="http://bimage.interpark.com/milti/renewPark/milti/down/ibss/20210122/0122dbfh65.jpg" style="width:190px;height:65px;" alt=""></a>			                         	
                     </div>
                     <div class="binfo">
                       <div class="icon">			                          
                       </div>
                       <div class="text">
                         <a class="name" href="javascript:moveTemplate('','','238225','','http://book.interpark.com/event/EventFntTemPlate.do?_method=GenTemplate&amp;sc.evtNo=238225&amp;bid1=Eventzone&amp;bid2=Eventbenefit&amp;bid3=mdrecomm&amp;bid4=list','002','','&amp;bid1=Eventzone&amp;bid2=Eventbenefit&amp;bid3=mdrecomm&amp;bid4=list');">"${list.e_title}"</a>			                          
                         <div style="padding-right: 50px;">
                          <fmt:formatDate value="${list.e_sdate}" pattern="yyyy-MM-dd"/>
                          <span>-</span>
                          <fmt:formatDate value="${list.e_edate}" pattern="yyyy-MM-dd"/>
                         </div>			                          
                         <div class="detail">"${list.e_content}"</div>
                       </div>
                     </div>
                   </div>
		</c:forEach>
	</div>
	</c:if>
<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />