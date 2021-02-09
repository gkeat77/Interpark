package kr.kosmo.jobkorea.book.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.book.dao.bookDao;
import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;
@Service





public class bookServiceImpl implements bookService{

	
	@Autowired
	bookDao bookDao;
	
	@Override
	public List<CategoryModel> cateList(int level) {
		return null;
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
		return null;
	}

}
