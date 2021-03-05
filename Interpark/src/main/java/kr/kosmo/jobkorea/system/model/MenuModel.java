package kr.kosmo.jobkorea.system.model;

import java.util.List;

public class MenuModel {

	private String menuId;
	
	private String menuName;
	
	private String menuUrl;
	
	private String menuHigh;
	
	private String menuAuth;
	
	private String menuType;
	
	private String menuLvl;
	
	private List<MenuModel> lowerMenuList;

	
	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuUrl() {
		return menuUrl;
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}

	public String getMenuHigh() {
		return menuHigh;
	}

	public void setMenuHigh(String menuHigh) {
		this.menuHigh = menuHigh;
	}

	public String getMenuAuth() {
		return menuAuth;
	}

	public void setMenuAuth(String menuAuth) {
		this.menuAuth = menuAuth;
	}

	public String getMenuType() {
		return menuType;
	}

	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}

	public String getMenuLvl() {
		return menuLvl;
	}

	public void setMenuLvl(String menuLvl) {
		this.menuLvl = menuLvl;
	}

	public List<MenuModel> getLowerMenuList() {
		return lowerMenuList;
	}

	public void setLowerMenuList(List<MenuModel> lowerMenuList) {
		this.lowerMenuList = lowerMenuList;
	}

	@Override
	public String toString() {
		return "MenuModel [menuId=" + menuId + ", menuName=" + menuName + ", menuUrl=" + menuUrl + ", menuHigh="
				+ menuHigh + ", menuAuth=" + menuAuth + ", menuType=" + menuType + ", menuLvl=" + menuLvl
				+ ", lowerMenuList=" + lowerMenuList + "]";
	}

	
	
}
