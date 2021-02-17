package kr.kosmo.jobkorea.book.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.book.dao.bookDao;
import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;
@Service





public class bookServiceImpl implements bookService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	bookDao bookDao;
	
	@Override
	public List<CategoryModel> cateList(Map<String,Object> paramMap) {
		return bookDao.cateList(paramMap);
	}

	@Override
	public List<BookModel> goodsList(Map<String, Object> paramMap) {
		return bookDao.goodsList(paramMap);
	}

	@Override
	public int goodsCount(Map<String, Object> paramMap) {
		return bookDao.goodsCount(paramMap);
	}

	@Override
	public BookModel goodsDetail(Map<String, Object> paramMap) {
		return bookDao.goodsDetail(paramMap);
	}

	@Override
	public BookModel bookInfo(String itemId) {
		return bookDao.bookInfo(itemId);
	}

}
