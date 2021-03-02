package kr.kosmo.jobkorea.ticketing.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import kr.kosmo.jobkorea.ticketing.model.Runtime;
import kr.kosmo.jobkorea.ticketing.model.Seat;

public class ConvertStringToObjectList {

	public static List<Seat> getSeatsFromString(String pcseguidance, String mt20id){
		List<Seat> seats = new ArrayList<>();
		String[] priceArr = pcseguidance.split(", ");//[ "VIP석 15,000원", , ,...]
		for(int i=0; i<priceArr.length; i++){
			Seat seat = new Seat();
			seat.setMt20id(mt20id);
			String seatName = priceArr[i].split(" ")[0];
			Integer seatPrice = Integer.parseInt(priceArr[i].split(" ")[1].replaceAll("[^0-9]", ""));
			seat.setName(seatName);
			seat.setPrice(seatPrice);
			seats.add(seat);
		}
		System.out.println("seats: ");
		System.out.println(seats);
			
		return seats;
	}
		
	public static List<Runtime> getRuntimesFromString(String dtguidance, String mt20id){
		List<String> days = Arrays.asList("일요일","월요일","화요일","수요일","목요일","금요일","토요일");
		List<Runtime> runtimes = new ArrayList<>();
		
		String[] runtimeArr = dtguidance.split(", ");
		// 화요일(19:30), 목요일~금요일(19:30)
		for(int i=0; i<runtimeArr.length; i++){
			if(runtimeArr[i].contains("~")){
				
				//기간
				String[] duration = runtimeArr[i].split("~");
				//시작요일
				String dayFrom = duration[0].trim();
				//종료요일
				String dayTo = duration[1].substring(1,4).trim();
				//상영시간(다수)
				String times = runtimeArr[i].substring(10, runtimeArr[i].length()-1);
				String[] timesArr = times.split(",");
				int from = days.indexOf(dayFrom);
				int to = days.indexOf(dayTo);
				if(from>to){ to=to+7;}
				for(int k=from; k<=to; k++){
					
					for(int j=0; j<timesArr.length; j++){
						Runtime rt = new Runtime();
						rt.setMt20id(mt20id);
						System.out.println(days.get(k%7)+"/"+timesArr[j]);
						rt.setDayOfWeek(days.get(k%7));
						rt.setTime(timesArr[j]);
						
						runtimes.add(rt);
					}
				}
				
			} else {
				//특정요일(다수)
				
				String day = runtimeArr[i].substring(0,3);
				String times = runtimeArr[i].substring(4, runtimeArr[i].length()-1);
				String[] timesArr = times.split(",");
				for(int j=0; j< timesArr.length; j++){
					Runtime rt = new Runtime();
					rt.setMt20id(mt20id);
					System.out.println("day: "+day+" times: "+timesArr[j]);
					rt.setDayOfWeek(day);
					rt.setTime(timesArr[j]);
					
					runtimes.add(rt);
				}
			}
		}//for end
			
		return runtimes;
	}
				
	
}
