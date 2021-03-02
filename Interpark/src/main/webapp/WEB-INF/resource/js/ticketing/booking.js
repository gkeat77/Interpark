
$(function(){
	const dbJson = JSON.parse($('#dbStr').val());
	const days = ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"];
	const seatColor = {
			'VIP석': '#bc42f5', 'S석':'#41f0f0', 'R석': '#22c922'
			, 'A석': '#f07d48', 'B석': '#4c61ed', '화수목VIP': '#ecabf5'
			, '화수목R': '#dbda74', '화수목S': '#77e0a6', '금토일VIP': '#ed614e'
			, '금토일R': '#5f85ed', '금토일S': '#8ed147', '전석': '#52d96d'
			, '시카고석': '#c0cf53', '1층석': '#9f89e8', '2층석': '#c7ac69'
			,
	};//VIP,S,R,A,B,화수목VIP,화수목R,화수목S,금토일VIP,금토일R,금토일S	
	
	$.datepicker.setDefaults({
        dateFormat: 'yy.mm.dd',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
        showMonthAfterYear: true,
        yearSuffix: '년'
	});
	
	const today = new Date();
	let minDate = new Date(dbJson.prfpdfrom); //시작일
	minDate = minDate.getTime() <= today.getTime() ? 0 : minDate;
	let maxDate = new Date(dbJson.prfpdto);	//종료일
	maxDate = maxDate.getTime() <= today.getTime() ? 0 : maxDate;
	console.log(minDate);
	console.log(maxDate);
	
	$('#dateInput').datepicker({
			
		minDate: minDate,
		maxDate: maxDate,
		onSelect: function(dateText, instance){
			const dayOfWeek = days[new Date(dateText).getDay()];//요일추출
			const timesForDate = dbJson.runtimes.filter( item => item.dayOfWeek === dayOfWeek);//요일에 해당하는 상영시간 추출
			console.log(timesForDate);
			let html = "";
			html += "<option selected>선택</option>";
			timesForDate.forEach(item => {
				html += "<option value="+ item.time +" >"+ item.time+"</option>";
			});
			$('#select-time').html(html);
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
	});
	console.log('datepicker');
	
	//좌석에 색깔 배정
	$('.fa-square').each(function() {
		let color = seatColor[$(this).data('grade')];
		$(this).css({color: color});
	})
	
	
	
});