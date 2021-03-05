package kr.kosmo.jobkorea.system.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.system.model.ComnCodUtilModel;
import kr.kosmo.jobkorea.system.model.ComnDtlCodModel;
import kr.kosmo.jobkorea.system.model.ComnGrpCodModel;
import kr.kosmo.jobkorea.system.model.MenuModel;

public interface MenuDao {

	public List<MenuModel> menuList (Map<String, Object> paramMap);
}
