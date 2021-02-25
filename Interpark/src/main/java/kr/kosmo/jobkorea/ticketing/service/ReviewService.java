package kr.kosmo.jobkorea.ticketing.service;

import java.util.List;

import kr.kosmo.jobkorea.ticketing.model.Review;

public interface ReviewService {
	
	//관람후기 데이터 가져오기(mt20id기준 등록일 역순으로)
	public List<Review> getReviews(String mt20id);
	
	//관람후기 데이터 삭제(primary key(uid)로)
	public int deletetReview(long uid);
	
	//관람후기 데이터 입력
	public int insertReview(Review review);
}
