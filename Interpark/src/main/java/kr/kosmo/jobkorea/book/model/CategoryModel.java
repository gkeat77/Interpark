package kr.kosmo.jobkorea.book.model;

public class CategoryModel {
	String categoryName;
	String categoryId;
	String cateClass;
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
	@Override
	public String toString() {
		return "CategoryModel [categoryName=" + categoryName + ", categoryId=" + categoryId + ", cateClass=" + cateClass
				+ "]";
	}

}
