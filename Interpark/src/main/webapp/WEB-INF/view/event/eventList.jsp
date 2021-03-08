<!DOCTYPE html> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/view/common/header.jsp"/>
<jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"/>

<!-- moment  -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.3.min.js"></script>
      
      <style type="text/css">
            .tabs { margin: 0; padding: 0; }
            .tabs li { list-style-type: none; display: inline-block; background: #c7c7c7; padding: 3px 10px; color: #fff; cursor: pointer; }
            .tabs li:hover { color: #fff; background: #5294de; }
            .tabs li.active { color: #fff; background: #5294de; }
            .panel { display:none; background: #fff; border: 1px solid #c7c7c7; padding: 30px; height: 800px;}
            .panel.active { display:block; }            
			.li {float:left; list-style:none; margin:1px;} /* 가로정렬 */
			.img {padding: 10px;}
      </style>
 </head>

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
	
	$(".tabs li").on("click", function(e) {
		 
        var $contents = $(this).closest("#contents");

        $contents.find(".tabs li.active").removeClass("active");

        $(this).addClass("active");

        $contents.find(".panel.active").hide();
        $contents.find(".panel.active").removeClass("active");

        var panelToShow = $(this).data("panel");

        $("#" + panelToShow).show();
        $("#" + panelToShow).addClass("active");
    });	
	
	   // 전체
  	   $.ajax({
  	    url : "eventListAll.do",
  	    type : "post",
  	    dataType: "json",
  	    success : function(result){
  	    var str = "";
     	$.each(result , function(i){
 			let s_date = new Date(result[i].e_sdate);
 			let e_date = new Date(result[i].e_edate);        			
 			var nDate = moment(s_date).format("YYYY-MM-DD");
 			var mDate = moment(e_date).format("YYYY-MM-DD");
 			str += '<div>';
 				str += '<ul>';
 					str += '<li class="li">';
 						str += '<div><a href="#">'+'<img class="img" src =' + result[i].thumnail_img + ' onclick="getEventDetail('+result[i].e_id+ ');">'+'</a></div>';
 	        			str += '<div><span>'+ result[i].e_title +'</span></div>';
 	        			str += '<div><span>'+ nDate + '-' +mDate+'</span></div>';
 	        			str += '<div><span>'+ result[i].e_content+'</span></div>';
 					str += '</li>';
     			str += '</ul>';
     		str += '</div>';
 		}); 
  	    $(".all").append(str);
  	    },
  	    error : function(){
  	     alert("fail");
  	    }
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
	
	console.log(param);
	console.log(resultCallback);

	callAjax("/event/eventList.do", "post", "text", true, param,
			resultCallback);
}

/** 상품 목록 조회 콜백 함수 */
function flist_goods_result(data, currentPage) {
	//console.log(data);
	
	// 기존 목록 삭제
	$("#event_List").empty();

	// 신규 목록 생성
	$("#event_List").append(data);

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
	
function getEventData(e_title) {
   $.ajax({
   	    url : "eventList.do",
   	    type : "post",
   	    data : {e_title:e_title},
   	    dataType: "json",
   	    success : function(result){
			var str = "";
        	$.each(result , function(i, value){
      			let s_date = new Date(result[i].e_sdate);
      			let e_date = new Date(result[i].e_edate);        			
      			var nDate = moment(s_date).format("YYYY-MM-DD");
      			var mDate = moment(e_date).format("YYYY-MM-DD");
       			str += '<div>';
       				str += '<ul>';
       					str += '<li class="li">';
       					/* str += '<li class="li" data-id=" '+  result[i].e_id + ' "'>'; */      							
       					str += '<li class="li">';
       						str += '<div><a href="#">'+'<img class="img" src =' + result[i].thumnail_img + ' onclick="getEventDetail('+ result[i].e_id+');">'+'</a></div>';
		        			str += '<div><span>'+ result[i].e_title +'</span></div>';
		        			str += '<div><span>'+ nDate + '-' +mDate+'</span></div>';
		        			str += '<div><span>'+ result[i].e_content+'</span></div>';
       					str += '</li>';
           			str += '</ul>';
       			str += '</div>';
        	});      	
        	if(e_title == '문학'){        
        		$(".tx1").empty();
       			$(".tx1").append(str);
        	} else if (e_title == ('인문' || '교양' || '종교' || '예술')) {
        		$(".tx2").empty();
        		$(".tx2").append(str);
        	} else if (e_title == '외국도서') {
        		$(".tx3").empty();
        		$(".tx3").append(str);
        	} else if (e_title == 'eBook') {
        		$(".tx4").empty();
        		$(".tx4").append(str);
        	} else if (e_title == '음반DVD') {
        		$(".tx5").empty();
        		$(".tx5").append(str);
        	} else if (e_title == '중고도서'){
        		$(".tx6").empty();
        		$(".tx6").append(str);
        	}
   	    },
   	    error : function(){
   	     alert("fail");
   	    }
  });        	   
}

// 상세
function getEventDetail(e_id) {
		location.href="/event/eventDetail.do?e_id="+e_id;
}
 
</script>

	<div class="container" id="contents">		
         <ul class="tabs" style="margin: 50px auto 0;">
             <li class="active" data-panel="panel1"><a href="#">전체</a></li>
             <li data-panel="panel2" onclick="getEventData('문학');"><a href="#">문학</a></li>             
             <li data-panel="panel3"><a href="#" onclick="getEventData('인문');">인문/교양/종교/예술</a></li>
             <li data-panel="panel4"><a href="#" onclick="getEventData('외국도서');">외국도서</a></li>
             <li data-panel="panel5"><a href="#" onclick="getEventData('eBook');">eBook</a></li>
             <li data-panel="panel6"><a href="#" onclick="getEventData('음반DVD');">음반DVD</a></li>
             <li data-panel="panel7"><a href="#" onclick="getEventData('중고도서');">중고도서</a></li>
         </ul>
         <div id="panel1" class="panel active"><div class="all"></div></div>
         <div id="panel2" class="panel"><div class="tx1"></div></div>
         <div id="panel3" class="panel"><div class="tx2"></div></div>
         <div id="panel4" class="panel"><div class="tx3"></div></div>
         <div id="panel5" class="panel"><div class="tx4"></div></div>
         <div id="panel6" class="panel"><div class="tx5"></div></div>
         <div id="panel7" class="panel"><div class="tx6"></div></div>         
     </div>
		
	<!-- Product Shop Section Begin -->
    <input type="hidden" id="cateId">
    <input type="hidden" id="cateClass">

  </div>
      
    <!-- Product Shop Section End -->
     <jsp:include page="/WEB-INF/view/common/footer.jsp"/>
