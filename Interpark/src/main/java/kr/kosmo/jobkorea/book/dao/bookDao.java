package kr.kosmo.jobkorea.book.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;


public interface bookDao {
	
	/* 일반 */
	
	public List<CategoryModel> cateList(Map<String,Object> paramMap);
	
	public List<BookModel> goodsList(Map<String,Object> paramMap);
	
	public int goodsCount(Map<String,Object> paramMap);
	
	public BookModel goodsDetail(Map<String,Object> paramMap);
	
	public BookModel bookInfo (String itemId);  
	
	public void cartAdd(BookModel vo);
	
}
