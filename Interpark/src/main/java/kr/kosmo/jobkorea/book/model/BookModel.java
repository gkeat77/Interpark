package kr.kosmo.jobkorea.book.model;


public class BookModel {
		String itemId;
		String title;
		String isbn;
		String author;
		String translator;
		String description;
		int priceStandard;
		int discountRate;
		int priceSales;
		String coverSmallUrl;
		String coverLargeUrl;
		String categoryName;
		String categoryId;
		String publisher;
		String pubDate;
		
		public String getItemId() {
			return itemId;
		}
		public void setItemId(String itemId) {
			this.itemId = itemId;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getIsbn() {
			return isbn;
		}
		public void setIsbn(String isbn) {
			this.isbn = isbn;
		}
		public String getAuthor() {
			return author;
		}
		public void setAuthor(String author) {
			this.author = author;
		}
		public String getTranslator() {
			return translator;
		}
		public void setTranslator(String translator) {
			this.translator = translator;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public int getPriceStandard() {
			return priceStandard;
		}
		public void setPriceStandard(int priceStandard) {
			this.priceStandard = priceStandard;
		}
		public int getDiscountRate() {
			return discountRate;
		}
		public void setDiscountRate(int discountRate) {
			this.discountRate = discountRate;
		}
		public int getPriceSales() {
			return priceSales;
		}
		public void setPriceSales(int priceSales) {
			this.priceSales = priceSales;
		}
		public String getCoverSmallUrl() {
			return coverSmallUrl;
		}
		public void setCoverSmallUrl(String coverSmallUrl) {
			this.coverSmallUrl = coverSmallUrl;
		}
		public String getCoverLargeUrl() {
			return coverLargeUrl;
		}
		public void setCoverLargeUrl(String coverLargeUrl) {
			this.coverLargeUrl = coverLargeUrl;
		}
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
		public String getPublisher() {
			return publisher;
		}
		public void setPublisher(String publisher) {
			this.publisher = publisher;
		}
		public String getPubDate() {
			return pubDate;
		}
		public void setPubDate(String pubDate) {
			this.pubDate = pubDate;
		}
		@Override
		public String toString() {
			return "Book [itemId=" + itemId + ", title=" + title + ", isbn=" + isbn + ", author=" + author
					+ ", translator=" + translator + ", description=" + description + ", priceStandard=" + priceStandard
					+ ", discountRate=" + discountRate + ", priceSales=" + priceSales + ", coverSmallUrl="
					+ coverSmallUrl + ", coverLargeUrl=" + coverLargeUrl + ", categoryName=" + categoryName
					+ ", categoryId=" + categoryId + ", publisher=" + publisher + ", pubDate=" + pubDate + "]";
		}

		
	
		
	
}
