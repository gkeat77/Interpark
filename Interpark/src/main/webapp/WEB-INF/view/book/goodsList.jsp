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
		case 'btnAll':
			flist_clean_search();
			flist_goods();
			break;
		case 'btnSell':
			flist_clean_search();
			$("#classify").val('sell');
			flist_goods();
			break;
		case 'btnNoSell':
			flist_clean_search();
			$("#classify").val('nosell');
			flist_goods();
			break;	
		case 'btnDisplay':
			flist_clean_search();
			$("#classify").val('display');
			flist_goods();
			break;
		case 'btnNoDisplay':
			flist_clean_search();
			$("#classify").val('nodisplay');
			flist_goods();
			break;		
		case 'btnNostock':
			flist_clean_search();
			$("#classify").val('noStock');
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
		const classify =$("#classify").val();
		
		var param = {
				currentPage : currentPage,
				pageSize:pageSize,
				searchType:searchType,
				searchKey:searchKey,
				classify:classify
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
		$("#goods_list").empty();

		// 신규 목록 생성
		$("#goods_list").append(data);

		// 총 개수 추출
		var totalCnt = $("#totalCnt").val();
		console.log("토탈카운트:"+totalCnt);

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize,'flist_goods');
		$("#Pagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage").val(currentPage);
	}
	
	//검색어 초기화
	function flist_clean_search(){
		$("#classify").val('');
		$("#searchKey").val('');
	}
	// 상품 선택
 	function selectBook(pId){
			location.href="/book/goodsDetail.do?pId="+pId;
 	};
	
	
</script>
<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
<input type="hidden" id="classify"> 
	<div class="container">
	<section class="shopping-cart spad">
	<div class="nav-item" style="margin-bottom:20px">
                <nav class="nav-menu mobile-menu">
                    <ul>
                        <li><a class="btn" id="btnAll">전체</a></li>
                        <li><a>판매상태</a>
                        	 <ul class="dropdown">
                        	    <li><a class="btn" id="btnSell">판매중</a></li>
                                <li><a class="btn" id="btnNoSell">판매중지</a></li>
                            </ul>
                        </li>
                         <li><a>전시상태</a>
                        	 <ul class="dropdown">
                        	    <li><a class="btn" id="btnDisplay">전시중</a></li>
                                <li><a class="btn" id="btnNoDisplay">비노출</a></li>
                            </ul>
                        </li>
                        <li><a class="btn" id="btnNostock">품절</a></li>
                    </ul>
                </nav>
               </div> 
                	<p class="conTitle mt50">
								<select	id="searchType" name="searchType">
										<option value="all" id="option1" selected="selected">전체</option>
										<option value="title" id="option1">상품명</option>
										<option value="P_ID" id="option1">ID</option>
								</select>
								<input type="text" id="searchKey" name="searchKey" onKeyDown="if(event.keyCode == 13) flist_goods()"> 
							 	<button type="button" id="btnSearch" class="btn btn-warning"><span>검색</span></button>	
							</p>
                    <div class="cart-table">
                    <table class="table-hover table-bordered">
                    	   <colgroup>
							   <col width="10%" />
							   <col width="30%" />
							   <col width="20%" />
							   <col width="20%" />
							   </colgroup>
								<thead> 
									<tr>
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
    	</section>
   </div>
   <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>