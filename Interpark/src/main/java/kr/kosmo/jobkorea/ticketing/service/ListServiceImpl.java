package kr.kosmo.jobkorea.ticketing.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.ticketing.model.Boxof;
import kr.kosmo.jobkorea.ticketing.model.Db;
import kr.kosmo.jobkorea.ticketing.util.PblpfrRequest;
import kr.kosmo.jobkorea.ticketing.util.XmlParse;

@Service
public class ListServiceImpl implements ListService{

	@Override
	public List<Db> getList(PblpfrRequest request) {
		List<Db> dbs = null;
		// 외부API 이용한 자료가져오기
		dbs = XmlParse.getPfrList(request);
		
		// 
		
		return dbs;
	}


}
