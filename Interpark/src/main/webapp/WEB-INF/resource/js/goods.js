

function displayAvgStar(rStar) {
	rStar = Math.round(rStar);
	
	let star = 0;
	
	if(1<= rStar && rStar <2){
		star=1;
	}else if(2<= rStar && rStar <3){
		star=2;
	}else if(3<= rStar && rStar <4){
		star=3;
	}else if(4<= rStar && rStar <5){
		star=4;
	}else if(rStar ==5){
		star=5;
	}
	
	$(".star").addClass("star"+star);
		
}
