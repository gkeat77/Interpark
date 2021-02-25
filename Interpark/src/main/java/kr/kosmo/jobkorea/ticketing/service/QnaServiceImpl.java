package kr.kosmo.jobkorea.ticketing.service;

import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.login.dao.LoginDao;
import kr.kosmo.jobkorea.ticketing.dao.QnaDao;
import kr.kosmo.jobkorea.ticketing.dao.ReviewDao;
import kr.kosmo.jobkorea.ticketing.model.Qna;
import kr.kosmo.jobkorea.ticketing.model.Review;

@Service
public class QnaServiceImpl implements QnaService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	private QnaDao qnaDao;

	@Override
	public List<Qna> getQna() {
		
		return qnaDao.getQna();
	}

	@Override
	public int deletetQna(long uid){
		
		return qnaDao.deletetQna(uid);
	}

	@Override
	public int insertQna(Qna qna){
		
		return qnaDao.insertQna(qna);
	}

	

}
