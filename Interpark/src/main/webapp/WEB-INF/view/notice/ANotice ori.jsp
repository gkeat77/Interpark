<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="${CTX_PATH}/js/summernote/summernote-ko-KR.js"></script>

<script type="text/javascript">
	var currentPage;
	
	// 그룹코드 페이징 설정
	var pageSize = 5;
	var pageBlockSize = 5;
	
	$(document).ready(function(){
		fAdmList();
		fTutList();
		
		$('#notice_con').summernote({
			  height: 250,                 // 에디터 높이
			  minHeight: null,             // 최소 높이
			  maxHeight: null,             // 최대 높이
			  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
			  lang: "ko-KR",					// 한글 설정
			  placeholder: '내용을 입력하세요.',	//placeholder 설정
			  toolbar: [ //상단 툴바
			            // [groupName, [list of button]]
			            ['style', ['bold', 'italic', 'underline', 'clear']],
			            ['font', ['strikethrough']],
			            ['fontsize', ['fontsize']],
			            ['color', ['color']],
			            ['para', ['ul', 'ol', 'paragraph']],
			            ['height', ['height']]
			          ]
		});
	});

	//관리자 공지사항 리스트 데이터 받아오기
	function fAdmList(currentPage) {
		
		var adm_type = $("#adm_type").val();
		var adm_key = $("#adm_key").val();
		
		currentPage = currentPage || 1;

		var param = {
			currentPage : currentPage,
			pageSize : pageSize,
			adm_type : adm_type,
			adm_key : adm_key
		}

		var resultCallback = function(data) {
			fAdmResult(data, currentPage);
		};

		//Ajax실행 방식
		//callAjax("Controller Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		// json으로 보내서 오류가 났음 , -> text
		callAjax("/notice/admNoticeList.do", "post", "text", true, param,resultCallback);
	}
	
	//관리자 공지사항 리스트 데이터 출력
	function fAdmResult(data, currentPage) {

		console.log("값가져오ㅏ ㅇㅅㅇ" + data);
		
		// 기존 목록 삭제
		$('#admNoticeList').empty();
		//$('#listLec').find("tr").remove() 

		var $data = $($(data).html());

		// 신규 목록 생성
		var $admNoticeList = $data.find("#admNoticeList");
		$("#admNoticeList").append($admNoticeList.children());

		// 총 개수 추출
		var $admNoticeCnt = $data.find("#admNoticeCnt");
		var admNoticeCnt = $admNoticeCnt.text();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, admNoticeCnt,
				pageSize, pageBlockSize, 'fAdmList');
		
		//alert(paginationHtml);
		$("#admPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#admCurrentPage").val(currentPage);

	}
	
	//강사 공지사항 리스트 데이터 받아오기
	function fTutList(currentPage) {
		var tut_type = $("#tut_type").val();
		var tut_key = $("#tut_key").val();

		
		currentPage = currentPage || 1;

		var param = {
			currentPage : currentPage,
			pageSize : pageSize,
			tut_type : tut_type,
			tut_key : tut_key
		}

		var resultCallback = function(data) {
			fTutResult(data, currentPage);
		};

		//Ajax실행 방식
		//callAjax("Controller Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		// json으로 보내서 오류가 났음 , -> text
		callAjax("/notice/tutNoticeList.do", "post", "text", true, param,resultCallback);
	}
	
	//강사 공지사항 리스트 데이터 출력
	function fTutResult(data, currentPage) {

		//alert(data);
		console.log("gdgd" + data);

		// 기존 목록 삭제
		$('#tutNoticeList').empty();
		//$('#listLec').find("tr").remove() 

		var $data = $($(data).html());

		// 신규 목록 생성
		var $tutNoticeList = $data.find("#tutNoticeList");
		$("#tutNoticeList").append($tutNoticeList.children());

		// 총 개수 추출
		var $tutNoticeCnt = $data.find("#tutNoticeCnt");
		var tutNoticeCnt = $tutNoticeCnt.text();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, tutNoticeCnt,
				pageSize, pageBlockSize, 'fTutList');
		
		//alert(paginationHtml);
		$("#tutPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#tutCurrentPage").val(currentPage);

	}
	
	//관리자 공지사항 상세조회 모달창 띄우기
	function fPopModalAdm( notice_id ) {
		   
		
       var param = {
    		   notice_id : notice_id
           }
       var resultCallback = function(data) {
         $('#layer1').empty().append(data);
         gfModalPop("#layer1");
       };
       callAjax("/notice/admDetail.do", "post", "text", true, param, resultCallback);
	   }
	
	//강사 공지사항 상세조회 모달창 띄우기
	function fPopModalTut( notice_id ) {
		   
		
	       var param = {
	    		   notice_id : notice_id
	           }
	       var resultCallback = function(data) {

	         $('#layer1').empty().append(data);
	         gfModalPop("#layer1");
	       };
	       callAjax("/notice/tutDetail.do", "post", "text", true, param, resultCallback);
	   }

	//공지사항 작성하기
	function fWrite(){
	   /*  $("#notice_tit").val("");
	    $("#notice_con").val(""); */
	    
	 	var notice_tit = $("#notice_tit").val();
		var notice_con = $("#notice_con").val();   
		notice_con = notice_con.replace(/(?:\r\n|\r|\n)/g, '<br>');
		
	
		if(notice_tit != null && notice_con != null && notice_con != '' && notice_tit != ''){
         var param = {
        		  notice_tit : notice_tit
        		 ,notice_con : notice_con
         	}
        
         var resultCallback = function(param) {
        	 fModalResult(param);
         	};
         
         callAjax("/notice/noticeWrite.do", "post", "json", true, param, resultCallback);
		}
	
		else{alert("작성이 완료되지 않았습니다.")}
      }
	  
	
	//공지사항 삭제하기 
	function fDelete(notice_id){
		
		var param = {
			notice_id : notice_id
			}
		   
		var resultCallback = function(data) {
			fModalResult(data);
		   }
		
		callAjax("/notice/noticeDelete.do", "post", "json", true, param, resultCallback);
	   }
	

	function fUpdateResult(notice_id) {

		var tit = $("#re_tit").val();
		var con = $("#re_con").val();
		con = con.replace(/(?:\r\n|\r|\n)/g, '<br>');
		if (tit != null && con != null && con != '' && tit != '') {
			var param = {
				notice_id : notice_id,
				notice_tit : tit,
				notice_con : con
			}
			var resultCallback = function(data) {
				fModalResult(data);
			}
			callAjax("/notice/noticeUpdate.do", "post", "json", true, param,
					resultCallback);
		}

		else {
			alert("작성이 완료되지 않았습니다.");
		}
	}

	//모달 결과 
	function fModalResult(data) {

		if (data.result == "게시글 작성을 성공하였습니다." || data.result == "게시글을 삭제하였습니다."
				|| data.result == "게시글을 수정하였습니다.") {

			// 모달 팝업
			gfCloseModal();
			alert(data.result);
			fAdmList();
			fTutList();

			$("#notice_tit").val("");
			$("#notice_con").val("");

		} else {
			gfCloseModal();
			alert(data.result);
		}

	}
</script>
</head>
<body>
<form id="myForm">
	<div id="mask"></div>
	<div id="wrap_area">
	<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
	<div id="container">
		<ul>
			<li class="lnb"><jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include></li>
			<li class="contents">
				<h3 class="hidden">contents 영역</h3>
				<div class="content">
					<p class="Location">
						<a href="" class="btn_set home">메인으로</a> 
						<a href="" class="btn_nav">학습지원</a> <span class="btn_nav bold">공지사항</span>
						<a href="" class="btn_set refresh">새로고침</a>
					</p>
				
				<!-- 관리자 공지사항 리스트 조회  -->
				<div class="divComGrpCodList">
					<p class="conTitle">               
					  <span>관리자 공지사항</span>
 					  <span class="fr"> 
 						 <span>
					    	<select id="adm_type" style="width: 90px;">
                               <option value="all" selected="selected">제목+내용</option>
                               <option value="title">제목</option>
                               <option value="content">내용</option>
                            </select>
                         </span> 
                         <input type="text" id="adm_key" style="width: 200px; height: 28px;" onKeyDown="if(event.keyCode == 13) javascript:fAdmList()">
 						 <a class="btnType blue" href="javascript:fAdmList()" ><span id="searchEnter">검색</span></a>
 						 <c:if test="${typeCheck.user_type eq 'C'}">
   						 	<a href="javascript:gfModalPop('#layer2');" class="btnType blue" id="submitBtn"><span id="">작성</span></a>
					     </c:if>
 					  </span>
				    </p> 
					<table class="col">
					<caption>caption</caption>
						<colgroup>
							<col width="5%">
							<col width="15%">
							<col width="10%">
							<col width="15%">
							<col width="5%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">글번호</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">등록일</th>
								<th scope="col">조회수</th>
							</tr>
						</thead>
						<tbody id="admNoticeList"></tbody>
					</table>
				</div>
				<div class="paging_area" id="admPagination"></div>
				<!-- 관리자 공지사항 리스트 조회  -->
								<br><br>
				<!-- 강사 공지사항 리스트 조회  -->
				<div class="divComGrpCodList">
				    <p class="conTitle">               
					   <span>강사 공지사항</span>
 					   <span class="fr"> 
 						  <span>
						   	 <select id="tut_type" style="width: 90px;" >
                                <option value="all" selected="selected">제목+내용</option>
                                <option value="title">제목</option>
                                <option value="content">내용</option>
                            </select>
                          </span> 
 						  <input type="text" id="tut_key" style="width: 200px; height: 28px;" onKeyDown="if(event.keyCode == 13) javascript:fTutList()">
 						   <a class="btnType blue" href="javascript:fTutList()"><span id="searchEnter">검색</span></a>
 						   <c:if test="${typeCheck.user_type eq 'B'}">
   								<a href="javascript:gfModalPop('#layer2');" class="btnType blue" id="submitBtn"><span id="">작성</span></a>
							</c:if>
 						</span>
					  </p> 
					<table class="col">
						<caption>caption</caption>
							<colgroup>
								<col width="5%">
								<col width="15%">
								<col width="10%">
								<col width="15%">
								<col width="5%">
							</colgroup>
						<thead>
							<tr>
								<th scope="col">글번호</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">등록일</th>
								<th scope="col">조회수</th>
						   </tr>
					    </thead>
						<tbody id="tutNoticeList"></tbody>
					</table>
				</div>
				
				<div class="paging_area" id="tutPagination"></div>
				</div>
				<!-- 강사 공지사항 리스트 조회  -->
				
				<div class="btn_areaC mt20">
					<%-- <c:if test="${typeCheck.user_type eq 'C' or typeCheck.user_type eq 'B'}">
   						<a href="javascript:gfModalPop('#layer2');" class="btnType blue" id="submitBtn"><span id="">작성</span></a>
					</c:if> --%>
                       
                     </div>
				<h3 class="hidden">풋터 영역</h3> 
				<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
			</li>
		</ul> 
	</div>
	</div>
	

	<div id="layer1" class="layerPop layerType2" style="width: 650px; overflow:auto;">
	</div>
	</form>
	
	<form id="myForm">
     <div id="layer2" class="layerPop layerType2" style="width: 650px;">
      <dl>
         <dt>
            <strong>공지사항 등록하기</strong>
         </dt>
         <dd class="content">
            <table class="row">
               
               <colgroup>
                  <col width="12%">
                  <col width="*">
                  <col width="12%">
                  <col width="*">
               </colgroup>

               <tbody>
                  <tr>
                     <th scope="row">제목</th>
                     <td><input type="text" class="inputTxt p100" name="notice_tit" id="notice_tit" placeholder="제목을 입력하세요."/></td>
                  </tr>
                  <tr>
                     <th scope="row">내용</th>
                     <td><textarea class="inputTxt p100" name="notice_con" id="notice_con" style= "min-height:250px; resize:none;"></textarea></td>
                  </tr>
               </tbody>
            </table>
            
            <div class="btn_areaC mt20">
               <a href="javascript:fWrite();" class="btnType blue" id="submitBtn"><span id="">작성</span></a>
               <a href="" class="btnType blue" id="closeBtn"><span id="">닫기</span></a>
            </div>
         </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
   </div>
  </form>
 
	
</body>
</html>