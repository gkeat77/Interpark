<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="ko">
<head>
<title>!!!!</title>    
</head>


<jsp:include page="/WEB-INF/view/common/adminHeader.jsp"></jsp:include>
<input type="hidden" id="action"> 
	<form id="myForm">
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
	<section class="shopping-cart spad">
            <div class="row">
                <div class="col-lg-12">
                    <div class="cart-table">
					<input type="hidden" class="form-control"  value="${book.itemId }" name="query">
					<h2 class="mb-3">도서 정보</h2>
                        <table class="table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th>이미지</th>
                                    <th>책 정보</th>
                                </tr>
                            </thead>                        
                            <tbody id="book_list">
                            <!-- 책 정보 -->
									<tr>
										<td class="cart-pic first-row">
										<img src="${book.coverSmallUrl }" width="90px" height="130px">
										<input type="hidden" class="form-control"  value="${book.coverSmallUrl }" name="coverSmallUrl"> 
										<input type="hidden" class="form-control"  value="${book.coverLargeUrl }" name="coverLargeUrl"> 
										<input type="hidden" class="form-control"  value="${book.isbn }" name="isbn"> 
										</td>
										<td class="cart-title first-row" colspan="2">
										<div class="input-group mb-3 input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><strong>도서ID</strong></span>
											</div>
											<input type="text" class="form-control"  value="${book.itemId }" readonly name="itemId"> 
										</div> 
										<div class="input-group mb-3 input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><strong>제목</strong></span>
											</div>
											<input type="text" class="form-control" value="${book.title}" name="title">
										</div> 
										<div class="input-group mb-3 input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><strong>카테고리명</strong></span>
											</div>
											<input type="text" class="form-control" value="${book.categoryName}" name="categoryName">
										</div> 	
										<div class="input-group mb-3 input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><strong>카테고리ID</strong></span>
											</div>
											<input type="text" class="form-control" value="${book.categoryId}" name="categoryId">
										</div>
										<div class="input-group mb-3 input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><strong>저자</strong></span>
											</div>
											<input type="text" class="form-control" value="${book.author }" name="author">
										</div>
										<div class="input-group mb-3 input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><strong>역자</strong></span>
											</div>
											<input type="text" class="form-control" value="${book.translator }" name="translator">
										</div>
										<div class="input-group mb-3 input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><strong>출판사</strong></span>
											</div>
											<input type="text" class="form-control" value="${book.publisher}" name="publisher">
										</div>
											<div class="input-group mb-3 input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><strong>출판일</strong></span>
											</div>
											<input type="text" class="form-control" value="${book.pubDate}" name="pubDate">
										</div>
										<div class="input-group mb-3 input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><strong>정가</strong></span>
											</div>
											<input type="text" class="form-control" value="${book.priceStandard }" name="priceStandard" style="color: #e6b800;font-weight:700"	 >
										</div>
										<div class="input-group mb-3 input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><strong>유형</strong></span>
											</div>
											<select name="serviceType">
												<option value="">없음</option>
												<option value="bestSeller">베스트셀러</option>
												<option value="recommend">추천도서</option>
												<option value="newBook">신간</option>
											</select>
										</div>
									<!--책정보 끝  -->	      
										</td>
									</tr>
								</tbody>                          
                        </table>
					</div>
                </div>
            </div>
			<h2 class="mb-3">판매정보</h2>
				<div class="form-check-inline mb-3">
					<label class="form-check-label" for="radio1"> 
					<input type="radio" class="form-check-input" id="radio1" checked
					onClick="selectLimit('all')">
					상시 판매
					</label>
				</div>
				<div class="form-check-inline mb-3">
					<label class="form-check-label" for="radio2"> 
					<input type="radio" class="form-check-input" id="radio2"
					onClick="selectLimit('limit')">기간판매
					</label>
				</div>
				<div id="limit">
					<div class="input-group mb-3 input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><strong>판매 시작일 </strong></span>
						</div>
						<input type="date" class="form-control" id="sellStart" name="sellStart">
					</div>
					<div class="input-group mb-3 input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><strong>판매 종료일 </strong></span>
						</div>
						<input type="date" class="form-control" id="sellEnd" name="sellEnd">
					</div>
				</div>
				<div class="input-group mb-3 input-group">
					<div class="input-group-prepend">
						<span class="input-group-text"><strong>판매가</strong></span>
					</div>
					<input type="number" class="form-control" name="salePrice">
				</div>
				<div class="input-group mb-3 input-group">
					<div class="input-group-prepend">
						<span class="input-group-text"><strong>할인율 %</strong></span>
					</div>
					<input type="number" class="form-control" name="saleRate">
				</div>
				<div class="input-group mb-3 input-group">
					<div class="input-group-prepend">
						<span class="input-group-text"><strong>할인 적용가</strong></span>
					</div>
					<input type="number" class="form-control" name="realPrice" readonly>
				</div>
				<div class="input-group mb-3 input-group">
					<div class="input-group-prepend">
						<span class="input-group-text"><strong>적립율 %</strong></span>
					</div>
					<input type="number" min="0" max="100" class="form-control" name="mileageRate" value=5> 
				</div>
					<div class="input-group mb-3 input-group">
					<div class="input-group-prepend">
						<span class="input-group-text"><strong>적립금</strong></span>
					</div>
					<input type="number" class="form-control" name="mileage" readonly> %
				</div>
				<div class="input-group mb-3 input-group">
					<div class="input-group-prepend">
						<span class="input-group-text"><strong>재고 수량</strong></span>
					</div>
					<input type="number" class="form-control" name="stock">
				</div>
				<div class="input-group mb-3 input-group">
					<div class="input-group-prepend">
						<span class="input-group-text"><strong>전시 상태</strong></span>
					</div>
					<select name="display">
						<option selected="selected" value="Y">노출</option>
						<option value="N">비노출</option>
					</select>
				</div>
				<div class="input-group mb-3 input-group">
					<div class="input-group-prepend">
						<span class="input-group-text"><strong>판매 상태</strong></span>
					</div>
					<select name="sellState">
						<option selected="selected" value="Y">판매중</option>
						<option value="N">판매중지</option>
					</select>
				</div>
			<h2 class="mt-10 mb-3">상품 정보</h2>
				<div class="input-group mb-3 input-group textarea">
					<div class="input-group-prepend">
						<span class="input-group-text"><strong>책 소개</strong></span>
					</div>
					<textarea class="form-control" name="description">${book.description }</textarea>
				</div>
				<div class="input-group mb-3 input-group textarea text-center">
					<div class="input-group-prepend">
						<span class="input-group-text"><strong>목차</strong></span>
					</div>
					<textarea class="form-control" name="index"></textarea>
				</div>
				<div class="input-group mb-3 input-group textarea">
					<div class="input-group-prepend">
						<span class="input-group-text"><strong>저자소개</strong></span>
					</div>
					<textarea class="form-control" name="authorInfo"></textarea>
				</div>
				<div class="input-group mb-3 input-group" style="height:100px;" >
					<div class="input-group-prepend">
						<span class="input-group-text"><strong>이미지</strong></span>
					</div>
					<input type="file"  accept="image/*" id="bbs_files_1" name="bbs_files_1" class="form-control" style="height:100px;">
				</div>
		<button type="button" class="btn btn-warning" style="width:100px;" id="regBtn">등록</button>
		</section>
       </div>
   </form>
   <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
   <jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"></jsp:include>
   <script>
$(document).ready(function() {
	$("#limit").hide();
	
	$('#regBtn').click(function(e) {
		registGoods();
	});
	
	//할인 적용가 계산
	$('input[name=salePrice],input[name=saleRate],input[name=mileageRate]').change(function(){
		
		let salePrice= $('input[name=salePrice]').val();
		let saleRate= $('input[name=saleRate]').val();
		let realPrice = salePrice * ((100-saleRate)/100);
		let mileageRate =$('input[name=mileageRate]').val();
		let mileage = realPrice * (mileageRate/100);
		
		if(saleRate >100||mileageRate >100 ){
			alert("할인율이나 적립율이 100%를 넘을수 없습니다.")
			return
		}else{
			$('input[name=realPrice]').val(realPrice);
			$('input[name=mileage]').val(mileage);
		}
	});
	
	
	
});

//상시 or 기간판매 
function selectLimit(time) {
	if(time=="all"){
		$("#limit").hide();
		$("#sellStart").val("");
		$("#sellEnd").val("");
		$("#radio1").prop("checked",true);
		$("#radio2").prop("checked",false);
	}else if(time=="limit"){
		$("#limit").show();
		$("#radio2").prop("checked",true);
		$("#radio1").prop("checked",false);
	}
}

function registGoods(){
	
	var frm = document.getElementById("myForm");
	frm.enctype = 'multipart/form-data';
	var fileData = new FormData(frm);
	
	var resultCallback = function(param) {
		makeProjectCallback(param);
	};
	callAjaxFileUploadSetFormData("/bookAdmin/regist.do", "post", "json", true, fileData, resultCallback);
}

function makeProjectCallback(param){
	alert(param.result);
	location.href="/bookAdmin/regPage.do";
}



</script>
