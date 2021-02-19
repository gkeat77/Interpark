<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/view/common/header.jsp"/>
<jsp:include page="/WEB-INF/view/common/common_include_uni.jsp"/>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
<link rel="stylesheet" href="${CTX_PATH}/css/ticketing/intro.css" type="text/css">

<div class="container">
	<input type="hidden" id="boxofsStr" name="boxofsStr" value='${boxofsStr }'>
	<h1>티켓팅</h1>
	<div class="main row">
		<div class="menu col-3">
			<ul class="cate">
				<li>연극
					<ul class="sub-cate">
						<li class="clickable"><a>전국</a></li>
						<li class="clickable"><a>패키지공연</a></li>
						<li class="clickable"><a>주간랭킹순</a></li>
					</ul>
				</li>
				<li>뮤지컬
					<ul class="sub-cate">
						<li class="clickable"><a>오리지날/내한공연</a></li>
						<li class="clickable"><a>라이선스</a></li>
						<li class="clickable"><a>창작뮤지컬</a></li>
						<li class="clickable"><a>넌버벌퍼포먼스</a></li>
					</ul>
				</li>
				<li class="clickable"><a>클래식</a></li>
				<li class="clickable"><a>오페라</a></li>
				<li class="clickable"><a>무용</a></li>
			</ul>
		</div>
		<div class="content col-9 row">
			<div class="main-poster col-5">
				
					<img src="" alt="">
			
			</div>
			<div class="sub-poster col-7">
			
			</div>
		</div>
	</div>
	<div class="ranking row">
		<div class="top">
			<div class="title">RANKING</div>
			<div class="menu-div">
				<ul class="ranking-menu">
					<li class="active"><a>연극</a></li>
					<li><a>뮤지컬</a></li>
					<li><a>클래식</a></li>
					<li><a>오페라</a></li>
					<li><a>무용</a></li>
				</ul>
			</div>
		</div>
		<div class="bottom">
			<div class="more"><a>전체보기</a></div>
			<div class="wrapper">
				<div class="content">
				
				</div>
				<span class="next" style="font-size: 3em; color: Tomato;"> 
					<i class="fas fa-angle-right"></i>
				</span>
				<span class="prev" style="font-size: 3em; color: Tomato;"> 
					<i class="fas fa-angle-left"></i>
				</span>
			</div>
		</div>
		
	</div>
</div>

<script>
$(document).ready(function () {
	
	//데이터 준비
    const dataStr = $('#boxofsStr').val();
    const boxofs = JSON.parse(dataStr);// 메인데이터

    const chosen = [];
    for (i = 0; i < 15; i++) {
        let index = Math.floor(Math.random() * 16);
        while (chosen.indexOf(index) !== -1) {
            index = Math.floor(Math.random() * 16);
        }
        chosen.push(index);
    }
    console.log("chosen: " + chosen);

    // 16개 데이터 화면에 뿌리기
    // main-poster
    let src = boxofs[chosen[0]].poster;
    let alt = boxofs[chosen[0]].prfnm;
    $('.main-poster img').attr({ 'src': src, 'alt': alt, 'title': alt });
    // sub-poster

    let html = "";
    for (i = 0; i < chosen.length; i++) {
        html += '<div class="item">';
        html += '<img src="' + boxofs[chosen[i]].poster + '" alt="' + boxofs[chosen[i]].prfnm + '" title="' + boxofs[chosen[i]].prfnm + '" />';
        html += '</div>';
    }
    $('.sub-poster').html(html);
    $('.sub-poster').on('mouseover', 'img', function () {
        const src = $(this).attr('src');
        const alt = $(this).attr('alt');
        const title = alt;
        $('.main-poster img').attr({ 'src': src, 'alt': alt, 'title': title });
    });

    // Ranking...
    // 카테고리별로 데이터 분류
    const cateData = {};
    cateData['cateTotal'] = boxofs
		    .sort(function (a, b) { return a.rnum - b.rnum; });
    cateData['catePlay'] =  boxofs
	        .filter(function(item) { return item.cate === '연극';})
	        .sort(function (a, b) { return a.rnum - b.rnum; });
    cateData['cateMusical'] =  boxofs
		    .filter(function(item) { return item.cate === '뮤지컬';})
		    .sort(function (a, b) { return a.rnum - b.rnum; });
    cateData['cateClassic'] =  boxofs
		    .filter(function(item) { return item.cate === '클래식';})
		    .sort(function (a, b) { return a.rnum - b.rnum; });
    cateData['cateOpera'] =  boxofs
		    .filter(function(item) { return item.cate === '오페라';})
		    .sort(function (a, b) { return a.rnum - b.rnum; });
    cateData['cateBallet'] =  boxofs
		    .filter(function(item) { return item.cate === '무용';})
		    .sort(function (a, b) { return a.rnum - b.rnum; });
	
    // 랭킹자료 뿌리기
    let activeMenu = "연극";
    let rankingHtml = "";
	const updateRanking = function(){//랭킹자료 업데이트
		
		let category = "cateTotal";
		switch(activeMenu){
		case '연극':
			category = 'catePlay';
			break;
		case '뮤지컬':
			category = 'cateMusical';
			break;
		case '클래식':
			category = 'cateClassic';
			break;	
		case '오페라':
			category = 'cateOpera';
			break;
		case '무용':
			category = 'cateBallet';
			break;
		case '전부':
			category = 'cateTotal';
			break;
		}
		
		// html 만들기
		rankingHtml = "";
		console.log('category=> '+category);
		cateData[category].forEach(function(item){
					
			rankingHtml += '<div class="rankItem" style="{width: 250px; height: 300px; margin-right: 50px;}">';
			rankingHtml +=   '<div class="poster">';
			rankingHtml +=     '<img style="{width: 250px; height: 300px;}" src="'+item.poster+'" alt="'+item.prfnm+'" title="'+item.prfnm+'">';	
			rankingHtml +=   '</div>';
			rankingHtml +=   '<div class="title">';
			rankingHtml +=      '<p>'+ item.prfnm +'</p><p>( '+ item.rnum +'위 )</p>';
			rankingHtml +=    '</div>'
			rankingHtml += '</div>';
			
		});
		$('.ranking .bottom .content').css('left',0);
		$('.ranking .bottom .content').html(rankingHtml);
		
	};
    // 메뉴에서 active에 해당하는 자료 보여주기
    activeMenu = $('.ranking-menu li.active a').text();
	console.log('active: '+activeMenu);
	$('.ranking-menu li').hover(function () {
        $('.ranking-menu li').removeClass();
        $(this).addClass('active');
        activeMenu = $(this).find('a').text();
        updateRanking();
    });
	
	// 전체 데이타 보여주기
	$('.more').click(function(){
		activeMenu = "전부";
		updateRanking();
	});
	
	// 슬라이더 버튼
	$('.wrapper').on('click', 'span', function(){
		let left = $('.ranking .content').position().left;
		let contentWidth = $('.ranking .content').outerWidth();
		console.log('contentWidth: '+contentWidth);
		if($(this).attr('class') === 'next'){
			left = ( left > -250 ? 0 : left + 250);
		} else {
			
			left = left - 250;
		}
		console.log('left: '+left);
		$('.ranking .content').animate({'left': left},500);
	});
	
	updateRanking();
	



});
</script>











<jsp:include page="/WEB-INF/view/common/footer.jsp"/>