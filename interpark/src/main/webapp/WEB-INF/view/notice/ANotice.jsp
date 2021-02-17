<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>인터파크 Book API</title>



<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"

href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

<script

src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>

<script

src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>



<script>

$(document).ready(function() {
	
	$("#dbUpdate").on("click",function(){
		const service = $("#service").val();
		const category = $("#category").val();
		
		console.log("서비스"+service);
		console.log("카테고리"+category);
		
		$.ajax({
			  url: '/api/bookInfoSave.do',
			  type: 'post',
			  data: {
				  service:service,
				  category:category
			  },
			  dataType:"json",
			  success : function(result){
			        alert(result.resultMsg);		     
			       },
			       error : function(){
			        alert("실패");
			       }
			      });

		
	});
	
/* 	$("#searchButton").on("click",function(){
		const searchKey = $("#searchKey").val();
		console.log("searchKey"+searchKey);
		
		$.ajax({
			  url: '/api/searchBook.do',
			  type: 'post',
			  data: {
				  query:searchKey
			  },
			  dataType:"text",
			  success : function(result){
			        alert("검색성공");		     
			       },
			       error : function(){
			        alert("실패");
			       }
			      });

		
	}); */
	
	
});
	




</script>



</head>

<body>
<div class="container">
		<select id="service">
			<option selected="selected">서비스 선택</option>
			<option value="bestSeller">베스트셀러</option>
			<option value="recommend">추천도서</option>
			<option value="newBook">신간</option>
		</select> 
		<select id="category">
			<option selected="selected">카테고리 선택</option>
			<option value="domestic">국내도서</option>
			<option value="foreign">외국도서</option>
			<option value="recode">음반</option>
			<option value="dvd">DVD</option>
		</select>
		 <a href="" target="_blank" class="btn btn-default btn-xs" role="button" id="dbUpdate">DB 업데이트</a>
</div>
	<div class="container">
	<form action="/api/searchBook.do" method="post">
	<input type="text" id="searchKey" name="query">
		<input type='submit' value="검색">
	</form>		
	</div>
	<div class="container">
	<table class="table table-hover">
	<tr class="table-success">
	<th>도서이미지</th>
	<th colspan="2">도서 제목</th>
	<th>저자</th>
	<th>정가</th>
	</tr>
	<c:forEach var="list" items="${list }">
	<tr>
	<td><img src="${list.coverSmallUrl }"></td>
	<td colspan="2">${list.title }</td>
	<td>${list.author }</td>
	<td>${list.priceStandard }</td>
	<td>${list.description }</td>
	</tr>
	</c:forEach>
	</table>
	</div>
	


</body>

</html>

