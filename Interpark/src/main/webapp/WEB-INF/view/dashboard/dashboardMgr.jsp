<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>잡코리아 dashboard</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- D3 -->
<style>
//
click-able rows
	.clickable-rows {tbody tr td { cursor:pointer;
	
}

.el-table__expanded-cell {
	cursor: default;
}
}
</style>
<script type="text/javascript">


 
</script>

</head>
<body>
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">


		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">메인</span> <a href="#"
								class="btn_set refresh">새로고침</a>
						</p>


<!--                         <input type="text" id="EMP_ID" name="lgn_Id" placeholder="아이디" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" style="ime-mode:inactive;" /> -->
                        <div id="searcharea">
                                       제목 : <input id="stitle" name="stitle"  v-model="stitle" placeholder="제목 검색조건">
                             <a href="javascript:selectNoticeListvue();" id="btn_prelogin2" ><strong>조회</strong></a>	
                             <p>메시지: {{ stitle }}</p>
                        </div>
                        <div>
	                        <template id="searcharea2">
	                             <div class="input-group date" style="width:150px;">
	                                      <input id="indate" name="indate" type="text" class="form-control" v-model="date" />
	                                     <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
	                            </div>                            
	                       </template>
                       </div>


						<div>
							<template id="searcharea2">
							<div class="input-group date" style="width: 150px;">
								<input id="indate" name="indate" type="text"
									class="form-control" v-model="date" /> <span
									class="input-group-addon"><i class="fa fa-calendar"></i></span>
							</div>
							</template>
						</div>

						<input type="hidden" id="currentPage" value="1"> <input
							type="hidden" id="currentPagevue" value="1">
						<div class="dashboard2 mt30 mb20">

							<ul>
								<li>
									<div class="col">
										<p class="tit">
											<em>공 지 사 항</em>
										</p>
										<table class="col2 mb10" style="width: 1000px;">

											<colgroup>
												<col width="50px">
												<col width="200px">
												<col width="60px">
												<col width="50px">
											</colgroup>

											<thead>
												<tr>
													<th>공지 번호</th>
													<th>공지 사항</th>
													<th>작성일</th>
													<th>관리자</th>

												</tr>
											</thead>
											<tbody id="noticeList"></tbody>

										</table>
									</div>
								</li>
							</ul>

							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi"></div>

						</div>
						<div id="vuetable">
							<div class="bootstrap-table">
								<div class="fixed-table-toolbar">
									<div class="bs-bars pull-left"></div>
									<div class="columns columns-right btn-group pull-right">
									</div>
								</div>
								<div class="fixed-table-container" style="padding-bottom: 0px;">
									<div class="fixed-table-body">

										<table id="vuedatatable" class="col2 mb10"
											style="width: 1000px;">
											<colgroup>
												<col width="25px">
												<col width="25px">
												<col width="200px">
												<col width="60px">
												<col width="50px">
											</colgroup>
											<thead>
												<tr>
													<th data-field="index">번호</th>
													<th data-field="nt_seq">공지 번호</th>
													<th data-field="nt_title">공지 사항</th>
													<th data-field="loginID">작성일</th>
													<th data-field="write_date">관리자</th>
												</tr>
											</thead>
											<tbody>
												<template v-for="(row, index) in items" v-if="items.length">
												<tr onclick="vm.rowClicked(this)">
													<td>{{ index + 1}}</td>
													<td>{{ row.nt_seq }}</td>
													<td>{{ row.nt_title }}</td>
													<td>{{ row.write_date }}</td>
													<td>{{ row.loginID }}</td>
												</tr>
												</template>
											</tbody>
										</table>
										<div>
											<div>
												<div class="clearfix" />
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="paging_area" id="pagingnavi2"></div>
					</div>
				</li>
			</ul>

		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="notice" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" id="nt_seq" name="nt_seq">
		<!-- 수정시 필요한 num 값을 넘김  -->

		<dl>
			<dt>
				<strong>공지사항 상세보기 </strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">작성자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="loginID"
								id="loginID" /></td>
							<!-- <th scope="row">작성일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="write_date" id="write_date" /></td> -->
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="nt_title" id="nt_title" /></td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="3"><textarea class="inputTxt p100"
									name="nt_note" id="nt_note">
								</textarea></td>
						</tr>

					</tbody>
				</table>

				<div class="btn_areaC mt30">

					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!-- 모달팝업 -->
	<div id="noticevue" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" id="nt_novue" name="nt_novue">
		<!-- 수정시 필요한 num 값을 넘김  -->

		<dl>
			<dt>
				<strong>공지사항 상세보기 </strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<div id="editvue">
					<table class="row">
						<caption>caption</caption>

						<tbody>
							<tr>
								<th scope="row">작성자 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									v-model="loginID_vue" name="loginID_vue" id="loginID_vue" /></td>
								<!-- <th scope="row">작성일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="write_date_vue" name="write_date_vue" id="write_date_vue" /></td> -->
							</tr>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									v-model="nt_title_vue" name="nt_title_vue" id="nt_title_vue" /></td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3"><textarea class="inputTxt p100"
										v-model="nt_note_vue" name="nt_note_vue" id="nt_note_vue">
								</textarea></td>
							</tr>

						</tbody>
					</table>
				</div>
				<div class="btn_areaC mt30">

					<a href="" class="btnType gray" id="btnClose_vue" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

</body>
</html>