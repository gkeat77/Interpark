package kr.kosmo.jobkorea.event.model;

import java.util.List;

public class CategoryModel {
	private String categoryName;
	private String categoryId;
	private String cateClass;
	private int level;
	private List<CategoryModel> lowerCateList;
	
	
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
	@Override
	public String toString() {
		return "CategoryModel [categoryName=" + categoryName + ", categoryId=" + categoryId + ", cateClass=" + cateClass
				+ ", level=" + level + " lowerCateList=" + lowerCateList + "]";
	}

	
}
