<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
                          <span>Bag,kids</span>
                            <h1>Black friday</h1>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
                                incididunt ut labore et dolore</p>
                            <a href="#" class="primary-btn">Shop Now</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="single-hero-items set-bg" data-setbg="${CTX_PATH }/img/index/hero-2.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5">
                          <span>Bag,kids</span>
                            <h1>Black friday</h1>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
                                incididunt ut labore et dolore</p>
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
					<div style="height:400px; overflow: auto;margin-top: -20px">	
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
					<div style="height:400px; overflow: auto;margin-top: -20px">	
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
					<div style="height:400px; overflow: auto;margin-top: -20px">	
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
                        <h2>인기 도서</h2>
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
                    </div>
                    <div class="product-slider owl-carousel" id="divhotGoods">
                </div>
            </div>
        </div>
    </section>
    <!-- Women Banner Section End -->

    <!-- Deal Of The Week Section Begin-->
    <section class="deal-of-week set-bg spad" data-setbg="img/time-bg.jpg">
        <div class="container">
            <div class="col-lg-6 text-center">
                <div class="section-title">
                    <h2>Deal Of The Week</h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed<br /> do ipsum dolor sit amet,
                        consectetur adipisicing elit </p>
                    <div class="product-price">
                        $35.00
                        <span>/ HanBag</span>
                    </div>
                </div>
                <div class="countdown-timer" id="countdown">
                    <div class="cd-item">
                        <span>56</span>
                        <p>Days</p>
                    </div>
                    <div class="cd-item">
                        <span>12</span>
                        <p>Hrs</p>
                    </div>
                    <div class="cd-item">
                        <span>40</span>
                        <p>Mins</p>
                    </div>
                    <div class="cd-item">
                        <span>52</span>
                        <p>Secs</p>
                    </div>
                </div>
                <a href="#" class="primary-btn">Shop Now</a>
            </div>
        </div>
    </section>
    <!-- Deal Of The Week Section End -->

    <!-- Man Banner Section Begin -->
    <section class="man-banner spad">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-8">
                    <div class="filter-control">
                        <ul class="ulCate">
                            <li class="active">Clothings</li>
                            <li>HandBag</li>
                            <li>Shoes</li>
                            <li>Accessories</li>
                        </ul>
                    </div>
                    <div class="product-slider owl-carousel">
                        <div class="product-item">
                            <div class="pi-pic">
                                <img src="img/products/man-1.jpg" alt="">
                                <div class="sale">Sale</div>
                                <div class="icon">
                                    <i class="icon_heart_alt"></i>
                                </div>
                                <ul>
                                    <li class="w-icon active"><a href="#"><i class="icon_bag_alt"></i></a></li>
                                    <li class="quick-view"><a href="#">+ Quick View</a></li>
                                    <li class="w-icon"><a href="#"><i class="fa fa-random"></i></a></li>
                                </ul>
                            </div>
                            <div class="pi-text">
                                <div class="catagory-name">Coat</div>
                                <a href="#">
                                    <h5>Pure Pineapple</h5>
                                </a>
                                <div class="product-price">
                                    $14.00
                                    <span>$35.00</span>
                                </div>
                            </div>
                        </div>
                        <div class="product-item">
                            <div class="pi-pic">
                                <img src="img/products/man-2.jpg" alt="">
                                <div class="icon">
                                    <i class="icon_heart_alt"></i>
                                </div>
                                <ul>
                                    <li class="w-icon active"><a href="#"><i class="icon_bag_alt"></i></a></li>
                                    <li class="quick-view"><a href="#">+ Quick View</a></li>
                                    <li class="w-icon"><a href="#"><i class="fa fa-random"></i></a></li>
                                </ul>
                            </div>
                            <div class="pi-text">
                                <div class="catagory-name">Shoes</div>
                                <a href="#">
                                    <h5>Guangzhou sweater</h5>
                                </a>
                                <div class="product-price">
                                    $13.00
                                </div>
                            </div>
                        </div>
                        <div class="product-item">
                            <div class="pi-pic">
                                <img src="img/products/man-3.jpg" alt="">
                                <div class="icon">
                                    <i class="icon_heart_alt"></i>
                                </div>
                                <ul>
                                    <li class="w-icon active"><a href="#"><i class="icon_bag_alt"></i></a></li>
                                    <li class="quick-view"><a href="#">+ Quick View</a></li>
                                    <li class="w-icon"><a href="#"><i class="fa fa-random"></i></a></li>
                                </ul>
                            </div>
                            <div class="pi-text">
                                <div class="catagory-name">Towel</div>
                                <a href="#">
                                    <h5>Pure Pineapple</h5>
                                </a>
                                <div class="product-price">
                                    $34.00
                                </div>
                            </div>
                        </div>
                        <div class="product-item">
                            <div class="pi-pic">
                                <img src="img/products/man-4.jpg" alt="">
                                <div class="icon">
                                    <i class="icon_heart_alt"></i>
                                </div>
                                <ul>
                                    <li class="w-icon active"><a href="#"><i class="icon_bag_alt"></i></a></li>
                                    <li class="quick-view"><a href="#">+ Quick View</a></li>
                                    <li class="w-icon"><a href="#"><i class="fa fa-random"></i></a></li>
                                </ul>
                            </div>
                            <div class="pi-text">
                                <div class="catagory-name">Towel</div>
                                <a href="#">
                                    <h5>Converse Shoes</h5>
                                </a>
                                <div class="product-price">
                                    $34.00
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 offset-lg-1">
                    <div class="product-large set-bg m-large" data-setbg="img/products/man-large.jpg">
                        <h2>Men’s</h2>
                        <a href="#">Discover More</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Man Banner Section End -->
    
    <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
    <!-- Partner Logo Section End -->
	
<script>

$(document).ready(function() {
	
	flist_rank("bestSeller");
 	flist_rank("recommend");
	flist_rank("newBook"); 
	
	//랭킹 카테고리 선택
	$(".cateSelect").change(function(){
		let service=$(this).attr('id'); 
		console.log("selectId:"+service);
		flist_rank(service);
	});
	
//카테고리 선택 표시	
 $(".ulCate").find("li").click(function(){
	 $(this).siblings().removeClass("active");
	 $(this).addClass("active");
	 let cateClass =$(this).val();
	 let type= $(this).attr('id'); 
	 fdisplay_goods(cateClass,type);
 })	;
	
	

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
	console.log(tableId);
	console.log(rankList);
	
	$(tableId).empty();
	
	
	rankList.forEach(function(item, index){
		tr +=  '<tr>';
		    tr += '<th scope="row" class="text-center"><span class="badge badge-warning" style="color:white">'+(index+1)+'위</span></th>';
		    tr += '<td  class="text-center> <div style="width:30px;height:60px""><img src="'+item.coverSmallUrl+'" style="width:30px;height:60px""></div></td>';
		    tr += '<td><strong>'+item.title+'</strong><br>'+item.author+'</td>';
		tr += '</tr>';
		})
	 
	 console.log(tr);
	$(tableId).append(tr);
	
}

//메인 추천 상품 리스트
function fdisplay_goods(cateClass,type) {
	let pageSize = 12; //보여줄 상품 갯수
	
		var data = {
			 type : type,
			 cateClass : cateClass,
			 pageIndex:0,
			 pageSize:displayCount
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
	let product;
	let mainGoods= data.mainGoods;
	console.log(divId);
	console.log(mainGoods);
	
	$(divId).empty();
	
	
	mainGoods.forEach(function(item, index){
		product+=  '<div class="product-item">';
		product+=   '<div class="pi-pic">'
		product+=   '<img src="img/products/women-1.jpg" alt="">'
		product+=   '<div class="sale">Sale</div>'
		product+=   '</div>'
		product+=   '<ul><li class="quick-view"><a href="#">+ Quick View</a></li></ul></div>'
		product+=   '<div class="pi-text">'
		product+=   ' <h5>Pure Pineapple</h5>'
		product+=   '<div class="product-price">'
		product+=   '$14.00</div></div></div>'
		})
	 
	 console.log(tr);
	$(tableId).append(tr);
	
}





</script>
