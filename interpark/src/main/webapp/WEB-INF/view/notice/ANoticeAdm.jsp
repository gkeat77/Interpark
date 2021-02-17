<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="divEmpty">
   <div class="hiddenData">
      <span id="admNoticeCnt">${admNoticeCnt}</span>
   </div>
   <table class="col">
                          
      <tbody id="admNoticeList">
      <c:if test="${admNoticeCnt eq 0 }">
         <tr>
            <td colspan="9">데이터가 존재하지 않습니다.</td>
         </tr>
      </c:if>
      
      <c:set var="nRow" value="${pageSize*(admCurrentPage-1)}" />
         <c:forEach var="list" items="${admNotice}">
            <tr>
            	<td>${list.notice_id}</td>
            	<td><a href="javascript:fPopModalAdm(${list.notice_id});"><strong>${list.notice_tit}</strong></a></td>
				<td>${list.name}</td>
				<td>${list.regdate}</td>
				<td>${list.hit}</td>
            </tr>
         <c:set var="nRow" value="${nRow + 1}" />
      </c:forEach> 
         
      </tbody>
   </table>

</div>

