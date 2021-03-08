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
                  
                </div>
            </div>
        </div>
        <div class="nav-item">
            <div class="container">
                <nav class="nav-menu mobile-menu">
                    <ul>
                        <c:forEach items="${menu }" var="menu">
                        	<li><a href="${menu.menuUrl }">${menu.menuName }</a></li>
                        </c:forEach>
                    </ul>
                </nav>
                <div id="mobile-menu-wrap"></div>
            </div>
        </div>
    </header>
    <!-- Header End -->	
