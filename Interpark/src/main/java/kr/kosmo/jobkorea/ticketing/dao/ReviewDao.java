package kr.kosmo.jobkorea.ticketing.dao;

import java.util.List;

import kr.kosmo.jobkorea.ticketing.model.Review;

public interface ReviewDao {
	
	public List<Review> getReviews(String mt20id);
	
	public int deletetReview(long uid);
	
	public int insertReview(Review review);
	
	
}
