package kr.kosmo.jobkorea.book.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.book.dao.bookDao;
import kr.kosmo.jobkorea.book.model.BookModel;

@Service
public class bookServiceImpl implements bookService{

	@Autowired
	bookDao bookDao;
	
	@Override
	public int insert(Map<String, Object> paramMap) {
		return bookDao.insert(paramMap);
	}

	@Override
	public List<String> cateList(String category) {
		return bookDao.cateList(category);
	}

	@Override
	public int delete(String cateNum) {
		return bookDao.delete(cateNum);
	}

}
