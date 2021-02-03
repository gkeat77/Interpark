package kr.kosmo.jobkorea.book.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.kosmo.jobkorea.book.dao.bookDao;
import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;
import kr.kosmo.jobkorea.common.comnUtils.FileUtilCho;

@Service
public class bookServiceImpl implements bookService{
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	// 파일 업로드 위한 어노테이션 
	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	// comment path for file upload
	@Value("${fileUpload.bbsPath}")
	private String bbsPath;
	
	
	@Autowired
	bookDao bookDao;
	
	@Override
	public int BookRegister(Map<String, Object> paramMap,HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		
		int count = 0;
		
		String itemId = (String) paramMap.get("query");
		
		String itemFilePath = "img" + File.separator + File.separator +itemId+ File.separator + File.separator;
		
		FileUtilCho fileUtilCho = new FileUtilCho(mpRequest, rootPath, itemFilePath);
		Map<String, Object> listFileUtilModel = fileUtilCho.uploadFiles();
		
		paramMap.put("file_nm", listFileUtilModel.get("file_nm"));
		paramMap.put("file_loc", listFileUtilModel.get("file_loc"));
		paramMap.put("file_size", listFileUtilModel.get("file_size"));
		
		logger.info(listFileUtilModel.get("file_nm"));
		logger.info(listFileUtilModel.get("file_loc"));
		logger.info(listFileUtilModel.get("file_size"));
		
		try {
			count = bookDao.BookRegister(paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}


	@Override
	public int delete(String cateNum) {
		return bookDao.delete(cateNum);
	}


	@Override
	public List<CategoryModel> cateList() {
		return bookDao.cateList();
	}

}
