package kr.kosmo.jobkorea.book.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.kosmo.jobkorea.book.dao.bookAdminDao;
import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;
import kr.kosmo.jobkorea.common.comnUtils.FileUtilCho;

@Service
public class bookAdminServiceImpl implements bookAdminService{
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	// 파일 업로드 위한 어노테이션 
	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.rootFilePath}")
	private String rootFilePath;
	
	@Autowired
	bookAdminDao bookDao;
	
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
	public int updateGoodsInfo(Map<String, Object> paramMap,HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest)request;
		int count = 0;
		String itemId = (String) paramMap.get("itemId");
		//새 파일 저장경로 설정
		String itemFilePath = "img" + File.separator + File.separator +itemId+ File.separator + File.separator;
		FileUtilCho fileUtilCho = new FileUtilCho(mpRequest, rootPath, itemFilePath);
		Map<String, Object> listFileUtilModel = fileUtilCho.uploadFiles();
		try{
			//파일 외 정보 수정
			count=bookDao.updateGoodsInfo(paramMap);
			//경로 설정
			listFileUtilModel.put("itemId", paramMap.get("itemId"));
			//기존 상품 정보 가져오기
			BookModel model = bookDao.deleteList(paramMap);
			logger.info("기존파일명:"+model.getFile_nm()); 
			logger.info("새로운 파일명:"+mpRequest.getFile("bbs_files_1")); 
			
			//새 파일올리면
			if(mpRequest.getFile("bbs_files_1").getSize()>0){
				logger.info("새로운 파일이 있습니다.");
				//기존파일 삭제
				Map<String, Object> deleteFile = new HashMap<>(); 
				deleteFile.put("rootfilePath",rootPath);
				deleteFile.put("file_nm",rootPath+"\\img\\\\"+paramMap.get("itemId")+"\\"+model.getFile_nm());
				fileUtilCho.deleteFiles(deleteFile);
				//DB 파일정보 삭제
				int deleteCount= bookDao.deleteFileInfo(paramMap);
				if(deleteCount > 0 ){
					listFileUtilModel.put("pId", paramMap.get("pId"));
					bookDao.updateFileInfo(listFileUtilModel); //새 파일 정보 db저장
				}
			}else{
				logger.info("파일이 없습니다");
			}
			
		}catch(Exception e){
			fileUtilCho.deleteFiles(listFileUtilModel);
		}
		return count;
	}
	
	@Override
	public List<CategoryModel> cateList() {
		return bookDao.cateList();
	}


	@Override
	public List<BookModel> goodsList(Map<String,Object> paramMap) {
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
	public int deleteGoods(Map<String, Object> paramMap){
		
		int count=0;
		
		FileUtilCho fileUtilCho = new FileUtilCho();
		BookModel model = bookDao.deleteList(paramMap);
		Map<String, Object> deleteFile = new HashMap<>();
		//삭제 파일 정보 가져오기
		deleteFile.put("file_nm",rootPath+"\\img\\\\"+paramMap.get("itemId")+"\\"+model.getFile_nm());
		// 파일 삭제
		try {
			//파일삭제
			fileUtilCho.deleteFiles(deleteFile);
			//상품 DB 정보삭제
			count = bookDao.deleteGoods(paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}


	@Override
	public int deleteImg(Map<String, Object> paramMap) {
		int count=0;
		
		FileUtilCho fileUtilCho = new FileUtilCho();
		BookModel model = bookDao.deleteList(paramMap);
		Map<String, Object> deleteFile = new HashMap<>();
		//삭제 파일 정보 가져오기
		deleteFile.put("file_nm",rootPath+"\\img\\\\"+paramMap.get("itemId")+"\\"+model.getFile_nm());
		// 파일 삭제
		try {
			//파일삭제
			fileUtilCho.deleteFiles(deleteFile);
			//파일 DB 정보삭제
			count = bookDao.deleteFileInfo(paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}



}
