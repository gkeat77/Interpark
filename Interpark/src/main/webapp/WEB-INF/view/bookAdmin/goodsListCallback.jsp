<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



                                    <c:if test="${totalCnt eq 0 }">
										<tr>
											<td colspan="9">데이터가 존재하지 않습니다.</td>
										</tr>
									</c:if>
									<c:if test="${totalCnt > 0 }">
										<c:forEach var="list" items="${goodsList }">
											<tr class="book" onClick="selectBook('${list.pId}')">
												<td>
													<img src="${list.coverSmallUrl }" width="50px" height="70px">
												</td>
												<td>
													<div class="row">
													<div class="col-sm-4"><strong>제목</strong></div>
												  	<div class="col-sm-6"><h5 class="text-warning">${list.title }</h5></div>
												</div>
												<div class="row">
												  	<div class="col-sm-4"><strong>도서ID</strong></div>
  													<div class="col-sm-6">${list.itemId}</div>
												</div>
												<div class="row">
												  	<div class="col-sm-4"><strong>카테고리</strong></div>
  													<div class="col-sm-6">${list.categoryName}</div>
												</div>
												<div class="row">
												  	<div class="col-sm-4"><strong>카테고리ID</strong></div>
  													<div class="col-sm-6">${list.categoryId}</div>
												</div>
												<div class="row">
												  	<div class="col-sm-4"><strong>저자</strong></div>
  													<div class="col-sm-6">${list.author }</div>
												</div>
												<div class="row">
												  	<div class="col-sm-4"><strong>출판사<br>(제작사)</strong></div>
  													<div class="col-sm-6">${list.publisher}</div> 
												</div>
												</td>
												<td>
													<div class="row">
												  		<div class="col-sm-4"><strong>상품 ID</strong></div>
  													    <div class="col-sm-6">${list.pId}</div> 
													</div>
													<div class="row">
												  	<div class="col-sm-4"><strong>실제 금액</strong></div>
  													<div class="col-sm-6"><h5 class="text-warning"><fmt:formatNumber value="${list.realPrice }" type="number"/></h5></div> 
												</div>
												<div class="row">
													<div class="col-sm-4"><strong>판매가</strong></div>
												  	<div class="col-sm-6"><fmt:formatNumber value="${list.salePrice }" type="number"/></div>
												</div>
												<div class="row">
												  	<div class="col-sm-4"><strong>할인율 </strong></div>
  													<div class="col-sm-6">${list.saleRate } %</div>
												</div>
												<div class="row">
												  	<div class="col-sm-4"><strong>등록일</strong></div>
  													<div class="col-sm-6">${list.regDate }</div>
												</div>
												</td>
												<td>
													<div class="row">
												  	<div class="col-sm-4"><strong>재고</strong></div>
  													<div class="col-sm-6"> ${list.stock }</div>
												</div>
												<div class="row">
													<div class="col-sm-4"><strong>판매량</strong></div>
												  	<div class="col-sm-6"><h5>${list.sellCount }</h5></div>
												</div>
												<div class="row">
												  	<div class="col-sm-4"><strong>전시상태</strong></div>
  													<div class="col-sm-6">${list.display}</div>
												</div>
												<div class="row">
												  	<div class="col-sm-4"><strong>판매상태</strong></div>
  													<div class="col-sm-6">${list.sellState }</div>
												</div>
												<c:if test="${list.sellStart ne null}">
												<div class="row">
												  	<div class="col-sm-4"><strong>판매<br>시작일</strong></div>
  													<div class="col-sm-6">${list.sellStart }</div> 
												</div>
												<div class="row">
												  	<div class="col-sm-4"><strong>판매<br>종료일</strong></div>
  													<div class="col-sm-6">${list.sellEnd }</div> 
												</div>
												</c:if> 
												</td>
											</tr>
										</c:forEach>
									</c:if>
									<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />