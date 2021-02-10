<!DOCTYPE html> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"/>
<jsp:include page="/WEB-INF/view/common/header.jsp"/>

<script>
var pageSize = 12;
var pageBlockSize = 10;


$(document).ready(function() {
	flist_book();
	
	//상위 카테고리 클릭시
	$(".card-link").click(function() {
		let cateClass = $(this).closest("div").find("input").val();
		$("#cateClass").val(cateClass.substring(0,1));
		$("#cateId").val('');
		flist_book();
	});
	
	//하위 카테고리 클릭시
	$(".list-group").children().click(function() {
		let cateId = $(this).find("li").val();
		$("#cateId").val(cateId);
		$("#cateClass").val('');
		flist_book();
		});
	
});

/** 상품 목록 조회 */
function flist_book(currentPage) {
	currentPage = currentPage || 1;
	
/* 	const searchType=$("#searchType").val();
	const searchKey=$("#searchKey").val();
	const classify =$("#classify").val();
	const sort =$("#sort").val(); */
	
	const cateClass=$("#cateClass").val();
	const cateId=$("#cateId").val();
	
	console.log("cateClass:"+cateClass);
	console.log("cateId:"+cateId);
	
	var param = {
			currentPage : currentPage,
			pageSize:pageSize,
			cateClass:cateClass,
			cateId:cateId
/* 			searchType:searchType,
			searchKey:searchKey,
			classify:classify,
			sort:sort */
	}

	var resultCallback = function(data) {
		flist_book_result(data, currentPage);
	};

	callAjax("/book/goodsList.do", "post", "text", true, param,
			resultCallback);
}

/** 상품 목록 조회 콜백 함수 */
function flist_book_result(data, currentPage) {
	
	// 기존 목록 삭제
	$("#goods_List").empty();

	// 신규 목록 생성
	$("#goods_List").append(data);

	// 총 개수 추출
	var totalCnt = $("#totalCnt").val();
	console.log("토탈카운트:"+totalCnt);
	//$(".count").text(totalCnt);

	// 페이지 네비게이션 생성
	var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize,'flist_book');
	$("#Pagination").empty().append(paginationHtml);

	// 현재 페이지 설정
	$("#currentPage").val(currentPage);
}



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
	<p class="conTitle mt50">
		<select id="searchType" name="searchType" class="form-control">
			<option value="all" id="option1" selected="selected">전체</option>
			<option value="title" id="option1">상품명</option>
			<option value="P_ID" id="option1">ID</option>
		</select> <input type="text"  class="form-control" id="searchKey" name="searchKey" onKeyDown="if(event.keyCode == 13) flist_goods()">
		<button type="button" id="btnSearch" class="btn btn-warning">
			<span>검색</span>
		</button>
	</p>


	<!-- Product Shop Section Begin -->
    <input type="hidden" id="cateId">
    <input type="hidden" id="cateClass">
    <section class="product-shop spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-8 order-2 order-lg-1 produts-sidebar-filter">
                    <div class="filter-widget">
                        <div id="accordion">
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
                    <div class="filter-widget">
                        <h4 class="fw-title">Price</h4>
                        <div class="filter-range-wrap">
                            <div class="range-slider">
                                <div class="price-input">
                                    <input type="text" id="minamount">
                                    <input type="text" id="maxamount">
                                </div>
                            </div>
                            <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                                data-min="33" data-max="98">
                                <div class="ui-slider-range ui-corner-all ui-widget-header"></div>
                                <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                                <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                            </div>
                        </div>
                        <a href="#" class="filter-btn">Filter</a>
                    </div>
                    <div class="filter-widget">
                        <h4 class="fw-title">Tags</h4>
                        <div class="fw-tags">
                            <a href="#">Towel</a>
                            <a href="#">Shoes</a>
                            <a href="#">Coat</a>
                            <a href="#">Dresses</a>
                            <a href="#">Trousers</a>
                            <a href="#">Men's hats</a>
                            <a href="#">Backpack</a>
                        </div>
                    </div>
                </div>
                <!--상품정보 시작  -->
                <div class="col-lg-9 order-1 order-lg-2">
                    <div class="product-show-option">
                        <div class="row">
                            <div class="col-lg-7 col-md-7">
                                <div class="select-option">
                                    <select class="sorting">
                                        <option value="">Default Sorting</option>
                                    </select>
                                    <select class="p-show">
                                        <option value="">Show:</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-5 col-md-5 text-right">
                                <p>Show 01- 09 Of 36 Product</p>
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