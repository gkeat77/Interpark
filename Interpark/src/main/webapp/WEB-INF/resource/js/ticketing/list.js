$(document).ready(function () {

    //데이터 준비
    const dataStr = $('#dbs').val();
    const dbs = JSON.parse(dataStr);// 메인데이터(목록)
    
    //global variable 셋업
    let category = $('.list-wrap .menu-title h4').text();
    let area = '전국';
    let sort = '공연종료일임박순';
    
    const boxofs = JSON.parse(localStorage.getItem('boxofs'))
	.filter(function(item){ return item.cate === category});//예매상황판 데이터(순위포함)


    //데이터 가공 함수 정의(option: true(메인데이터), false(예매상황판데이터))
    const makeList = function (inputData, option) {
        if (option) {//메인데이터(공연이름순, 공연종료일임박순 처리)
            console.log(inputData, option);
            return inputData
                //    					.filter(function(item){
                //    						return item.genrenm === category
                //    					})
                .sort(function (a, b) {
                    let byWhat = sort === '공연이름순' ? 'prfnm' : 'prfpdto';

                    return a[byWhat] > b[byWhat] ? 1 : a[byWhat] < b[byWhat] ? -1 : 0;
                });


        } else {//예매상황판데이터(금일랭킹순만 처리)
            return inputData
                //.filter(function (item) { return item.cate === category })
                .sort(function (a, b) { return a.rnum > b.rnum ? 1 : a.rnum < b.rnum ? -1 : 0 });
        }
    };

    //화면만들기
    const updateList = function (listData, option) {
    	let html = "";
    	
    	listData.forEach(function (item, index, arr) {
            html += `
                <div class="item" data-id="${item.mt20id}" style="display: flex; border-bottom: 1px solid #000">
	                <div class="prf-name" style="display: flex; justify-content: start;align-items: center;"><img src="${item.poster}" alt="" style="height:100px; width: 70px;margin-right: 25px;">
	                ${option ? '' : '['+(index+1)+']등  '}${item.prfnm}
	                </div>
	                <div class="prf-place" style="display: flex; justify-content: center; align-items: center;">
	                  	
	                	${option ? item.fcltynm : item.prfplcnm}
	                </div>
	                <div class="prf-period" style="display: flex; justify-content: center; align-items: center;">
	                  ${option ? item.prfpdfrom : item.prfpd}
	                  ${option ? '<p style="text-align:center;">~</p>' : ''}
	                  ${option ? item.prfpdto : ''}
	                </div>
                </div>
            `;
        });
        console.log('html=>'+html);
    	
        $('.main .list .content').html(html);
        $('.main .list .content .item').css({'display': 'flex',})

    };
    //각종 이벤트 리스너 등록
    $('.main .sort').on('click', 'li', function(){
    	console.log('this=> '+$(this).find('a').text());
    	sort = $(this).find('a').text();
    	switch(sort){
    		case '금일랭킹순':
    			makeList(boxofs, false);
    			updateList(boxofs, false);
    		break;
    		case '공연이름순':
    			makeList(dbs, true);
    			updateList(dbs, true);
        	break;
    		case '공연종료일임박순':
    			makeList(dbs, true);
    			updateList(dbs, true);
        	break;
    	}
    	$('.main .sort li').css({'backgroundColor': '#fff'});
    	$(this).css({'backgroundColor': '#eee'})
    	
    });
    
    // 공연상세정보화면으로 가기 위한 리스너 등록
    $('.main .list .content').on('mouseover', '.item', function(){
    	$(this).css({'background': '#eee', 'cursor': 'pointer'});
    });
    $('.main .list .content').on('mouseout', '.item', function(){
    	$(this).css({'background': '#fff',});
    });
    $('.main .list .content').on('click', '.item', function(){
    	console.log('data-id: '+$(this).data('id'));
    	location.href = '/ticketing/detail.do?mt20id='+$(this).data('id');
    	
    });


    console.log('updateList();');
    makeList(dbs, true);
    updateList(dbs, true);




});