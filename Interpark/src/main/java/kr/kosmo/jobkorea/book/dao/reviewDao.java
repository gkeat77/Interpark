package kr.kosmo.jobkorea.book.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;
import kr.kosmo.jobkorea.book.model.reviewModel;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;


public interface reviewDao {
	
	public int reviewReg (Map<String, Object> paramMap);
	
	public List<reviewModel> reviewList (Map<String, Object> paramMap);
	
	public int reviewCount (Map<String, Object> paramMap);
	
	public int reviewDel (Map<String, Object> paramMap);
	
	public int reviewLike (Map<String, Object> paramMap);
	
	public int likeChk (Map<String, Object> paramMap);
}
