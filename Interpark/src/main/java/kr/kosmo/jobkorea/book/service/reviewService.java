package kr.kosmo.jobkorea.book.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;
import kr.kosmo.jobkorea.book.model.reviewModel;

public interface reviewService {
	
	public int reviewReg (Map<String, Object> paramMap);
	
	public List<reviewModel> reviewList (Map<String, Object> paramMap);
	
	public int reviewCount (Map<String, Object> paramMap);
	
	public int reviewDel (Map<String, Object> paramMap);
	
	public int reviewLike (Map<String, Object> paramMap);
	
	public int likeChk (Map<String, Object> paramMap);
	
}
