package kr.kosmo.jobkorea.book.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;

public interface bookService {
	
	/* 일반 */
	
	public List<CategoryModel> cateList(Map<String,Object> paramMap);
	
	public List<BookModel> goodsList(Map<String,Object> paramMap);
	
	public int goodsCount(Map<String,Object> paramMap);
	
	public BookModel goodsDetail(Map<String,Object> paramMap);
	
	// ahn
	public BookModel bookInfo (String itemId);
	public void cartAdd(BookModel vo);
	
}
