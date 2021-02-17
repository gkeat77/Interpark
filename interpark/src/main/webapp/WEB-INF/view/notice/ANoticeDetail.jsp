<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 공지사항 상세페이지 조회  -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="${CTX_PATH}/js/summernote/summernote-ko-KR.js"></script>


<script>

$(document).ready(function(){
	$("#updateBtnResult").hide();
	
})
/* text.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
${detail} ->  
*/ 
 function fUpdate(notice_id){
			var a ='<input type="text" id="re_tit" style="width:100%; height:100%;" value="${detail.notice_tit}">';
			$("#tit").text("").append(a);
			var b ='<textarea id="re_con" class="inputTxt p100" style="width:100%; min-height:250px; resize:none;">${detail.notice_con}</textarea>';
			$("#con").text("").append(b);
			$('#re_con').summernote({
				  height: 250,                 // 에디터 높이
				  minHeight: null,             // 최소 높이
				  maxHeight: null,             // 최대 높이
				  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
				  lang: "ko-KR",					// 한글 설정
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
			$("#updateBtn").hide();
			$("#updateBtnResult").show();
}
</script>
                    
                        <dl>
                           <dt>
                           </dt>
                           <dd class="content">
                        <table class="row" id="edit_table" name="edit_table" style="text-align: center;">
                              <colgroup>
                                 <col width="12%">
                                 <col width="16%">
                                 <col width="12%">
                                 <col width="*">
                                 <col width="12%">
                                 <col width="16%">
                              </colgroup>
                           <tbody>
                              <tr>
                                 <th scope="row">글번호</th>
                                    <td id="num"><strong>[ ${detail.notice_id} ]</strong></td>
                                 <th scope="row">제목</th>
                                     <td id="tit" colspan="3">
                                     <input type="hidden" id="test" value="${detail.notice_tit}">
                                     ${detail.notice_tit}
                                     </td>
                              </tr>
                              <tr>
                                 <th scope="row">작성자</th>
                                    <td id="name">${detail.name}</td>
                                 <th scope="row">등록일</th>
                                    <td id="reg">${detail.regdate}</td>
                                 <th scope="row">조회수</th>
                                    <td id="hit">${detail.hit}</td>
                              </tr>
                              <tr>
                                 <th scope="row">내용</th>
                                    <td id="con" colspan="5" style="text-align: left;"><div style="min-height:250px;">${detail.notice_con}</div></td>
                              </tr>
                        </tbody>
                     </table>

                     <div class="btn_areaC mt30">
                     	<c:if test="${detail.loginId eq loginID}">
	                     	<a href="javascript:fUpdate(${detail.notice_id});" class="btnType blue" id="updateBtn"><span id="">수정</span></a>
	                     	<a href="javascript:fUpdateResult(${detail.notice_id});" class="btnType blue" id="updateBtnResult"><span id="">수정완료</span></a>
                    		<a href="javascript:fDelete(${detail.notice_id});" class="btnType blue" id="delBtn"><span id="">삭제</span></a>
                        </c:if>
                        <a href="" class="btnType blue" id="closeBtn"><span id="">닫기</span></a>
                     </div>
                  </dd>
               </dl>
               <a href="" class="closePop"><span class="hidden">닫기</span></a>