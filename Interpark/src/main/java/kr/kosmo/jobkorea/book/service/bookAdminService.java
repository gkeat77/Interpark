package kr.kosmo.jobkorea.book.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;

public interface bookAdminService {
	
	/* 관리자 */
	public int BookRegister(Map<String, Object> paramMap,HttpServletRequest request) throws Exception;
	
	public List<CategoryModel> cateList();
	
	public List<BookModel> goodsList(Map<String,Object> paramMap);
	
	public int goodsCount(Map<String,Object> paramMap);

	public BookModel goodsDetail(Map<String,Object> paramMap);
	
	public int updateGoodsInfo(Map<String,Object> paramMap,HttpServletRequest request) throws Exception;
	
	public int deleteGoods(Map<String,Object> paramMap);
	
	public int deleteImg(Map<String,Object> paramMap);

	
}
