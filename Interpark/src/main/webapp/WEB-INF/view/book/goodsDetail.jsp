<!DOCTYPE html> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/view/common/header.jsp"/>

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
                                        <input type="text" value="1" id="bookStock">
                                    </div>
                                </div>
                             	<p><strong>남은 수량: ${goods.stock }</strong></p>
                                <c:if test="${goods.sellEnd ne null and goods.sellEnd ne '' }">
                                <p><strong>남은 판매기간</strong></p>
                                <div class="countdown-timer uBoder" id="countdown">
				                </div>
				                </c:if>
                                <a href="javascript:void(0);" onclick="goCart(${goods.pId})" class="primary-btn pd-cart text-center" style="background-color:#000000;width:200px;height:50px">카트 담기</a>
                                <a href="javascript:void(0);" onclick="goBuy(${goods.pId})" class="primary-btn pd-cart text-center" style="width:200px;height:50px">바로 구매</a>
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
                               		<a data-toggle="tab" href="#tab-2" role="tab">리뷰 (<span id="tabRcount">${goods.rCount }</span>)</a>
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
                                             <div class="col-lg-10">
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
                                                <p><img src="/imgFile/${goods.itemId}/${goods.file_nm}"></p>
                                                </c:if>
                                            </div>
                                            <div>
                                                <img src="img/product-single/tab-desc.jpg" alt="">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-2" role="tabpanel">
                                  	<div class="col-lg-10">
                                    	<div class="customer-review-option">
	                                    	<input type="hidden" id="sort">
	                                    	<div class="btn-group float-right">
										      	 <button type="button" class="btn btn-outline-warning" id="newSort">최신순</button>
												 <button type="button" class="btn btn-outline-warning" id="likeSort">좋아요 순</button>
											</div>
	                                        <h4>
	                                        리뷰<div class="star"><p>${goods.rStar } ( 총 ${goods.rCount} 건)</p>
	                                        </div><hr>
	                                        </h4>
	                                        <div class="comment-option"></div>
	                                        <div class="paging_area" id="Pagination"></div>
	                                        <div class="personal-rating">
	                                            <button type="button" class="site-btn" id="reviewPop">리뷰 작성</button>
	                                        </div>
                                    </div>
                                </div>
                                </div>
                                     <div class="tab-pane fade" id="tab-3" role="tabpanel">
                                     <div class="col-lg-10">
                                    	<div class="specification-table">
	                                        <table>
	                                            <tr>
	                                                <td class="p-catagory">교환/환불 방법</td>
	                                                <td>
	                                                    <div class="pd-rating">
	                                                       마이페이지 > 취소/반품/교환/환불’ 에서 신청함, 1:1 문의 게시판 또는 고객센터(1577-2555) 이용 가능
	                                                    </div>
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <td class="p-catagory">교환/환불 가능 기간</td>
	                                                <td>
	                                                    <div class="p-price">고객변심은 출고완료 다음날부터 14일 까지만 교환/환불이 가능함</div>
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <td class="p-catagory">교환/환불 비용</td>
	                                                <td>
	                                                    <div class="cart-add">고객변심 또는 구매착오의 경우에만 2,500원 택배비를 고객님이 부담함</div>
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <td class="p-catagory">교환/환불 불가사유</td>
	                                                <td>
	                                                    <div class="p-stock">반품접수 없이 반송하거나, 우편으로 보낼 경우 상품 확인이 어려워 환불이 불가할 수 있음<br>
														배송된 상품의 분실, 상품포장이 훼손된 경우, 비닐랩핑된 상품의 비닐 개봉시 교환/반품이 불가능함</div>
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <td class="p-catagory">소비자 피해보상</td>
	                                                <td>
	                                                    <div class="p-weight">소비자 피해보상의 분쟁처리 등에 관한 사항은 소비자분쟁해결기준(공정거래위원회 고시)에 따라 비해 보상 받을 수 있음
														교환/반품/보증조건 및 품질보증 기준은 소비자기본법에 따른 소비자 분쟁 해결 기준에 따라 피해를 보상 받을 수 있음</div>
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <td class="p-catagory">기타</td>
	                                                <td>
	                                                    <div class="p-size">도매상 및 제작사 사정에 따라 품절/절판 등의 사유로 주문이 취소될 수 있음<br>(이 경우 인터파크도서에서 고객님께 별도로 연락하여 고지함)
														</div>
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
                </div>
    </section>
    <!-- Product Shop Section End -->

    <!-- 연관 상품 시작 -->
    <div class="related-products spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h2>비슷한 카테고리 인기 도서</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                 <div class="col-lg-10 offset-lg-1">
                    <div class="product-slider owl-carousel">
                    <c:forEach items="${relate}" var="list">
                        <div class="product-item">
                            <div class="pi-pic">
                                <img src="${list.coverLargeUrl }" alt="" style="width:150px;height:300px">
                                <c:if test="${list.saleRate > 1 }">
                                <div class="sale">${list.saleRate}% 할인</div>
                                </c:if>
                                <ul>
                                    <li class="quick-view"><a href="#" onclick="selectBook('${list.pId}')">상세보기</a></li>
                                </ul>
                            </div>
                            <div class="pi-text">
                                <a href="#">
                                    <h5>${list.title }</h5>
                                </a>
                                <div class="product-price">
                                    <fmt:formatNumber value="${list.realPrice }" type="number" />원
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 연관 상품 끝 -->
 <jsp:include page="/WEB-INF/view/common/footer.jsp"/>
 <jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"/>
 
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
					<td><input type="text" class="form-control" name="rTitle" id="rtitle"></td>
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
 <script>
var pageSize = 5;
var pageBlockSize = 10;

$(document).ready(function() {
	
	flist_review();
	
	
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
		if ('${member}' == null || '${member}' =='' ){
			alert("로그인이 필요합니다.");
			location.href='/login/login.me';
		}else{
			fInit();
			gfModalPop("#layer1");
		}
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

	
	//좋아요 버튼
	$(document).on("click",".icon_heart,.icon_heart_alt",function(){
		
		if ('${member}' == null || '${member}' =='' ){
			alert("로그인이 필요합니다.");
			location.href='/login/login.me';
		}else{
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
				},
				error : function(){
					alert("실패");
					}
				}); 
			}
		});
	
	//정렬 버튼
	$("#newSort,#likeSort").click(function(){
		let id=$(this).attr('id'); 
		console.log("id:"+id);
		if(id=='newSort'){
			$("#sort").val("regTime desc");
		}else if (id=='likeSort'){
			$("#sort").val("`rLike` desc");	
		}
		currentPage = $("#currentPage").val();
		flist_review(currentPage);
	});
	
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
 	// 목록 조회 페이지 번호
		currentPage = $("#currentPage").val();
 
	// 응답 메시지 출력
		alert(data.resultMsg);

	// 모달 닫기
		gfCloseModal();
		
 	 //리뷰숫자 갱신
		frenewRcount(data);
		
	// 입력폼 초기화
		fInit();
		flist_review(currentPage);	
		
}
//리뷰 작성창 폼 초기화
function fInit(){
	//별점 초기화
	for (var i = 1; i <= $('input[name="rStar"]').length; i++) {
		$('#star'+i).removeClass("radioStar")
		$('#star'+i).addClass("radioNoStar")
	}
	$('input[name="rStar"]').prop("checked", false);
	//내용초기화
	$("#rtitle").val('${goods.title }');
	$("#rContent").val('');
	
}

//리뷰숫자 갱신
function frenewRcount(data){
	console.log(data.goodsInfo.rStar);
	displayAvgStar(data.goodsInfo.rStar);
	$("#tabRcount").empty();	
	$("#tabRcount").append(data.goodsInfo.rCount);
	$(".star p").empty();
	$(".star p").append(data.goodsInfo.rStar+' (총 '+ data.goodsInfo.rCount+' 건)');
}


/** 리뷰 목록 조회 */
function flist_review(currentPage) {

	currentPage = currentPage || 1;
	let sort=$("#sort").val(); 
	// 강의 정보 설정
	let pId = $("#pId").val();

	var param = {
		pId : pId,
		currentPage : currentPage,
		pageSize : pageSize,
		sort:sort
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


function freview_del(rId,pId){
	var result = confirm("리뷰를 삭제하시겠습니까?");
	
	if(result){
		var param = {
				rId:rId,
				pId:pId
			}
		var resultCallback = function(data) {
			freview_del_result(data);
		};
	
		callAjax("/review/delete.do", "post", "json", true, param,
				resultCallback);
	}else{
		return
	}
	
}

function freview_del_result(data){
	// 목록 조회 페이지 번호
	currentPage = $("#currentPage").val();

	// 응답 메시지 출력
	alert(data.resultMsg);
	
	//리뷰 갱신
	frenewRcount(data);
	flist_review(currentPage);
}

function goCart(pId) {
	if(chkQty()){
		var bookStock=1;
		bookStock = $('#bookStock').val();
		var data = {
				pId : pId
				, bookStock : bookStock
		     };
		   $.ajax({
		    url : "/goCart.do",
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
	   
}
	   
function goBuy(pId) {
	if(chkQty()){
		var bookStock = 1;
		bookStock = $('#bookStock').val();
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
				newForm.action = '/directPayment.do'; 
				
				var input1 = document.createElement('input'); 
				input1.setAttribute("type", "hidden"); 
				input1.setAttribute("name", "pId"); 
				input1.setAttribute("value", pId); 
				
				var input2 = document.createElement('input'); 
				input2.setAttribute("type", "hidden"); 
				input2.setAttribute("name", "stock"); 
				input2.setAttribute("value", bookStock);
				
				newForm.appendChild(input1);
				newForm.appendChild(input2);
				document.body.appendChild(newForm);
				newForm.submit();
			}else{
			}
		}
	}	
}

//재고값 체크
function chkQty(){
	var selectQty = $("#bookStock").val();
	var stock = parseFloat('${goods.stock}');
	if(selectQty > stock){
		alert("상품 재고가 부족합니다. 현재수량: ${goods.stock}" );
			return false;
		}else{
			return true;
		}
}
			


</script>
 