package kr.kosmo.jobkorea.book.model;

import java.util.List;

public class CategoryModel {
	private String categoryName;
	private String categoryId;
	private String cateClass;
	private int level;
	private List<CategoryModel> lowerCateList;
	
	
	private List<CategoryModel> domesticList; 
	private List<CategoryModel> foreignList; 
	private List<CategoryModel> cdList; 
	private List<CategoryModel> dvdList; 
	
	
	
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public String getCateClass() {
		return cateClass;
	}
	public void setCateClass(String cateClass) {
		this.cateClass = cateClass;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public List<CategoryModel> getLowerCateList() {
		return lowerCateList;
	}
	public void setLowerCateList(List<CategoryModel> lowerCateList) {
		this.lowerCateList = lowerCateList;
	}
	
	
	
	
	public List<CategoryModel> getDomesticList() {
		return domesticList;
	}
	public void setDomesticList(List<CategoryModel> domesticList) {
		this.domesticList = domesticList;
	}
	public List<CategoryModel> getForeignList() {
		return foreignList;
	}
	public void setForeignList(List<CategoryModel> foreignList) {
		this.foreignList = foreignList;
	}
	public List<CategoryModel> getCdList() {
		return cdList;
	}
	public void setCdList(List<CategoryModel> cdList) {
		this.cdList = cdList;
	}
	public List<CategoryModel> getDvdList() {
		return dvdList;
	}
	public void setDvdList(List<CategoryModel> dvdList) {
		this.dvdList = dvdList;
	}
	@Override
	public String toString() {
		return "CategoryModel [categoryName=" + categoryName + ", categoryId=" + categoryId + ", cateClass=" + cateClass
				+ ", level=" + level + ", lowerCateList=" + lowerCateList + ", domesticList=" + domesticList
				+ ", foreignList=" + foreignList + ", cdList=" + cdList + ", dvdCateList=" + dvdList + "]";
	}
	
}
