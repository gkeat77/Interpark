package kr.kosmo.jobkorea.book.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;

public interface bookService {
	

	public int BookRegister(Map<String, Object> paramMap,HttpServletRequest request) throws Exception;
	
	public int delete(String cateNum);
	
	public List<CategoryModel> cateList();
	
}
