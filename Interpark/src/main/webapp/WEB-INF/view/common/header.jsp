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
					    <button type="button" class="btn-outline-dark active" style="height:54px">도서</button>
					    <button type="button" class="btn-outline-dark" style="height:54px">공연</button>
					    <c:if test="${member.user_type eq 'A'}">
					    <button type="button" class="btn-outline-dark" style="height:54px">관리자</button>
					    </c:if>
					  </div>
                    </div>
                </div>
                <div class="ht-right">
					<c:choose >
						<c:when test="${not empty member}">
						   <a href="/login/logOut.do" class="login-panel"><i class="fa fa-sign-out"></i>LogOut</a>
						   <a href="/mypage/my.my" class="login-panel" style="margin-right:20px"><i class="fa fa-user"></i>${member.name}님의 마이페이지</a>
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
                            <li class="heart-icon"><a href="#">
                                    <i class="icon_heart_alt"></i>
                                    <span>1</span>
                                </a>
                            </li>
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
                        <span>All departments</span>
                        <ul class="depart-hover">
                            <li class="active"><a href="#">Women’s Clothing</a></li>
                            <li><a href="#">Men’s Clothing</a></li>
                            <li><a href="#">Underwear</a></li>
                            <li><a href="#">Kid's Clothing</a></li>
                            <li><a href="#">Brand Fashion</a></li>
                            <li><a href="#">Accessories/Shoes</a></li>
                            <li><a href="#">Luxury Brands</a></li>
                            <li><a href="#">Brand Outdoor Apparel</a></li>
                        </ul>
                    </div>
                </div>
                <nav class="nav-menu mobile-menu">
                    <ul>
                        <li><a href="./index.html">Home</a></li>
                        <li><a href="./shop.html">Shop</a></li>
                        <li><a href="#">도서</a>
                            <ul class="dropdown">
                                <li><a href="/bookAdmin/regPage.do">도서등록</a></li>
                                <li><a href="/bookAdmin/goodsListPage.do">도서목록(관리자)</a></li>
                                <li><a href="/book/goodsListPage.do">도서목록</a></li>
                            </ul>
                        </li>
                        <li><a href="#">Pages</a>
                            <ul class="dropdown">
                                <li><a href="/adminInfo.do">Blog Details</a></li>
                                <li><a href="/cartList.do">Shopping Cart</a></li>
                                <li><a href="./check-out.html">Checkout</a></li>
                                <li><a href="./faq.html">Faq</a></li>
                                <li><a href="./register.html">Register</a></li>
                                <c:choose>
		                         <c:when test="${empty member}">
		                            <li><a href="/login/login.me">Login</a></li>
		                         </c:when>
		                         <c:otherwise>
		                         	<li><a href="/userInfo.do">userInfo</a></li>
		                            <li><a href="/login/logOut.do">LOGOUT</a></li>
		                         </c:otherwise>
		                         </c:choose>
                            </ul>
                        </li>
                        <li><a href="/event/eventListPage.do">이벤트</a>
                        </li>
                         <!-- <li><a href="/event/eventList.do">이벤트</a>
                        </li> -->
                        
                        <c:if test="${member.loginID eq 'admin'}">
                        	<li><a href="#">ADMIN</a>
                            <ul class="dropdown">
		                         <!-- admin  -->
		                        <c:choose>
		                         <c:when test="${member.loginID eq 'admin'}">
		                         	<li><a href="/adminInfo.do">ADMIN</a></li>
		                         	<li><a href="/statistics.do">통계</a></li>
		                         	<li><a href="/adminCoupon.do">쿠폰지급</a></li>
		                         	<li><a href="/adminOrders.do">ORDERS</a></li>
		                         </c:when>
		                         <c:otherwise>
		                         </c:otherwise>
		                         
		                         </c:choose>
                            </ul>
                        </li>
                        </c:if>
                    </ul>
                </nav>
                <div id="mobile-menu-wrap"></div>
            </div>
        </div>
    </header>
    <!-- Header End -->		
