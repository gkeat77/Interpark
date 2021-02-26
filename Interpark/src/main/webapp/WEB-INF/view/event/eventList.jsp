<!DOCTYPE html> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/view/common/header.jsp"/>
<jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"/>

<head>
        <meta charset="UTF-8" />
        <title>jQuery UI</title>
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>

        <style>    
        
            /* Default */
            input[type=text],input[type=password]{font-family:"Malgun Gothic","맑은 고딕",Dotum,"돋움",Arial,sans-serif}
            /* *{margin:0;padding:0;font-family:"Malgun Gothic","맑은 고딕",Dotum,"돋움",Arial,sans-serif} */
            *{margin-left:1px;padding:0;font-family:"Malgun Gothic","맑은 고딕",Dotum,"돋움",Arial,sans-serif}
            body{font-size:12px;color:#555;background:transparent;-webkit-user-select:none;-moz-user-select:none;-webkit-text-size-adjust:none;-moz-text-size-adjust:none;-ms-text-size-adjust:none}
            ol,ul{list-style:none} 
            table{table-layout:fixed;width:100%;border-collapse:collapse;border-spacing:0}
            caption{overflow:hidden;width:0;height:0;font-size:0;line-height:0;text-indent:-999em}
            img,fieldset{border:0}
            legend{height:0;visibility:hidden}
            em,address{font-style:normal}
            img{border:0 none;vertical-align:middle}
            a{color:#555;text-decoration:none}
            input,select{margin:0;padding:0;vertical-align:middle}
            button{margin:0;padding:0;font-family:inherit;border:0 none;background:transparent;cursor:pointer}
            button::-moz-focus-inner{border:0;padding:0}
            header,footer,aside,nav,section,article{display:block}

            .clearfix{*zoom:1}
            .clearfix:after{content:"";display:block;clear:both;overflow:hidden}

            /* Search */
            .searchBox{border:none}
            .searchBox tbody th{padding:20px 10px 20px 35px;font-size:14px;font-weight:bold;text-align:left;vertical-align:top;border:none;background:#e6e6e6 }
            .searchBox tbody td{padding:12px 10px 12px 25px;border:none;background-color:#efefef}
        
            .searchDate{overflow:hidden;margin-bottom:10px;*zoom:1}
            .searchDate:after{display:block;clear:both;content:''}
            .searchDate li{position:relative;float:left;margin:0 7px 0 0}
            .searchDate li .chkbox2{display:block;text-align:center}
            .searchDate li .chkbox2 input{position:absolute;z-index:-1}
            .searchDate li .chkbox2 label{display:block;width:72px;height:26px;font-size:14px;font-weight:bold;color:#fff;text-align:center;line-height:25px;text-decoration:none;cursor:pointer;background:#a5b0b6}
            .searchDate li .chkbox2.on label{background:#ec6a6a}
        
            .demi{display:inline-block;margin:0 1px;vertical-align:middle}
            .inpType{padding-left:6px;height:24px;line-height:24px;border:1px solid #dbdbdb}
            .btncalendar{display:inline-block;width:22px;height:22px;background:url(images/btn_calendar.gif) center center no-repeat;text-indent:-999em}


			/*common*/
			a {text-decoration:none;}
			
			.container {width:990px;margin:0 auto;}
			
			
			
			/*탭메뉴 */
			.tab ul{list-style:none;margin:0;padding:0;}
			.tab ul.title li:first-child {margin-left:0;}
			.tab ul.title li {float:left; margin-left:5px;}
			.tab ul.title li a {display:block; background:#00091a;padding:5px 10px; color:#fff; }
			
			.tab ul.title li a.show {background:#0055ff}
			
			.tab ul.title:after {content:""; display:block; clear:both; }
			
			/* .tab ul.panel li{display:none; background:#ccc;height:200px;overflow:hidden; } */
			.tab ul.panel li{display:none; background:#ccc;width: 1000px;height:900px;overflow:hidden; }

        </style>

        <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
        <!-- datepicker 한국어로 -->
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
    
        <script>                

        $(document).ready(function() {

            //datepicker 한국어로 사용하기 위한 언어설정
            $.datepicker.setDefaults($.datepicker.regional['ko']);     
        
            // Datepicker            
            $(".datepicker").datepicker({
                showButtonPanel: true,
                dateFormat: "yy-mm-dd",
                onClose : function ( selectedDate ) {
                
                    var eleId = $(this).attr("id");
                    var optionName = "";

                    if(eleId.indexOf("StartDate") > 0) {
                        eleId = eleId.replace("StartDate", "EndDate");
                        optionName = "minDate";
                    } else {
                        eleId = eleId.replace("EndDate", "StartDate");
                        optionName = "maxDate";
                    }

                    $("#"+eleId).datepicker( "option", optionName, selectedDate );        
                    $(".searchDate").find(".chkbox2").removeClass("on"); 
                }
            }); 

            //시작일.
            /*$('#searchStartDate').datepicker("option","onClose", function( selectedDate ) {    
                // 시작일 datepicker가 닫힐때
                // 종료일의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                $("#searchEndDate").datepicker( "option", "minDate", selectedDate );
                $(".searchDate").find(".chkbox2").removeClass("on");
            });
            */

            //종료일.
            /*$('#searchEndDate').datepicker("option","onClose", function( selectedDate ) {    
                // 종료일 datepicker가 닫힐때
                // 시작일의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
                $("#searchStartDate").datepicker( "option", "maxDate", selectedDate );
                $(".searchDate").find(".chkbox2").removeClass("on");
            });
            */

            $(".dateclick").dateclick();    // DateClick
            $(".searchDate").schDate();        // searchDate
            
        });

        // Search Date
        jQuery.fn.schDate = function(){
            var $obj = $(this);
            var $chk = $obj.find("input[type=radio]");
            $chk.click(function(){                
                $('input:not(:checked)').parent(".chkbox2").removeClass("on");
                $('input:checked').parent(".chkbox2").addClass("on");                    
            });
        };

        // DateClick
        jQuery.fn.dateclick = function(){
            var $obj = $(this);
            $obj.click(function(){
                $(this).parent().find("input").focus();
            });
        }    

        
        function setSearchDate(start){

            var num = start.substring(0,1);
            var str = start.substring(1,2);

            var today = new Date();

            //var year = today.getFullYear();
            //var month = today.getMonth() + 1;
            //var day = today.getDate();
            
            var endDate = $.datepicker.formatDate('yy-mm-dd', today);
            $('#searchEndDate').val(endDate);
            
            if(str == 'd'){
                today.setDate(today.getDate() - num);
            }else if (str == 'w'){
                today.setDate(today.getDate() - (num*7));
            }else if (str == 'm'){
                today.setMonth(today.getMonth() - num);
                today.setDate(today.getDate() + 1);
            }

            var startDate = $.datepicker.formatDate('yy-mm-dd', today);
            $('#searchStartDate').val(startDate);
                    
            // 종료일은 시작일 이전 날짜 선택하지 못하도록 비활성화
            $("#searchEndDate").datepicker( "option", "minDate", startDate );
            
            // 시작일은 종료일 이후 날짜 선택하지 못하도록 비활성화
            $("#searchStartDate").datepicker( "option", "maxDate", endDate );

        }
        
        /*탭메뉴*/
        function test() {
        	// alert('클릭');
	        $('.tab').each(function(i) {
	          // alert('탭 선택');	 
	          var oTab = $(this);
	          var tabIndex = $(this).find('.show').attr('id').match(/\d+$/);	          
	
	          $(this).find('.panel').find('#content-' + tabIndex[0]).show();
	
	          $(this).find('.title li a').click(function() {
	
	            var tabIndex = $(this).attr('id').match(/\d+$/);
	            //alert(tabIndex);
	            
	            oTab.find('.title li a').removeClass('show');
	            $(this).addClass('show');
	
	            oTab.find('.panel li').hide();
	            oTab.find('.panel').find('#content-' + tabIndex[0]).show();
	
	            return false;
	          });
	
	        });
        }

            
        </script>

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

     <form>
         
     <!-- search -->
     <table class="searchBox">
         <caption>조회</caption>
         <colgroup>
             <col width="123px">
             <col width="*">
         </colgroup>
         <tbody>
             <tr>
                 <th>기간검색</th>
                 <td>
                     <ul class="searchDate">
                         <li>
                             <span class="chkbox2">
                                 <input type="radio" name="dateType" id="dateType1" onclick="setSearchDate('0d')"/>
                                 <label for="dateType1">당일</label>
                             </span>
                         </li>
                         <li>
                             <span class="chkbox2">
                                 <input type="radio" name="dateType" id="dateType2" onclick="setSearchDate('3d')"/>
                                 <label for="dateType2">3일</label>
                             </span>
                         </li>
                         <li>
                             <span class="chkbox2">
                                 <input type="radio" name="dateType" id="dateType3" onclick="setSearchDate('1w')"/>
                                 <label for="dateType3">1주</label>
                             </span>
                         </li>
                         <li>
                             <span class="chkbox2">
                                 <input type="radio" name="dateType" id="dateType4" onclick="setSearchDate('2w')"/>
                                 <label for="dateType4">2주</label>
                             </span>
                         </li>
                         <li>
                             <span class="chkbox2">
                                 <input type="radio" name="dateType" id="dateType5" onclick="setSearchDate('1m')"/>
                                 <label for="dateType5">1개월</label>
                             </span>
                         </li>
                         <li>
                             <span class="chkbox2">
                                 <input type="radio" name="dateType" id="dateType6" onclick="setSearchDate('3m')"/>
                                 <label for="dateType6">3개월</label>
                             </span>
                         </li>
                         <li>
                             <span class="chkbox2">
                                 <input type="radio" name="dateType" id="dateType7" onclick="setSearchDate('6m')"/>
                                 <label for="dateType7">6개월</label>
                             </span>
                         </li>                         
                         <button style="  border: 1px solid black; margin-left: 100px; margin-top: 20px;">조회</button>
                     </ul>
                     
                     <div class="clearfix">
                         <!-- 시작일 -->
                         <span class="dset">
                             <input type="text" class="datepicker inpType" name="searchStartDate" id="searchStartDate" >
                             <a href="#none" class="btncalendar dateclick">달력</a>
                         </span>
                         <span class="demi">~</span>
                         <!-- 종료일 -->
                         <span class="dset">
                             <input type="text" class="datepicker inpType" name="searchEndDate" id="searchEndDate" >
                             <a href="#none" class="btncalendar dateclick">달력</a>
                         </span>
                     </div>    
                 </td>
             </tr>

         <tbody>
     </table>
     </form>
     
	 <div  id="" class="" onclick="test()">

		  <div class="tab">
		    <ul class="title">
		      <li><a href="#" class="show" id="tab-1">전체</a></li>
		      <li><a href="#" id="tab-2">탭메뉴</a></li>
		      <li><a href="#" id="tab-3">탭메뉴</a></li>
		    </ul>
		     <p class="conTitle mt50 text-center">
				<input type="text"  class="form-control sInput" id="searchKey" name="searchKey" onKeyDown="if(event.keyCode == 13) flist_goods()">
				<button type="button" id="btnSearch" class="btn sBtn">
					<span>검색</span>
				</button>
			</p>  
		    <ul class="panel">
		      <li id="content-1">
		      			탭 내용1
		      	        <div class="" style="margin-left:10px;border-leftt: 10px">
					       	<div class="product-list" id="event_List"></div>            	
				       	</div>
		      	
		      	</li>
		      <li id="content-2">탭 내용2</li>
		      <li id="content-3">탭 내용3</li> 
		    </ul>
		  </div>
	</div>
		
	<!-- Product Shop Section Begin -->
    <input type="hidden" id="cateId">
    <input type="hidden" id="cateClass">

  </div>
      
    <!-- Product Shop Section End -->
