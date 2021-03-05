<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">
<head>
<title>인터파크~</title>    
</head>


<body>
	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
    <!-- Breadcrumb Section Begin -->
      <!-- Hero Section Begin -->
    <section class="hero-section">
        <div class="hero-items owl-carousel">
            <div class="single-hero-items set-bg" data-setbg="${CTX_PATH }/img/index/hero-1.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5">
                          <span>씨엘정보기술</span>
                            <h1 style="color:white">미니 인터파크</h1>
                            <p style="color:white">남의 책을 읽는 데 시간을 보내라. <br>남이 고생한 것에 의해 쉽게 자기를 개선할 수 있다. <br>-소크라테스-</p>
                            <a href="#" class="primary-btn">Shop Now</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="single-hero-items set-bg" data-setbg="${CTX_PATH }/img/index/hero-2.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5">
                          <span>씨엘정보기술</span>
                            <h1 style="color:white">미니 인터파크</h1>
                            <p style="color:white">오늘의 나를 있게 한 것은 우리 마을 도서관이었다.  <br>하버드 졸업장보다 소중한 것이 독서하는 습관이다. <br>-빌 게이츠-</p>
                            <a href="#" class="primary-btn">Shop Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Hero Section End -->

    <!-- Banner Section Begin -->
    <div class="banner-section spad">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-4">
                    <div class="single-banner">
                    <table class="table table-warning table-bordered">
						  <thead>
						    <tr>
						      <th scope="col" colspan="3" class="text-center">베스트 셀러 Top 10</th>
						    </tr>
						     <tr>
								<th scope="col" colspan="3" class="text-center">
								<select class="form-control cateSelect" id="bestSeller">
								<c:forEach items="${cateList}" var="list">
								<option value="${list.categoryId }">
								<c:if test="${list.level == 0}"> 
									${list.categoryName }
								</c:if>
								</option>
								</c:forEach>
								</select>
								</th>						   
							</tr>
						</table>
					<div style="height:350px; overflow: auto;margin-top: -20px">	
                    <table class="table table-bordered">
                    	<colgroup>
							<col width="10%">
							<col width="10%">
							<col width="30%">
						</colgroup>	
						  <tbody id="bestSellerTable"></tbody>
						</table>
					</div>	
                    </div>
                </div>
                    <div class="col-lg-4">
                    <div class="single-banner">
                    <table class="table table-info table-bordered">
						  <thead>
						    <tr>
						      <th scope="col" colspan="3" class="text-center">추천도서 Top 10</th>
						    </tr>
						     <tr>
								<th scope="col" colspan="3" class="text-center">
								<select class="form-control cateSelect" id="recommend">
								<c:forEach items="${cateList}" var="list">
								<option value="${list.categoryId }">
								<c:if test="${list.level == 0}"> 
									${list.categoryName }
								</c:if>
								</option>
								</c:forEach>
								</select>
								</th>						   
							</tr>
						</table>
					<div style="height:350px; overflow: auto;margin-top: -20px">	
                    <table class="table table-bordered">
                    	<colgroup>
							<col width="10%">
							<col width="10%">
							<col width="30%">
						</colgroup>	
						  <tbody id="recommendTable"></tbody>
						</table>
					</div>	
                    </div>
                </div>
                    <div class="col-lg-4">
                    <div class="single-banner">
                    <table class="table table-primary table-bordered">
						  <thead>
						    <tr>
						      <th scope="col" colspan="3" class="text-center">신간 Top 10</th>
						    </tr>
						     <tr>
								<th scope="col" colspan="3" class="text-center">
								<select class="form-control cateSelect" id="newBook">
								<c:forEach items="${cateList}" var="list">
								<option value="${list.categoryId }">
								<c:if test="${list.level == 0}"> 
									${list.categoryName }
								</c:if>
								</option>
								</c:forEach>
								</select>
								</th>						   
							</tr>
						</table>
					<div style="height:350px; overflow: auto;margin-top: -20px">	
                    <table class="table table-bordered">
                    	<colgroup>
							<col width="10%">
							<col width="10%">
							<col width="30%">
						</colgroup>	
						  <tbody id="newBookTable"></tbody>
						</table>
						</div>	
                    </div>
                	</div>
                 </div>
              </div>
          </div>
    <!-- Banner Section End -->

    <!-- Women Banner Section Begin -->
    
    <section class="women-banner spad">
             <div class="container-fluid">
            <div class="row">
                <div class="col-lg-3">
                    <div class="product-large set-bg" data-setbg="img/index/hotBook.jpg">
                        <h2>인기도서</h2>
                        <a href="#">Discover More</a>
                    </div>
                </div>
                <div class="col-lg-8 offset-lg-1">
                    <div class="filter-control">
                         <ul class="ulCate" id="hotGoods">
                            <li class="active" value="1">국내도서</li>
                            <li value="2">외국도서</li>
                            <li value="3">DVD</li>
                            <li value="4">음반</li>
                        </ul>
                    </div>
                    <div class="product-slider owl-carousel" id="divhotGoods"></div>
                </div>
            </div>
        </div>
    </section>
    <!-- Women Banner Section End -->

    <!-- Deal Of The Week Section Begin-->
    <section class="deal-of-week set-bg spad" data-setbg="" style="background-color: #fff7e6">
        <div class="container">
        <div class="row">
            <div class="col-lg-6 text-center">
                <div class="section-title">
                    <h2>${limitGoods.title }</h2>
                    <pre class="limitText"> ${limitGoods.description } </pre>
                    <div class="product-price limitText">
                         <fmt:formatNumber value="${limitGoods.realPrice }" type="number" />원
                        <!-- <span>/ HanBag</span> -->
                    </div>
                </div>
                <div class="countdown-timer" id="countdown"></div>
                <a href="#" class="primary-btn" onclick="selectBook(${limitGoods.pId})">사러가기</a>
            </div>
            <div class="col-lg-4 text-center" style="position:relative; height:360px;">
           		<img src="${limitGoods.coverLargeUrl }" style="position:absolute; top:50%; margin-top:-100px; width:250px;height:330px;">
        	</div>
        </div>	
        </div>
      	
    </section>
    <!-- Deal Of The Week Section End -->

    <!-- Man Banner Section Begin -->
    <section class="man-banner spad">
                <div class="container-fluid">
            <div class="row">
                <div class="col-lg-8 offset-lg-1">
                    <div class="filter-control">
                         <ul class="ulCate" id="newGoods">
                            <li class="active" value="1">국내도서</li>
                            <li value="2">외국도서</li>
                            <li value="3">DVD</li>
                            <li value="4">음반</li>
                        </ul>
                    </div>
                    <div class="product-slider owl-carousel" id="divnewGoods"></div>
                </div>
                  <div class="col-lg-3">
                    <div class="product-large set-bg" data-setbg="img/index/newBook.jpg">
                        <h2>신간 도서</h2>
                        <a href="#">Discover More</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Man Banner Section End -->
    
    <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"></jsp:include>
    <!-- Partner Logo Section End -->
<script>

$(document).ready(function() {
	//랭킹함수
	flist_rank("bestSeller");
 	flist_rank("recommend");
	flist_rank("newBook"); 
	//전시 상품
	fdisplay_goods(1,"hotGoods");
	fdisplay_goods(1,"newGoods");
	
	//랭킹 카테고리 선택
	$(".cateSelect").change(function(){
		let service=$(this).attr('id'); 
		flist_rank(service);
	});
	
//카테고리 선택 표시	
 $(".ulCate").find("li").click(function(){
	 $(this).siblings().removeClass("active");
	 $(this).addClass("active");
	 let cateClass =$(this).val();
	 let type= $(this).parent("ul").attr('id'); 
	 fdisplay_goods(cateClass,type);
 })	;
 
	//타이머
	var timerdate ='${limitGoods.sellEnd}'; 
	
	$("#countdown").countdown(timerdate, function(event) {
		$(this).html(event.strftime("<div class='cd-item'><span>%D</span> <p>일</p> </div>" + "<div class='cd-item'><span>%H</span> <p>시</p> </div>" + "<div class='cd-item'><span>%M</span> <p>분</p> </div>" + "<div class='cd-item'><span>%S</span> <p>초</p> </div>"));
	});

	

});

/** 랭킹 목록 조회 */
function flist_rank(service) {
	
	 const categoryId = $("#"+service).val();
	 console.log("categoryId:"+categoryId);
		var data = {
			 service : service,
			 categoryId : categoryId,
			 start:1
		     };
		   $.ajax({
		    url : "rank.do",
		    type : "post",
		    data : data,
		    success : function(data){
		    	flist_rank_result(data,service);
		    },
		    error : function(){
		     alert("fail");
		    }
		   });
}

/** 랭킹 조회 콜백 함수 */
function flist_rank_result(data,service) {
	let tableId= "#"+service+"Table";
	let tr;
	let code;
	let rankList= data.rankList;
	
	$(tableId).empty();
	
	rankList.forEach(function(item, index){
		tr +=  '<tr>';
		    tr += '<th scope="row" class="text-center"><span class="badge badge-warning" style="color:white">'+(index+1)+'위</span></th>';
		    tr += '<td  class="text-center> <div style="width:30px;height:60px""><img src="'+item.coverSmallUrl+'" style="width:30px;height:60px""></div></td>';
		    tr += '<td><strong>'+item.title+'</strong><br>'+item.author+'</td>';
		tr += '</tr>';
		})
	 
	$(tableId).append(tr);
	
}

//메인 추천 상품 리스트
function fdisplay_goods(cateClass,type) {
	console.log("type:"+type);
	let pageSize = 12; //보여줄 상품 갯수
	let sort="";
	
	switch(type){
	case "hotGoods":
		sort="sellCount desc";
		break;
	case "newGoods":
		sort="regDate desc";
		break;	
	}
		var data = {
			 cateClass : cateClass,
			 pageIndex:0,
			 pageSize:pageSize,
			 sort:sort
		     };
		
		   $.ajax({
		    url : "mainGoods.do",
		    type : "post",
		    data : data,
		    success : function(data){
		    	fdisplay_goods_result(data,type);
		    },
		    error : function(){
		     alert("fail");
		    }
		   });
}


function fdisplay_goods_result(data,type) {
	let divId= "#div"+type;
	let product ='';
	let mainGoods= data.mainGoods;
	
	$(divId).empty();
	
	mainGoods.forEach(function(item, index){
		product+=  '<div class="product-item">';
		product+=   '<div class="pi-pic">'
		product+=   '<img src="'+item.coverLargeUrl+'" style="width:150px;height:300px">'
		if(item.saleRate > 1){
			product+=   '<div class="sale">'+item.saleRate+'% 할인</div>'
		}
		product+=   '<ul><li class="quick-view" onclick="selectBook('+item.pId+')"><a href="javascript:void(0);">상세보기</a></li></ul>'
		product+=   '</div>'
		product+=   '<div class="pi-text">'
		product+=   '<a href="javascript:void(0);"> <h5 onclick="selectBook('+item.pId+')">'+item.title+'</h5> </a>'
		product+=   '<div class="product-price">'
		product+=    item.realPrice.toLocaleString()+"원"
		product+=   '</div></div></div>'
		});
	$(divId).append(product);
	
	//슬라이드 재 적용  
	$(divId).trigger('destroy.owl.carousel');
	$(divId).owlCarousel({
        loop: true,
        margin: 25,
        nav: true,
        items: 4,
        dots: true,
        navText: ['<i class="ti-angle-left"></i>', '<i class="ti-angle-right"></i>'],
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true,
        responsive: {
            0: {
                items: 1,
            },
            576: {
                items: 2,
            },
            992: {
                items: 2,
            },
            1200: {
                items: 3,
            }
        }
    });
}

</script>

