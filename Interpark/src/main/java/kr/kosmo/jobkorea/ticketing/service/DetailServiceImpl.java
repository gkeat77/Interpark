package kr.kosmo.jobkorea.ticketing.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import kr.kosmo.jobkorea.ticketing.dao.DetailDao;
import kr.kosmo.jobkorea.ticketing.model.Boxof;
import kr.kosmo.jobkorea.ticketing.model.Db;
import kr.kosmo.jobkorea.ticketing.model.Seat;
import kr.kosmo.jobkorea.ticketing.model.Runtime;
import kr.kosmo.jobkorea.ticketing.util.ConvertStringToObjectList;
import kr.kosmo.jobkorea.ticketing.util.XmlParse;

@Service
public class DetailServiceImpl implements DetailService{

	@Autowired
	DetailDao detailDao;
	
	@Override
	public Db getDetail(String mt20id) {
		Db db = null;
		
		// 내부서버에 등록되어 있는지 확인 후
		db = detailDao.getDetail(mt20id);
		
		if(db == null){// 등록 안되있으면 외부 API로 받아오기
			
			db = XmlParse.getDetailPfr(mt20id);
			
			// 상연일정,좌석가격 DB 별도 생성
			
			// 티켓가격(pcseguidance)스트링을 객체로 변환
			String pcseguidance = db.getPcseguidance();
			List<Seat> seats = ConvertStringToObjectList.getSeatsFromString(pcseguidance, mt20id);
			
			// 공연시간(dtguidance)스트링 객체 변환
			String dtguidance = db.getDtguidance();
			List<Runtime> runtimes = ConvertStringToObjectList.getRuntimesFromString(dtguidance, mt20id);
			
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

		return db;
	}//method end

}
