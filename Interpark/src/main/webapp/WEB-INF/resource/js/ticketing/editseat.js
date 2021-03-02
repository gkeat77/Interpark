
$(function(){
	const state = {};
	//공연검색버튼 클릭시
	$('#search-btn').click(function(){
		
		let searchStr = $('#search').val().trim();
		$.ajax({
			url: '/ticketing/admin/searchprf.do?searchStr='+searchStr,
			dataType: 'json',
		}).done(function(res){
			let html = "<div style='overflow:auto; height: 500px'><table>";
			html += "<thead> <tr>";
			html += "<th>번호</th><th>공연ID</th><th style='width: 150px;'>공연명</th>";
			html += "</tr></thead>";
			html += "<tbody>"
			res.forEach(function(item,index){
				console.log('item.pcseguidance');
				console.log(item.pcseguidance);
				html += "<tr class='search-row'>";
				html += '<input type="hidden" value="'+item.pcseguidance+'" >';
				html += "<td style='text-align:center;'>"+ parseInt(index+1) +"</td>";
				html += "<td class='mt20id'>"+ item.mt20id +"</td>";
				html += "<td class='prfnm' >";
				html += "<div style='width: 150px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;'>"+item.prfnm +"</div></td>";
				html += "</tr>"
			});
			html += "</tbody></table></div>";
			html += "<div style='text-align:center; padding: 10px;'><input type='button' value='선택완료' id='select-btn'></div>"
			$('.edit > .search-result').html(html);
			
			$('table .search-row').mouseover(function(){
				$(this).css({cursor:'pointer', background:'#ddd', height: '18px'});
			});
			$('table .search-row').mouseout(function(){
				$(this).css({cursor:'none', background:'#fff', height: '18px'});
			});
			$('.search-result').css({'border': '1px solid #999'});
					
		}).fail(function(err){
			console.log('/ticketing/admin/searchprf err occured!!!',err);
		});
	});
	
	//공연선택
	$('.search-result').on('click', 'tr', function(){
		let prfnm = $(this).find('.prfnm').text();
		let mt20id = $(this).find('.mt20id').text();
		let pcseguidance = $(this).find('input').val();
		$('.prf-title').text(prfnm+"("+mt20id+")");//공연제목 갱신
		$('#pcseguidance').val(pcseguidance);
		//공연좌석 배치도 갱신
		refreshSeatsPosition( mt20id );
		
	});
	$('.search-result').on('click', '#select-btn', function(){
		//검색결과 창닫고 입력선택창 보이기
		$('.search-result').css({border: '0'}).empty();
		$('.search-result').html(inputSelect());
	});
	
	// 좌석배치도 갱신
	const refreshSeatsPosition = function (mt20id) {
		//좌석데이터 가져오기
		
		//배치도 갱신(default: 20X30)
		let html = "<table class=''>";
		for(let i=0;i<20;i++){
			html += "<tr>";
			for( let j=0; j<30; j++){
				if( i === 0 || j === 0){
					html += "<td class='secondary' style='position:relative;' data-row='"+i+"' data-col='"+j+"'>";
					html += "<input type='text' style='width:17px;'/>";
					html += "</td>";
				} else {
					html += "<td  class='primary' style='position:relative;' data-row='"+i+"' data-col='"+j+"'>";
					html += "</td>";
				}
				
			}
			html += "</tr>";
		}
		
		html += "</table>";
		
		$('.seats .contents').html(html);
	
	};
	
	//입력선택창 만들기
	const inputSelect = function(){
		const pcseguidance = $('#pcseguidance').val();
		let html = "";
		html += `
		<div class="tdInfo">
		    <div class="current-pos" style="display:flex; justify-content:center;align-items:center;margin-bottom: 10px;">
		        <p class="row-col" style=" text-align:center; color: #000; width: 150px; border: 1px solid #999; border-radius: 20px; background: #ddd;" ></p>
		    </div>
		    <div class="pcse-guide" style="padding: 10px; border: 1px solid #999;margin-bottom:10px;">${pcseguidance}</div>
		    <div class="cate" style="margin-bottom:10px;">
			    <label>좌석종류</label><br>
		        <input type="radio" name="cate" value="예약">예약
		        <input type="radio" name="cate" value="비예약">비예약
		        <input type="radio" name="cate" value="복도">복도
		        <input type="radio" name="cate" value="없음">없음
		    </div>
		    <div class="grade" style="margin-bottom:10px;"> 	
		    	<label>좌석등급</label><br>
		        <input type="radio" name="grade" value="VIP석">VIP석
		        <input type="radio" name="grade" value="S석">S석
		        <input type="radio" name="grade" value="R석">R석
		        <input type="radio" name="grade" value="A석">A석
		        <input type="radio" name="grade" value="B석">B석
		        <input type="radio" name="grade" value="C석">C석        
		    </div>
		    
		    <div class="zone" style="margin-bottom:10px;">
			    <label>구역종류</label><br>
		        <input type="radio" name="zone" value="A구역">A구역
		        <input type="radio" name="zone" value="B구역">B구역
		        <input type="radio" name="zone" value="C구역">C구역
		        <input type="radio" name="zone" value="D구역">D구역
		    </div>
		    <div class="level" style="margin-bottom:10px;">
			    <label>층</label><br>
		        <input type="radio" name="level" value="1층">1층
		        <input type="radio" name="level" value="2층">2층
		        <input type="radio" name="level" value="3층">3층
		        
		    </div>
		    <div>
			    <label>좌석이름</label><br>
		        <input type="text" name="name" id="">
		    </div>
		</div>
		`;
		return html;
	};
	
	//좌석배치도 클릭시...
	$('.seats .contents').on('click', 'td.primary', function(){
		const row = $(this).data('row');
		const col = $(this).data('col');
		$('.current-pos .row-col').text(row+"행, "+col+"열");
		$('.current-pos .row-col').attr('data-row', row);
		$('.current-pos .row-col').attr('data-col', col);
		$('.seats .contents td').removeClass('current');
		$(this).addClass('current');
		
		//상태값 변경
		state.row = row;
		state.col = col;
		
		//리프레시 
	});
	
	// inputSelect 내부 클릭시...
	$('.search-result').on('click', 'input', function(){
		let inputName = $(this).attr('name');
		let $currentTd = $('.seats .contents td.current');
		$currentTd.attr('data-'+inputName, $(this).val());
		
		//상태값 변경
		state[inputName] = $(this).val();
		
		//리프레시
		refreshSeatName();
		
		
	});
	
	//secondary 
	$('.seats .contents').on('change', 'td.secondary input', function(){
		
		$parent = $(this).parent();
		const data = $(this).val();
		const row = parseInt($parent.data('row'));
		const col = parseInt($parent.data('col'));
		console.log('row:'+row);
		console.log('col:'+col);
		if(row === 0){
			for(let i=1; i< 20; i++){
				$('.seats .contents td[data-row="'+i+'"][data-col="'+col+'"]').attr('data-cols', data);
			}
		}
		if(col === 0){
			for(let i=1; i< 30; i++){
				$('.seats .contents td[data-row="'+row+'"][data-col="'+i+'"]').attr('data-rows', data);
			}
		}
		console.log('change >>>'+$(this).val());
		
		//리프레시
		refreshSeatName();
		
	});
	
	const refreshSeatName = function(){
		console.log('state: ');
		console.log(state);
		/*
		var $currentTd = $('.seats .contents td.current');
		var cate = $currentTd.data('cate');
		var zone = $currentTd.data('zone');
		var cols = $currentTd.data('cols');
		var rows = $currentTd.data('rows');
		var level = $currentTd.data('level');
		console.log(cate+zone+cols+rows+level);
		if(cate === '예약'){
			var temp = level+" "+zone+" "+rows+"-"+cols;
			$('input[name="name"]').val(temp);
			$currentTd.attr('data-name', temp);
		} else {
			$('input[name="name"]').val(cate);
			$currentTd.attr('data-name', cate);
		}
		*/
	}//refreshSeatName end
	
	
	
});