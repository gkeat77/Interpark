package kr.kosmo.jobkorea.ticketing.service;

import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.login.dao.LoginDao;
import kr.kosmo.jobkorea.ticketing.dao.ReviewDao;
import kr.kosmo.jobkorea.ticketing.model.Review;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	private ReviewDao reviewDao;

	@Override
	public List<Review> getReviews(String mt20id) {
		
		return reviewDao.getReviews(mt20id);
	}

	@Override
	public int deletetReview(long uid) {
		
		return reviewDao.deletetReview(uid);
	}

	@Override
	public int insertReview(Review review) {
		
		return reviewDao.insertReview(review);
	}

}
