<!DOCTYPE html> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/view/common/header.jsp"/>
<jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"/>

<script>
var pageSize = 12;
var pageBlockSize = 10;


$(document).ready(function() {
	flist_goods();
	
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
	
 	const searchType=$("#searchType").val();
	const searchKey=$("#searchKey").val();
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
}
// 상품 선택
	function selectBook(pId){
		location.href="/book/goodsDetail.do?pId="+pId;
	};




</script>
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
    <section class="product-shop spad">
        <div class="container">

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
					<div class="row">
					  	<input type="hidden" value="${member}" id="session"/>
						<c:forEach var="list" items="${eventList }">
							<div class="col-lg-4 col-sm-6">
								<div class="product-item">
									<div class="pi-pic">
										<span>"${list.e_title}"</span>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
        		</div>
        	</div>
    </section>
  </div>
      
    <!-- Product Shop Section End -->
