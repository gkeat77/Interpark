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
		}
		
		// html 만들기
		let rankingHtml = "";
		
		cateData[category].forEach(function(item){
			
			rankingHtml = '<div class="rankItem"> </div>';

			
			console.log('item: '+item);
		})
		
	};
    // 메뉴에서 active에 해당하는 자료 보여주기
    activeMenu = $('.ranking-menu li.active a').text();
	console.log('active: '+activeMenu);
	$('.ranking-menu li').hover(function () {
        $('.ranking-menu li').removeClass();
        $(this).addClass('active');
        updateRanking();
    });
	
	updateRanking();
	



});