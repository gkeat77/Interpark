<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
    
<head>
<meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>mol</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Muli:300,400,500,600,700,800,900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="${CTX_PATH}/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="${CTX_PATH}/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="${CTX_PATH}/css/themify-icons.css" type="text/css">
    <link rel="stylesheet" href="${CTX_PATH}/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="${CTX_PATH}/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="${CTX_PATH}/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="${CTX_PATH}/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="${CTX_PATH}/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="${CTX_PATH}/css/style.css" type="text/css">
    <link rel="stylesheet" href="${CTX_PATH}/css/common.css" type="text/css" />
</head>

<body>    
    <!-- Page Preloder -->
    <!-- <div id="preloder">
        <div class="loader"></div>
    </div> -->

    <!-- Header Section Begin -->
    <header class="header-section">
        <div class="header-top">
            <div class="container">
                <div class="ht-left">
                    <div class="mail-service" style="padding:0">
                      <div class="btn-group btn-group-lg">
                      <c:forEach items="${topMenu }" var="top">
					    <button type="button" class="btn-outline-dark topBtn" style="height:54px" data-url="${top.menuUrl }">${top.menuName }</button>
					  </c:forEach>  
					  </div>
                    </div>
                </div>
                <div class="ht-right">
					<c:choose >
						<c:when test="${not empty member}">
						   <a href="/login/logOut.do" class="login-panel"><i class="fa fa-sign-out"></i>LogOut</a>
						   <a href="/userInfo.do" class="login-panel" style="margin-right:20px"><i class="fa fa-user"></i>${member.name}님의 마이페이지</a>
						</c:when>
						<c:when test="${empty member}">
						 <a href="/login/login.me" class="login-panel"><i class="fa fa-user"></i>Login</a>
						</c:when>					
					</c:choose>
              <!--       <div class="lan-selector">
                        <select class="language_drop" name="countries" id="countries" style="width:300px;">
                            <option value='yt' data-image="img/flag-1.jpg" data-imagecss="flag yt"
                                data-title="English">English</option>
                            <option value='yu' data-image="img/flag-2.jpg" data-imagecss="flag yu"
                                data-title="Bangladesh">German </option>
                        </select>
                    </div> -->
                </div>
            </div>
        </div>
        <div class="container">
            <div class="inner-header">
                <div class="row">
                    <div class="col-lg-2 col-md-2">
                        <div class="logo">
                            <a href="/index.do">
                                <!-- <img src="img/mol.jpg" alt=""> -->
                                <img src="${CTX_PATH}/img/logo.png" alt="">
                            </a>
                        </div>
                    </div>
                    <!-- 검색 -->
                    <div class="col-lg-7 col-md-7">
                        <div class="advanced-search">
                            <button type="button" class="category-btn" style="width:500px !important"> 전체 검색 </button>
                            <form action="/book/goodsListPage.do" class="input-group">
                            <c:choose>
                            <c:when test="${searchKey ne null and searchKey ne ''}">
                                <input type="text" id="mainSearchKey" name="searchKey" value="${searchKey }" style="width:1000px">
                             </c:when>
                             <c:when test="${searchKey eq null or searchKey eq ''}">
                                <input type="text" id="mainSearchKey" name="searchKey" style="width:1000px">
                             </c:when>
                             </c:choose>
                                <button type="submit" id="mainSearch"><i class="ti-search"></i></button>
                            </form>
                        </div>
                    </div>
                    <!-- 검색 끝 -->
                    <!------------------------------------------------------------------ cart---------------------------------------------------------------->
                    <c:set var="cnt" value="1"/>
                    
                    <div class="col-lg-3 text-right col-md-3">
                        <ul class="nav-right">
                            <li class="cart-icon"><a href="/cartList.do">
                                    <i class="icon_bag_alt"></i>
                                    <span>${cartCnt }</span>
                                </a>
                               <%-- 
                                <div class="cart-hover" >
                                    <div class="select-items">
                                        <table>
                                            <tbody>
											<c:set var = "sum" value = "0" />
											<c:set var = "sum2" value = "0" />
                                            <c:forEach var="cartList" items="${cartList}" >
                                                <tr>
                                                <!-- <td class="si-pic"><img src="${cartList.bookImg}" alt=""  style="width=30%;height=30%;object-fit:contain;"></td>  -->
                                                    <td class="si-pic"><img src="${cartList.bookImg}" alt=""  width=100px, height=100px></td>
                                                    <td class="si-text">
                                                        <div class="product-selected">
                                                        	<p><fmt:formatNumber pattern="###,###,###" value="${cartList.price}" /> x ${cartList.stock }</p>
                                                        	<h6>${cartList.bookName }</h6>
                                                        	<input type="hidden" value="${cartList.price * cartList.stock }" id="cartPrice${cartList.cartNo }"> 
                                                        </div>
                                                    </td>
                                                    <td class="si-close">
                                                        <i class="ti-close"></i>
                                                    </td>
                                                </tr>
                                                <c:set var = "sum2" value ="${cartList.stock * cartList.price }" />
                                                <c:set var= "sum" value="${sum + sum2}"/>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="select-total">
                                        <span>total:</span>
                                        <h5><fmt:formatNumber pattern="###,###,###" value="${sum}" /> ​</h5>
                                    </div>
                                    <div class="select-button">
                                        <a href="#" class="primary-btn view-card">VIEW CARD</a>
                                        <a href="#" class="primary-btn checkout-btn">CHECK OUT</a>
                                    </div>
                                </div> 
                                --%>
                            </li>
                             <li class="cart-price" style=visibility:hidden;>$150.00</li>
                        </ul>
                    </div>
                    <!------------------------------------------------------------------ cart end---------------------------------------------------------------->
                </div>
            </div>
        </div>
        <div class="nav-item">
            <div class="container">
                <div class="nav-depart">
                    <div class="depart-btn">
                        <i class="ti-menu"></i>
                        <span>전체 카테고리</span>
                        <ul class="depart-hover">
				         <c:set value="${megaMenu }" var="mega"/>
		                     <div class="row">
						        <div class="column">
						          <h3 data-categoryid="1">국내도서</h3>
						           <c:forEach items="${mega.domesticList }" var="list">
						          		<a href="#" data-categoryid="${list.categoryId }">${list.categoryName }</a>
						          </c:forEach>
						        </div>
						        <div class="column">
						          <h3 data-categoryid="2">외국도서</h3>
						           <c:forEach items="${mega.foreignList  }" var="list">
						          		<a href="#" data-categoryid="${list.categoryId }">${list.categoryName }</a>
						          </c:forEach>
						        </div>
						        <div class="column">
						          <h3 data-categoryid="3">음반</h3>
						          <c:forEach items="${mega.cdList }" var="list">
						          	<a href="#" data-categoryid="${list.categoryId }">${list.categoryName }</a>
						          </c:forEach>
						        </div>
						        <div class="column">
						          <h3 data-categoryid="4">DVD</h3>
						          <c:forEach items="${mega.dvdList }" var="list">
						          	<a href="#" data-categoryid="${list.categoryId }">${list.categoryName }</a>
						          </c:forEach>
						        </div>
						      </div>
                        </ul>
                    </div>
                </div>
                <nav class="nav-menu mobile-menu">
                    <ul>
                        <c:forEach items="${mainMenu }" var="main">
                        	<li><a href="${main.menuUrl }">${main.menuName }</a></li>
                        </c:forEach>
                    </ul>
                </nav>
                <div id="mobile-menu-wrap"></div>
            </div>
        </div>
    </header>
    <!-- Header End -->	
