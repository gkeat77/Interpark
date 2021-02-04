<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">
<head>
<title>!!!!</title>    
<jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"></jsp:include>
</head>
<script>
var pageSize = 10;
var pageBlockSize = 10;

$(document).ready(function() {
	flist_goods();
	
	//버튼 이벤트 등록
	$('.btn').click(function(e) {
		e.preventDefault();
		var btnId = $(this).attr('id');

		switch (btnId) {
		case 'btnSearch':
			flist_goods();
			break;
		}
	});
});
	
	/** 상품 목록 조회 */
	function flist_goods(currentPage) {
		currentPage = currentPage || 1;
		
		const searchType=$("#searchType").val();
		const searchKey=$("#searchKey").val();
		
		
		var param = {
				currentPage : currentPage,
				pageSize:pageSize,
				searchType:searchType,
				searchKey:searchKey
		}

		var resultCallback = function(data) {
			flist_goods_result(data, currentPage);
		};

		callAjax("/book/goodsList.do", "post", "text", true, param,
				resultCallback);
	}

	/** 책 목록 조회 콜백 함수 */
	function flist_goods_result(data, currentPage) {
		
		// 기존 목록 삭제
		$("#goods_list").empty();

		// 신규 목록 생성
		$("#goods_list").append(data);

		// 총 개수 추출
		var totalCnt = $("#totalCnt").val();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize,'flist_goods');
		$("#Pagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage").val(currentPage);
	}

</script>
<body>
<input type="hidden" id="action"> 
	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

<div class="container">
	<section class="shopping-cart spad">
            <div class="row">
                <div class="col-lg-12">
                	<p class="conTitle mt50">
								<span>검색어 </span>  
								<select	id="searchType" name="searchType">
										<option value="all" id="option1" selected="selected">전체</option>
										<option value="title" id="option1">상품명</option>
										<option value="P_ID" id="option1">ID</option>
								</select>
								<input type="text" id="searchKey" name="searchKey" onKeyDown="if(event.keyCode == 13) flist_goods()"> 
							 	<button type="button" id="btnSearch" class="btn btn-warning"><span>검색</span></button>	
							</p>
                    <div class="cart-table">
                    <table class="table-hover table-bordered" id="listTable">
								<thead>
									<tr>
										<th>상품번호</th>
										<th>이미지</th>
										<th>도서 정보</th>
										<th>상품 정보</th>
										<th>상품 상태</th>
									</tr>
								</thead>
								<tbody id="goods_list"></tbody>
							</table>
					</div>
	 				<div class="paging_area" id="Pagination"></div>
                </div>
            </div>
    </section>
   </div>
   <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
	

</body>

</html>