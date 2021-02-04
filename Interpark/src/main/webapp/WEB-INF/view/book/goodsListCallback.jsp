<!DOCTYPE html>
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
											<tr class="book" onClick="">
												<td>
													${list.pId}
												</td>
												<td>
												<img src="${list.coverSmallUrl }" width="50px" height="70px">
												</td>
												<td>
													<h5>${list.title }</h5>
													<strong>카테고리ID:</strong>${list.categoryId} <br>
													<strong>저자:</strong> ${list.author } <br> 
													<strong>출판사(제작사):</strong> ${list.publisher}
												</td>
												<td>
												 	할인적용가 : ${list.realPrice } <br>
													판매가: ${list.salePrice } <br>
												 	할인율 : ${list.saleRate } % <br>
												 	등록일: ${list.regDate } <br>
												</td>
												<td>
												 	재고: ${list.stock } <br>
												 	판매량: ${list.sellCount } <br>
												 	전시상태: ${list.display }  <br>
												 	판매상태: ${list.sellState } <br>
												 	<c:if test="${list.sellStart ne null}">
												 		판매시작일: ${list.sellStart } <br> 
												 		판매종료일 ${list.sellEnd } <br>
												 	</c:if>
												</td>
											</tr>
										</c:forEach>
									<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />
									</c:if>