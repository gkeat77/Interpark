package kr.kosmo.jobkorea.ticketing.service;

import java.util.List;

import kr.kosmo.jobkorea.ticketing.model.Qna;
import kr.kosmo.jobkorea.ticketing.model.Review;

public interface QnaService {
	
	//Q&A 데이터 가져오기()
	public List<Qna> getQna();
	
	//Q&A 데이터 삭제(primary key(uid)로)
	public int deletetQna(long uid);
	
	//관람후기 데이터 입력
	public int insertQna(Qna qna);
}
