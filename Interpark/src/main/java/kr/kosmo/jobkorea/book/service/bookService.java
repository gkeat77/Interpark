package kr.kosmo.jobkorea.book.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.book.model.BookModel;

public interface bookService {
	

	public int insert(Map<String, Object> paramMap);
	
	public int delete(String cateNum);
	
	public List<String> cateList(String category);
	
}
