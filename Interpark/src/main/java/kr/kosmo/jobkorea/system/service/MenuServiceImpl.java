package kr.kosmo.jobkorea.system.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.system.dao.ComnCodDao;
import kr.kosmo.jobkorea.system.dao.MenuDao;
import kr.kosmo.jobkorea.system.model.ComnCodUtilModel;
import kr.kosmo.jobkorea.system.model.ComnDtlCodModel;
import kr.kosmo.jobkorea.system.model.ComnGrpCodModel;
import kr.kosmo.jobkorea.system.model.MenuModel;

@Service
public class MenuServiceImpl implements MenuService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	MenuDao menuDao;

	@Override
	public List<MenuModel> menuList(Map<String, Object> paramMap) {
		return menuDao.menuList(paramMap);
	}

	@Override
	public List<MenuModel> adminList(Map<String, Object> paramMap) {
		return menuDao.adminList(paramMap);
	}
	
	
}
