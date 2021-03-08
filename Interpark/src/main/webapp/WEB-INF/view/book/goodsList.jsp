<!DOCTYPE html> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/view/common/header.jsp"/>

    <!-- Breadcrumb Section Begin -->
     <div class="container">
    <div class="breacrumb-section">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text">
                        <a href="#"><i class="fa fa-home"></i> Home</a>
                        <span>Shop</span>
                    </div>
                </div>
            </div>
          </div>  
   <!-- Breadcrumb Section Begin -->



	<!-- Product Shop Section Begin -->
    <input type="hidden" id="cateId">
    <input type="hidden" id="cateClass">
    <input type="hidden" id="serviceType">
    <section class="product-shop spad">
        <div class="container">
		     <p class="conTitle mt50 text-right">
				<select id="searchType" name="searchType" class="form-control sSelect">
					<option value="all" id="option1" selected="selected">전체</option>
					<option value="title" id="option1">상품명</option>
					<option value="P_ID" id="option1">ID</option>
				</select> 
				<input type="text"  class="form-control sInput" id="searchKey" name="searchKey" onKeyDown="if(event.keyCode == 13) flist_goods()">
				<button type="button" id="btnSearch" class="btn sBtn">
					<span>검색</span>
				</button>
			</p>
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-8 order-2 order-lg-1 produts-sidebar-filter">
                    <div class="filter-widget">
                        <div id="accordion">
                            <div class="card-header cateHedaer">
					        <a class="card-link">
					         <h5>카테고리</h5>
					        </a>
					      </div>
                        <c:forEach var="list" items="${cateList }" varStatus="status">
					    <div class="card" >
					      <div class="card-header">
					        <a class="card-link" data-toggle="collapse" href="#collapse_${status.count}">
					        <input type="hidden" value="${list.categoryId }">
					         <h5>${list.categoryName }</h5>
					        </a>
					      </div>
					      <div id="collapse_${status.count}" class="collapse" data-parent="#accordion">
							 <ul class="list-group">
							 <c:forEach var="cate" items="${list.lowerCateList}">
							  <li class="list-group-item" value="${cate.categoryId }">${cate.categoryName }</li>
							 </c:forEach>   
							  </ul>
					      </div>
					    </div>
					    </c:forEach>
					  </div>
                    </div>
                </div>
                <!--상품정보 시작  -->
                <div class="col-lg-9 order-1 order-lg-2">
                    <div class="product-show-option">
                        <div class="row">
                            <div class="col-lg-7 col-md-7">
                                <div class="select-option">
                                    <select class="sorting" id="sort">
                                        <option value="sellCount desc">판매량 순</option>
                                        <option value="regDate desc">최신 순</option>
                                        <option value="title">상품명 순</option>
                                        <option value="rStar desc">평점 순</option>
                                        <option value="rCount desc">리뷰 많은 순</option>
                                        <option value="realPrice desc">가격 높은순</option>
                                        <option value="realPrice">가격 낮은 순</option>
                                    </select>
                                    <select class="sorting" id="pageSize">
                                        <option value="12">12개씩</option>
                                        <option value="24">24개씩</option>
                                        <option value="36">36개씩</option> 
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-5 col-md-5 text-right">
                                <p>전체 결과: <span id="totalCount"></span> </p>
                            </div>
                        </div>
                    </div>
                    <div class="product-list" id="goods_List"></div>
        		<div class="paging_area" id="Pagination"></div>
            	</div>
        		</div>
        	</div>
    </section>
  </div>
      
    <!-- Product Shop Section End -->

 <jsp:include page="/WEB-INF/view/common/footer.jsp"/>
 <jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"/>
 
 <script>
var pageSize = 12;
var pageBlockSize = 10;


$(document).ready(function() {
	
	
	
	// 헤더 메뉴에서 접근
	if('${cateClass}' != null && '${cateClass}' != ''){
		$("#cateClass").val('${cateClass}');
	}
	
	if('${categoryId}' != null  && '${categoryId}' != ''){
		$("#cateId").val('${categoryId}');
	}
	
	if('${serviceType}' != null  && '${serviceType}' != ''){
		$("#serviceType").val('${serviceType}');
	}else{
		$("#serviceType").val('');
	}
	
	//헤더에서 검색
	if('${searchKey}' != null && '${searchKey}' != ''){
		fmain_search();
	}else{	
		flist_goods();
	}
	
	
	$(".cateHedaer").click(function() {
		$("#cateId").val('');
		$("#cateClass").val('');
		flist_goods();
	});
	
	//상위 카테고리 클릭시
	$(".card-link").click(function() {
		let cateClass = $(this).closest("div").find("input").val();
		$("#cateClass").val(cateClass.substring(0,1));
		$("#cateId").val('');
		flist_clean_search();
		flist_goods();
	});
	
	//하위 카테고리 클릭시
	$(".list-group").children().click(function() {
		let cateId = $(this).val();
		$("#cateId").val(cateId);
		$("#cateClass").val('');
		flist_clean_search();
		flist_goods();
		});
	//보기 갯수
	$("#pageSize").change(function(){
		pageSize = $("#pageSize").val();
		flist_goods();
	});
	//정렬
	$("#sort").change(function(){
		flist_goods();
	});
	//검색버튼 
	$("#btnSearch").click(function(){
		flist_goods();
	});
	
});

/** 상품 목록 조회 */
function flist_goods(currentPage) {
	currentPage = currentPage || 1;
	
	const searchKey= $("#searchKey").val();
	console.log(searchKey);
 	const searchType=$("#searchType").val();
	const sort =$("#sort").val();
	const serviceType =$("#serviceType").val();
	
	const cateClass=$("#cateClass").val();
	const cateId=$("#cateId").val();
	
	console.log("cateClass:"+cateClass);
	console.log("cateId:"+cateId);
	
	var param = {
			currentPage : currentPage,
			pageSize:pageSize,
			cateClass:cateClass,
			cateId:cateId,
			searchType:searchType,
			searchKey:searchKey,
			sort:sort,
			serviceType:serviceType
	}

	var resultCallback = function(data) {
		$("#mainSearchKey").val('');
		flist_goods_result(data, currentPage);
	};

	callAjax("/book/goodsList.do", "post", "text", true, param,
			resultCallback);
}


function fmain_search(currentPage) {
	currentPage = currentPage || 1;
	
	const searchKey= '${searchKey}';
	console.log(searchKey);
 	const searchType=$("#searchType").val();
	const sort =$("#sort").val();
	
	const cateClass=$("#cateClass").val();
	const cateId=$("#cateId").val();
	
	console.log("cateClass:"+cateClass);
	console.log("cateId:"+cateId);
	
	var param = {
			currentPage : currentPage,
			pageSize:pageSize,
			cateClass:cateClass,
			cateId:cateId,
			searchType:searchType,
			searchKey:searchKey,
			sort:sort 
	}

	var resultCallback = function(data) {
		flist_goods_result(data, currentPage);
	};

	callAjax("/book/goodsList.do", "post", "text", true, param,
			resultCallback);
}

/** 상품 목록 조회 콜백 함수 */
function flist_goods_result(data, currentPage) {
	
	// 기존 목록 삭제
	$("#goods_List").empty();

	// 신규 목록 생성
	$("#goods_List").append(data);

	// 총 개수 추출
	var totalCnt = $("#totalCnt").val();
	console.log("토탈카운트:"+totalCnt);
	//$(".count").text(totalCnt);

	// 페이지 네비게이션 생성
	var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize,'flist_goods');
	$("#Pagination").empty().append(paginationHtml);

	// 현재 페이지 설정
	$("#currentPage").val(currentPage);
	$("#totalCount").text(totalCnt);
}

//검색어 초기화
function flist_clean_search(){
	$("#searchKey").val('');
	$("#mainSearchKey").val('');
	
}

	function goCart(pId) {
		var bookStock=1;
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
	function goBuy(pId) {
		var bookStock = 1;
		
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
	


</script>