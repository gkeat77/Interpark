package kr.kosmo.jobkorea.ticketing.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.ticketing.dao.IntroDao;
import kr.kosmo.jobkorea.ticketing.model.Boxof;
import kr.kosmo.jobkorea.ticketing.util.Helper;
import kr.kosmo.jobkorea.ticketing.util.XmlParse;

@Service
public class IntroServiceImpl implements IntroService {
	
	@Autowired
	IntroDao introDao;
	
	//예매상황판 조회
	public List<Boxof> getBoxofs(LocalDate date){
		List<Boxof> boxofs = null;
		
		String dateString = Helper.getDateStr(date);//날짜형식 20210301
		
		boxofs = introDao.getBoxofs(dateString);//내부 서버에서 데이터 먼저 가져옴
		if(boxofs.size() == 0 || !dateString.equals(boxofs.get(0).day)){
			
			boxofs = XmlParse.getBoxofs("month", dateString, null, null);
			
			System.out.println("박스오피스 서버에 저장 : "+boxofs);
			int result = insertBoxofs(boxofs);
			System.out.println("박스오피스 서버저장 결과: "+result);
			
		}
		
		return boxofs;
	}

	@Override
	public int insertBoxofs(List<Boxof> boxofs) {
		System.out.println("IntroServiceImpl insertBoxofs: "+boxofs);
		return introDao.insertBoxofs(boxofs);
	};
}
