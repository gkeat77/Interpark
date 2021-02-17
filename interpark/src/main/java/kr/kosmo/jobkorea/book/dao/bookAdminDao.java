package kr.kosmo.jobkorea.book.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;


public interface bookAdminDao {
	
	/* 관리자 */
	public int BookRegister(Map<String, Object> paramMap);
	
	public List<CategoryModel> cateList(); 
	
	public List<BookModel> goodsList(Map<String,Object> paramMap);
	
	public int goodsCount(Map<String,Object> paramMap);
	
	public BookModel goodsDetail(Map<String,Object> paramMap);
	
	public int updateGoodsInfo(Map<String,Object> paramMap);
	
	public BookModel deleteList(Map<String,Object> paramMap);
	
	public int deleteFileInfo(Map<String,Object> paramMap);
	
	public int updateFileInfo(Map<String,Object> paramMap);
	
	public int deleteGoods(Map<String,Object> paramMap);
	
	
	
}
