<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="ko">
<head>
<title>!!!!</title>    
<jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"></jsp:include>
</head>
<script>
$(document).ready(function() {
	//버튼 이벤트 등록
	$('.btn').click(function(e) {
		e.preventDefault();
		var btnId = $(this).attr('id');

		switch (btnId) {
		case 'btnSearch':
			$("#action").val("search");
			fsearch_book();
			break;
		case 'btnGetInfo':
			$("#action").val("service");
			flist_book();
			break;	
		}
	});
	
	var msg="${msg}";
	console.log("msg:"+msg);
	if(msg !=''){alert(msg)};
	
});
	/** 도서 검색  */
	function fsearch_book(currentPage) {
			currentPage = currentPage || 1;
			const service = "search";
			const queryType =$("#queryType").val();
			const query = $("#query").val();
			const searchTarget=$("#searchTarget").val();

		var param = {
			service : service,
			query : query,
			queryType : queryType,
			start : currentPage,
			searchTarget:searchTarget
		}

		var resultCallback = function(data) {
			flist_book_result(data, currentPage);
		};

		callAjax("/book/search.do", "post", "text", true, param,
				resultCallback);
	}
	
	/** 도서 목록 조회 */
	function flist_book(currentPage) {
		currentPage = currentPage || 1;
		const service = $("#service").val();
		const categoryId = $("#categoryId").val();
	
		var param = {
			service : service,
			categoryId : categoryId,
			start : currentPage
		}

		var resultCallback = function(data) {
			flist_book_result(data, currentPage);
		};

		callAjax("/book/search.do", "post", "text", true, param,
				resultCallback);
	}

	/** 책 목록 조회 콜백 함수 */
	function flist_book_result(data, currentPage) {
		
		const action = $("#action").val(); 
		let service = null;
		
		if(action =="search"){
			service ='fsearch_book'; 
		}else{
			service ='flist_book';
		}
		console.log(service);
		
		// 기존 목록 삭제
		$('#book_list').empty();

		// 신규 목록 생성
		$('#book_list').append(data);

		// 총 개수 추출
		var totalCnt = $("#totalCnt").val();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCnt, 10, 10,service);
		$("#Pagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage").val(currentPage);
	}
	
 	function selectBook(itemId,title){
		let select =confirm(
				"상품번호: "+itemId+
				"\n제목: "+title+
				"\n선택하시겠습니까?");
		if(select){
			location.href="/book/select.do?query="+itemId;
		}
 	};

</script>
<body>
<input type="hidden" id="action"> 
	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
  <div class="breacrumb-section">
<div class="container">
		<select id="service">
			<option selected="selected">서비스 선택</option>
			<option value="bestSeller">베스트셀러</option>
			<option value="recommend">추천도서</option>
			<option value="newBook">신간</option>
		</select> 
		<select id="categoryId">
			<option selected="selected">카테고리 선택</option>
			<c:forEach items="${cateList }" var="list">
			<option value="${list.categoryId }">${list.categoryName }</option>
			</c:forEach>
		</select>
		 <button type="button" id="btnGetInfo" class="btn"><span>조회</span></button>	
</div>
	<div class="container">
		<select id="searchTarget">
			<option selected="selected" value="book">국내도서</option>
			<option value="foreign">외국도서</option>
			<option value="cd">음반</option>
			<option value="dvd">DVD</option>
		</select>  
		<select id="queryType">
			<option selected="selected" value="all">전체</option>
			<option value="title">제목</option>
			<option value="author">저자</option>
			<option value="publisher">출판사</option>
			<option value="isbn">isbn</option>
			<option value="productNumber">상품번호</option>
		</select>
	<input type="text" id="query" name="query">
	<button type="button" id="btnSearch" class="btn"><span>검색</span></button>	
	</div>
</div>
	<section class="shopping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="cart-table">
                        <table class="table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th>이미지</th>
                                    <th>정보</th>
                                </tr>
                            </thead>                        
                            <tbody id="book_list"></tbody>                          
                        </table>
					</div>
	 	            <div class="paging_area" id="Pagination"></div>
                </div>
            </div>
        </div>
        
    </section>
   
   <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
	

</body>

</html>