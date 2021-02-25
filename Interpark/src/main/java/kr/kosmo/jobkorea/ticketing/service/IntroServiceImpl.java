package kr.kosmo.jobkorea.ticketing.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.ticketing.dao.IntroDao;
import kr.kosmo.jobkorea.ticketing.model.Boxof;
import kr.kosmo.jobkorea.ticketing.util.XmlParse;

@Service
public class IntroServiceImpl implements IntroService {
	
	@Autowired
	IntroDao introDao;
	
	//예매상황판 조회
	public List<Boxof> getBoxofs(LocalDate date){
		List<Boxof> boxofs = null;
		String today = date.getYear()+"";
		today += date.getMonthValue() < 10 ? "0"+date.getMonthValue() : date.getMonthValue();
		today += date.getDayOfMonth() < 10 ? "0"+date.getDayOfMonth() : date.getDayOfMonth();
		
		boxofs = introDao.getBoxofs(today);
		if(boxofs.size() == 0 || !today.equals(boxofs.get(0).day)){
			
			boxofs = XmlParse.getBoxofs("month", today, null, null);
			
			System.out.println("박스오피스 저장 : "+boxofs);
			int result = insertBoxofs(boxofs);
			System.out.println("박스오피스 저장 result: "+result);
			
		}
		
		return boxofs;
	}

	@Override
	public int insertBoxofs(List<Boxof> boxofs) {
		System.out.println("IntroServiceImpl insertBoxofs: "+boxofs);
		return introDao.insertBoxofs(boxofs);
	};
}
