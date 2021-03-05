package kr.kosmo.jobkorea.book.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.book.dao.bookDao;
import kr.kosmo.jobkorea.book.dao.reviewDao;
import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;
import kr.kosmo.jobkorea.book.model.reviewModel;
@Service

public class reviewServiceImpl implements reviewService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	reviewDao revDao;

	@Override
	public int reviewReg(Map<String, Object> paramMap) {
		return revDao.reviewReg(paramMap);
	}

	@Override
	public List<reviewModel> reviewList(Map<String, Object> paramMap) {
		return revDao.reviewList(paramMap);
	}

	@Override
	public int reviewDel(Map<String, Object> paramMap) {
		return revDao.reviewDel(paramMap);
	}

	@Override
	public int reviewLike(Map<String, Object> paramMap) {
		return revDao.reviewLike(paramMap);
	}

	@Override
	public int reviewCount(Map<String, Object> paramMap) {
		return revDao.reviewCount(paramMap);
	}

	@Override
	public int likeChk(Map<String, Object> paramMap) {
		return revDao.likeChk(paramMap);
	}
	
	
	

}
