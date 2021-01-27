package kr.kosmo.jobkorea.book.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;


public interface bookDao {
	
	public int insert(Map<String, Object> paramMap);
	
	public int delete(String cateNum);
	
	public List<String> cateList(String category);

}
