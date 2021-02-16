<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
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
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Header Section Begin -->
    <header class="header-section">
        <div class="header-top">
            <div class="container">
				<c:choose >
					<c:when test="${not empty member}">
					<div class="lan-selector">
						<div id="login-panel">
							<a href="my.me" class="login-panel"><i class="fa fa-user"></i>${member.name}님의 마이페이지</a>
							<a href="/login/logOut.do" class="login-panel">LogOut</a>
							<a href="/index.do" class="login-panel">home</a>
							<br>
						</div>
					</div>					
					</c:when>
					<c:when test="${empty member}">
					 <a href="/login/login.me" class="login-panel"><i class="fa fa-user"></i>Login</a>
					</c:when>					
					</c:choose>
            </div>
        </div>
        <div class="container">
            <div class="inner-header">
                <div class="row">
                    <div class="col-lg-2 col-md-2">
                        <div class="logo">
                            <a href="/index.do">
                                <!-- <img src="img/mol.jpg" alt=""> -->
                                <img src="img/logo.png" alt="">
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-7 col-md-7">
                        <div class="advanced-search">
                            <button type="button" class="category-btn">All Categories</button>
                            <form action="#" class="input-group">
                                <input type="text" placeholder="What do you need?">
                                <button type="button"><i class="ti-search"></i></button>
                            </form>
                        </div>
                    </div>
                    
                    <!------------------------------------------------------------------ cart---------------------------------------------------------------->
                    <c:set var="cnt" value="1"/>
                    
                    <div class="col-lg-3 text-right col-md-3">
                        <ul class="nav-right">
                            <li class="heart-icon"><a href="#">
                                    <i class="icon_heart_alt"></i>
                                    <span>1</span>
                                </a>
                            </li>
                            <li class="cart-icon"><a href="#">
                                    <i class="icon_bag_alt"></i>
                                    <span>${cartCnt }</span>
                                </a>
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
                <nav class="nav-menu mobile-menu">
                    <ul>
                        <li><a href="#">구매내역</a></li>
                        <li><a href="/mypage/my.my">회원정보 수정</a></li>
                        <li><a href="/mypage/addList.my">배송지 추가</a></li>
                        <li><a href="/cartList.do">장바구니</a></li>
                        <li><a href="#">포인트</a> </li>
                        <li><a href="#">쿠폰</a> </li>
                        <li><a href="/mypage/bye.my" >회원탈퇴</a> </li>
                    </ul>
                </nav>
                <div id="mobile-menu-wrap"></div>
            </div>
        </div>
    </header>
    
    <!-- Header End -->		

