$(document).ready(function () {

	//데이터 준비
	const dataStr = $('#boxofsStr').val();
	const boxofs = JSON.parse(dataStr);// 메인데이터

	//다른 루트에서 사용하기 위해 localStorage에 저장
	localStorage.setItem('boxofs', dataStr);
	console.log('boxofs >> '+localStorage.getItem('boxofs'));
	const chosen = [];
	for (i = 0; i < 15; i++) {
		let index = Math.floor(Math.random() * 15);
		while (chosen.indexOf(index) !== -1) {
			index = Math.floor(Math.random() * 15);
		}
		chosen.push(index);
	}
	console.log("chosen: " + chosen);

	// 15개 데이터 화면에 뿌리기
	// main-poster
	let src = boxofs[chosen[0]].poster;
	let alt = boxofs[chosen[0]].prfnm;
	let id = boxofs[chosen[0]].mt20id;
	$('.main-poster img').attr({ 'src': src, 'alt': alt, 'title': alt, 'data-id': id });

	// sub-poster
	let html = "";
	for (i = 0; i < chosen.length; i++) {
		html += '<div class="item" >';
		html += '<img data-id='+ boxofs[chosen[i]].mt20id +' src="' + boxofs[chosen[i]].poster + '" alt="' + boxofs[chosen[i]].prfnm + '" title="' + boxofs[chosen[i]].prfnm + '" />';
		html += '</div>';
	}
	$('.sub-poster').html(html);
	$('.sub-poster').on('mouseover', 'img', function () {
		const src = $(this).attr('src');
		const alt = $(this).attr('alt');
		const title = alt;
		const id = $(this).data('id');
		$('.main-poster img').attr({ 'src': src, 'alt': alt, 'title': title , 'data-id': id});
	});

	// Ranking...
	// 카테고리별로 데이터 분류
	const cateData = {};
	cateData['cateTotal'] = boxofs
		.sort(function (a, b) { return a.rnum - b.rnum; });
	cateData['catePlay'] = boxofs
		.filter(function (item) { return item.cate === '연극'; })
		.sort(function (a, b) { return a.rnum - b.rnum; });
	cateData['cateMusical'] = boxofs
		.filter(function (item) { return item.cate === '뮤지컬'; })
		.sort(function (a, b) { return a.rnum - b.rnum; });
	cateData['cateClassic'] = boxofs
		.filter(function (item) { return item.cate === '클래식'; })
		.sort(function (a, b) { return a.rnum - b.rnum; });
	cateData['cateOpera'] = boxofs
		.filter(function (item) { return item.cate === '오페라'; })
		.sort(function (a, b) { return a.rnum - b.rnum; });
	cateData['cateBallet'] = boxofs
		.filter(function (item) { return item.cate === '무용'; })
		.sort(function (a, b) { return a.rnum - b.rnum; });

	// 랭킹자료 뿌리기
	let activeMenu = "연극";
	let rankingHtml = "";
	const updateRanking = function () {//랭킹자료 업데이트

		let category = "cateTotal";
		switch (activeMenu) {
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
		console.log('category=> ' + category);
		cateData[category].forEach(function (item) {

			rankingHtml += '<div class="rankItem" data-id="'+ item.mt20id +'" style="{width: 250px; height: 300px; margin-right: 50px;}">';
			rankingHtml += '<div class="poster">';
			rankingHtml += '<img style="{width: 250px; height: 300px;}" src="' + item.poster + '" alt="' + item.prfnm + '" title="' + item.prfnm + '">';
			rankingHtml += '</div>';
			rankingHtml += '<div class="title">';
			rankingHtml += '<p>' + item.prfnm + '</p><p>( ' + item.rnum + '위 )</p>';
			rankingHtml += '</div>'
			rankingHtml += '</div>';

		});
		$('.ranking .bottom .content').css('left', 0);
		$('.ranking .bottom .content').html(rankingHtml);

	};//updateRanking end
	// 메뉴에서 active에 해당하는 자료 보여주기
	activeMenu = $('.ranking-menu li.active a').text();
	console.log('active: ' + activeMenu);
	$('.ranking-menu li').hover(function () {
		$('.ranking-menu li').removeClass();
		$(this).addClass('active');
		activeMenu = $(this).find('a').text();
		updateRanking();
	});

	// 전체 데이타 보여주기
	$('.more').click(function () {
		activeMenu = "전부";
		updateRanking();
	});

	// 슬라이더 버튼
	$('.wrapper').on('click', 'span', function () {
		let left = $('.ranking .content').position().left;
		let contentWidth = $('.ranking .content').outerWidth();
		console.log('contentWidth: ' + contentWidth);
		if ($(this).attr('class') === 'next') {
			left = (left > -250 ? 0 : left + 250);
		} else {

			left = left - 250;
		}
		console.log('left: ' + left);
		$('.ranking .content').animate({ 'left': left }, 500);
	});
	
	console.log('//메인,랭킹컨텐트 클릭이벤트 등록');
	//메인,랭킹컨텐트 클릭이벤트 등록
	$('.main > .content').on('click', 'img', function(){
		
		let id = $(this).data('id');
		console.log('id: '+id);
		location.href = '/ticketing/detail.do?mt20id='+id;
	});
	$('.ranking > .bottom .content').on('click', '.rankItem', function(){
		let id = $(this).data('id');
		console.log('id: '+id);
		location.href = '/ticketing/detail.do?mt20id='+id;
	});

	updateRanking();

});