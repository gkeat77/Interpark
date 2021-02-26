package kr.kosmo.jobkorea.ticketing.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import kr.kosmo.jobkorea.ticketing.dao.DetailDao;
import kr.kosmo.jobkorea.ticketing.model.Boxof;
import kr.kosmo.jobkorea.ticketing.model.Db;
import kr.kosmo.jobkorea.ticketing.model.Seat;
import kr.kosmo.jobkorea.ticketing.model.Runtime;
import kr.kosmo.jobkorea.ticketing.util.XmlParse;

@Service
public class DetailServiceImpl implements DetailService{

	@Autowired
	DetailDao detailDao;
	
	@Override
	public Db getDetail(String mt20id) {
		Db db = null;
		
		try{
		// 내부서버에 등록되어 있는지 확인 후
		db = detailDao.getDetail(mt20id);
		if(db == null){
			// 안되있으면 외부 API로 받아오기
			db = XmlParse.getDetailPfr(mt20id);
			
			// 상연일정,좌석가격 DB 별도 생성
			// 티켓가격(pcseguidance)=> seats
			String pcseguide = db.getPcseguidance();
			List<Seat> seats = new ArrayList<>();
			
			String[] priceArr = pcseguide.split(", ");//[ "VIP석 15,000원", , ,...]
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
			
			// 공연시간(dtguidance) => runtimes
			List<String> days = new ArrayList<>();
			days.add("일요일");
			days.add("월요일");
			days.add("화요일");
			days.add("수요일");
			days.add("목요일");
			days.add("금요일");
			days.add("토요일");
			String dtguide = db.getDtguidance();
			List<Runtime> runtimes = new ArrayList<>();
			String[] runtimeArr = dtguide.split(", ");
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
			
			db.setSeats(seats);
			db.setRuntimes(runtimes);
			
			// 내부서버에 저장
			detailDao.insertSeats(seats);
			detailDao.insertRuntimes(runtimes);
			detailDao.insertPrf(db);
			
		} else {
			List<Seat> seats = detailDao.getSeats(mt20id);
			List<Runtime> runtimes = detailDao.getRuntimes(mt20id);
			db.setSeats(seats);
			db.setRuntimes(runtimes);
		}//if end
		
		
		} catch(Exception e){
			System.out.println("Exception: parsing error~~"+e);
		}
		
		return db;
		
		
	}//method end
	
	private void parsingDb(Db db){
		
	}

}
