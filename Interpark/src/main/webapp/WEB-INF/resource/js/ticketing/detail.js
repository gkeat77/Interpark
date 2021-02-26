$(document).ready(function () {
	const dbJson = JSON.parse($('#dbStr').val());
	const days = ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"];
	// 관람후기 데이터 가져오기
	$.ajax({
		url: "/ticketing/review.do?mt20id="+dbJson.mt20id,
		dataType: "json",
	})
	.done(function(res){
		
		console.log(res);
		$('.tabs .review a').text('관람후기('+ res.length +')');
		console.log(res);
		
		let html = "";
		res.forEach(function(item, index){
			let localeString = new Date(parseInt(item['regdate'])).toLocaleString();
			console.log(localeString);
			html += `
			  <div class="item" style="border-bottom: 1px solid #999; padding: 10px; margin-bottom: 5px;">
				<div class="id">${item.loginID}</div>
				<div class="date">${localeString}</div>
				<div class="content">${item.content}</div>
			  </div>
			`;
		});
		$('.tab-content .review').html(html);
			
	})
	.fail(function(err){
		console.log('err: '+err);
	})
	.always(function(data){
		console.log('always~~~');
		console.log(data);
	});
	
	// Q&A 데이터 가져오기
	$.ajax({
		url: "/ticketing/qna.do",
		dataType: "json",
	})
	.done(function(res){
		
		console.log(res);
		const questions = res.filter(function(item){ return item.qora === 'q'});
		
		$('.tabs .qna a').text('Q&A('+ questions.length +')');
		let html = "";
		questions.forEach(function(item, index){
		
			html += `
			  <div class="item" style="border-bottom: 1px solid #999; padding: 10px; margin-bottom: 5px;">
				<div class="content">${item.content}</div>
			  </div>
			`;
		});
		$('.tab-content .qna').html(html);
		
		
	})
	.fail(function(err){
		console.log('err: '+err);
	})
	.always(function(data){
		console.log('always~~~');
		console.log(data);
	});
	
	
	
	
	
	
	
	
	// 달력설정
	const today = new Date();
	let minDate = new Date(dbJson.prfpdfrom); //시작일
	minDate = minDate.getTime() <= today.getTime() ? 0 : minDate;
	let maxDate = new Date(dbJson.prfpdto);	//종료일
	maxDate = maxDate.getTime() <= today.getTime() ? 0 : maxDate;
	console.log(minDate);
	console.log(maxDate);
	$('.calendar').datepicker({
		inline: true,
		dateFormat: 'yy.mm.dd',
		yearSuffix: '년',
		minDate: minDate,
		maxDate: maxDate,
		showOtherMonths: true,
		showMonthAfterYear: true,
		dayNamesMin: ['일','월','화','수','목','금','토'],
		monthNames: ['1월', '2월', '3월', '4월','5월','6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		onSelect: function(dateText, inst){
			const runtimes = dbJson.runtimes;
			const dayOfWeek = days[new Date(dateText).getDay()];
			
			// 날짜에 해당하는 상영시간 보여줌
			const timesForDate = runtimes.filter( item => item.dayOfWeek === dayOfWeek);
			console.log('<timesForDate>');
			console.log(timesForDate);
			console.log()
			 let html = `
			 	<div class="date-info" style="text-align: center;">
			 		<span class="date">${dateText}</span>&nbsp;&nbsp;<span class="day">${dayOfWeek}</span>
			 	</div>
			 `;
			 timesForDate.forEach(item => {
				html += `
				<div class="times" style="text-align: center;">
					<span>${item.time}</span>
				</div>
				`; 
			 });
			
			$('.booking .dtguidance').html(html);
					
		},
		beforeShowDay: function(date){
			
			let dayOfWeek = days[date.getDay()];
			const runtimes = dbJson.runtimes;	
			let flag = false;
			
			for( const item of runtimes){
				
				if(item.dayOfWeek === dayOfWeek) {
					flag = true;
					break;
				};
			}	
			return [flag,"",""];
		},
	});//datepicker end
	
	// 탭화면 컨트롤
	$('.tabs ul li').click(function(){
		const temp = $(this).attr('class');
		$('.tabs ul li').css({background: '#fff', color: 'black'})
		$(this).css({background: '#bbb', color: 'white'});
		$('.tab-content > div').hide();
		$('.tab-content .'+temp).show();
	});
	
	// 다음(좌석선택) 화면으로...
	$('button').click(function(){
		// 예약정보 모으기
		// 공연ID(mt20id), 예약일자(date), 요일(day), 상영시간(times)
		const mt20id = dbJson.mt20id;
		const date = $('.booking .dtguidance .date-info .date').text();
		const day = $('.booking .dtguidance .date-info .day').text();
		const times = $('.booking .dtguidance .times span.active').text() || 'N';
		location.href = `/ticketing/booking.do?mt20id=${mt20id}&date=${date}&day=${day}&times=${times}`;
		console.log('location : clicked!!!');
	});
	
	// 상영시간 선택하기
	$('.booking .dtguidance').on('click', '.times span', function(){
		if($(this).hasClass('active')) {
			$(this).removeClass('active');
		} else {
			$('.booking .dtguidance .times span').removeClass('active');
			$(this).addClass('active');
		}
	});
	


});