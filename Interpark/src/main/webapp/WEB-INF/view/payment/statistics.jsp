<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

	<jsp:include page="/WEB-INF/view/common/adminHeader.jsp"></jsp:include>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		
	<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/bootstrap-datepicker.js"></script>
	<style>
		/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
		.ui-datepicker-trigger{cursor: pointer;}
		/*datepicer input 롤오버 시 손가락 모양 표시*/
		.hasDatepicker{cursor: pointer;}
		
		
		.ui-datepicker-trigger {
			visibility: hidden;
		}
		
		
		  
		  /* dateForm */
		  
		  .dateForm {
		    padding-left: 180px;
		  }
		  	
	</style>
		
    <!-- Breadcrumb Section Begin -->
     <div class="breacrumb-section">
        <div class="container">
           <!-- aside -->
            <jsp:include page="/WEB-INF/view/common/aside.jsp"></jsp:include>
        </div>
    </div>
    
    <c:choose>
    <c:when test="${empty member}">
    
    	<script>
    		alert("로그인 먼저 해주세요");
    		location.href="/login/login.me";
    	</script>

    </c:when>
    <c:otherwise>
    
    <section class="contact-section spad">
    
   
        <div class="container">

            <form class="checkout-form" name="form">
                <div class="row">
                	<!--  
                    <div class="checkout-content">
                        <input type="text" placeholder="Enter Your Coupon Code">
                    </div>
                    -->
                    <div class="dateForm">
                    <h4>날짜</h4>
                    </div>
                    <div class="col-lg-12">
                            <label for="fir"></label>
                            <div class="dateForm">
                             From: <input type="text" id="datepicker" class="dataP" style="width:200px;">
							 To: <input type="text" id="datepicker2" class="dataP" style="width:200px;">
							 </div>
							<button type="button"  onclick="goStatistics()" class="site-btn place-btn" style="display: block; margin: 0 auto;">검색</button>

        
                    </div>
                                        
                	<!--  -->
                	<div class="col-lg-12">
                	
                		<div class="col-lg-12">
                                <label for="fir"></label>
                                
                                <div style="width:100%;">
							        <canvas id="canvas"></canvas>
							    </div>
							    
							    <div style="width:100%;">
							        <canvas id="canvas2"></canvas>
							    </div>
                        </div>
                        
                        
                	</div>
                	
                	
                </div>
            </form>
        </div>
        
    </section>
    
    </c:otherwise>
    </c:choose>
    
    <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
    <!-- Partner Logo Section End -->

	<script>
	var total = [];
	var total2 = [];
	var days = [];
	var days2 = [];
	
	var daysAry = new Array();
	var totalAry = new Array();

	
	ininChart();
	
	$(document).ready(function() {
		
		document.getElementById("canvas2").hidden = true;
		
		//모든 datepicker에 대한 공통 옵션 설정
        $.datepicker.setDefaults({
            dateFormat: 'yy-mm-dd' //Input Display Format 변경
            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
            ,changeYear: true //콤보박스에서 년 선택 가능
            ,changeMonth: true //콤보박스에서 월 선택 가능                
            ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
            ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
            ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
            ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
            ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
            ,minDate: new Date('2020-01-01')
            ,maxDate: new Date('2021-12-31')                    
        });
		
	

        //input을 datepicker로 선언
        $("#datepicker").datepicker();                    
        $("#datepicker2").datepicker();
        
        //From의 초기값을 오늘 날짜로 설정
        $('#datepicker').datepicker('setDate', '-1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
        //To의 초기값을 내일로 설정
        $('#datepicker2').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
        
        
        	
        	
	}); // onLoad End
	
	// ------------------------
	// comm
	// ------------------------
	
	
	
	function removeComma(str)
	{
		n = parseInt(str.replace(/,/g,""));
		return n;
	}
	

	function comma(num){
	    var len, point, str; 
	    num = num + ""; 
	    point = num.length % 3 ;
	    len = num.length; 
	   
	    str = num.substring(0, point); 
	    while (point < len) { 
	        if (str != "") str += ","; 
	        str += num.substring(point, point + 3); 
	        point += 3; 
	    } 
	    return str;
	}
	
	// date -> yyyy-mm-dd
	 function getFormatDate(date){
         var year = date.getFullYear();
         var month = (1 + date.getMonth());
         month = month >= 10 ? month : '0' + month;
         var day = date.getDate();
         day = day >= 10 ? day : '0' + day;
         return year + '-' + month + '-' + day;
     }

	


	
	// ------------------------
	// function
	// ------------------------

	
	
	
	
	// chart
	new Chart(document.getElementById("canvas"), {
        type: 'line',
        data: {
            labels: days,
            datasets: [{
                label: '매출',
                data: total
                ,
                borderColor: "rgba(255, 201, 14, 1)",
                backgroundColor: "rgba(255, 201, 14, 0.5)",
                fill: true,
                lineTension: 0
            }]
        },
        options: {
            responsive: true,
            title: {
                display: true,
                text: '라인 차트 테스트'
            },
            tooltips: {
                mode: 'index',
                intersect: false,
            },
            hover: {
                mode: 'nearest',
                intersect: true
            },
            scales: {
                xAxes: [{
                    display: true,
                    scaleLabel: {
                        display: true
                        //labelString: 'x축'
                    }
                }],
                yAxes: [{
                    display: true,
                    ticks: {
                        suggestedMin: 0,
                        beginAtZero: true,
                        callback: function(value, index) {
                            //if(value.toString().length > 8) return (Math.floor(value / 100000000)).toLocaleString("ko-KR") + "억";
                            //else if(value.toString().length > 4) return (Math.floor(value / 10000)).toLocaleString("ko-KR") + "만";
                            //else return value.toLocaleString("ko-KR");
                            if (value ==1){
                            } 
                            else return value.toLocaleString("ko-KR");
                            // y축 콤마 처리
                          }
                    },
                    scaleLabel: {
                        display: true
                        //labelString: 'y축'
                    }
                }]
            }
        }
    });
	
	

	function ininChart() {
		<c:forEach items="${days}" var="item1">
			daysAry.push("${item1}");
		</c:forEach>
		
		<c:forEach items="${total}" var="item2">
			totalAry.push("${item2}");
		</c:forEach>

		for (var i = 0; i < daysAry.length; i++) {
			total[i] = totalAry[i];
			days[i] = daysAry[i];
		}
		
	}
	function getTotal(total, day) {
		total2=total;
		days2=day;
	}
	
	
	function goStatistics() {

		// new
		let date1 = new Date();
		// to
		var pickerDate =$('#datepicker2').val();
		let date2 = new Date(pickerDate);
		// from 
		var pickerFrom =$('#datepicker').val();
		let date3 = new Date(pickerFrom);
		// 차이
		var dateDiff = Math.ceil((date2.getTime()-date3.getTime())/(1000*3600*24));
		
		if(date1<date2){	// to값이 현재날짜보다 클 경우
			alert("날짜를 확인해 주세요");
			$('#datepicker2').val(getFormatDate(date1));
		}else if(date3 > date2) {
			alert("from이 더크다");
		}else if(date3.getTime() == date2.getTime()) {
			alert("같다");	
		}else if(dateDiff > 46) {
			alert("45일을 초과할 수 없습니다");
		}else {
			
			document.getElementById("canvas2").hidden = false;
			document.getElementById("canvas").hidden = true;
			
			
			var fromDt = $('#datepicker').val();
			var toDt = $('#datepicker2').val();
			var data = {
					fromDt : fromDt
					, toDt : toDt 
				     };
				   
				   $.ajax({
				    url : "/goStatistics.do",
				    type : "post",
				    data : data,
				    success : function(result){
						if(result.resultMsg == "success") {
							//location.reload(true);	// 삭제 후 초기화
							getTotal(result.total2, result.days2);
							goChart2();
						}
				    },
				    error : function(){
				     alert("fail");
				    }
				   });
		}
	}
	
	
	
	function goChart2() {
		// chart2
		new Chart(document.getElementById("canvas2"), {
	        type: 'line',
	        data: {
	            labels: days2,
	            datasets: [{
	                label: '매출',
	                data: total2
	                ,
	                borderColor: "rgba(255, 201, 14, 1)",
	                backgroundColor: "rgba(255, 201, 14, 0.5)",
	                fill: true,
	                lineTension: 0
	            }]
	        },
	        options: {
	            responsive: true,
	            title: {
	                display: true,
	                text: 'Interpark'
	            },
	            tooltips: {
	                mode: 'index',
	                intersect: false,
	            },
	            hover: {
	                mode: 'nearest',
	                intersect: true
	            },
	            scales: {
	                xAxes: [{
	                    display: true,
	                    scaleLabel: {
	                        display: true
	                        //labelString: 'x축'
	                    }
	                }],
	                yAxes: [{
	                    display: true,
	                    ticks: {
	                        suggestedMin: 0,
	                        beginAtZero: true,
	                        callback: function(value, index) {
	                            //if(value.toString().length > 8) return (Math.floor(value / 100000000)).toLocaleString("ko-KR") + "억";
	                            //else if(value.toString().length > 4) return (Math.floor(value / 10000)).toLocaleString("ko-KR") + "만";
	                            //else return value.toLocaleString("ko-KR");
	                            if (value ==1){
	                            } 
	                            else return value.toLocaleString("ko-KR");
	                            // y축 콤마 처리
	                          }
	                    },
	                    scaleLabel: {
	                        display: true
	                        //labelString: 'y축'
	                    }
	                }]
	            }
	        }
	    });
	
	
	}
	</script>
</html>


