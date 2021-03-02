<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
	<thead>
		<tr>
			<th class="thead">이미지</th>
			<th class="thead">정보</th>
		</tr> 
	</thead>
	<tbody id="book_list">
		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="9">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:if test="${totalCnt > 0 }">
			<c:forEach var="list" items="${list }">
				<tr class="book"
					onClick="selectBook('${list.itemId }','${list.title }')">
					<td class="cart-pic first-row">
					<img src="${list.coverSmallUrl }" width="90px" height="130px"></td>
					<td class="cart-title first-row" colspan="2">
						<h5>${list.title }</h5> <strong><${list.categoryName}></strong> <br>
						<strong>카테고리ID:</strong>${list.categoryId} <br> <strong>저자:</strong>
						${list.author } <br> <strong>출판사(제작사):</strong>
						${list.publisher} <br> <strong>정가:</strong><span
						class="text-warning"> ${list.priceStandard }</span><br> <br>
						<p>${list.description }</p>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />
	</tbody> 
