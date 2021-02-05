package kr.kosmo.jobkorea.book.model;


public class BookModel {
		//도서 
		int pId;
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
		String regDate;
		String service;
		String index;
		String file_nm;
		String file_loc;
		String file_size;		
		String authorInfo;
		int sellCount;
		int stock;
		int saleRate;
		int salePrice;
		int realPrice;
		String sellState;
		String display;
		String sellStart;
		String sellEnd;
		public int getpId() {
			return pId;
		}
		public void setpId(int pId) {
			this.pId = pId;
		}
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
		public String getRegDate() {
			return regDate;
		}
		public void setRegDate(String regDate) {
			this.regDate = regDate;
		}
		public String getService() {
			return service;
		}
		public void setService(String service) {
			this.service = service;
		}
		public String getIndex() {
			return index;
		}
		public void setIndex(String index) {
			this.index = index;
		}
		public String getFile_nm() {
			return file_nm;
		}
		public void setFile_nm(String file_nm) {
			this.file_nm = file_nm;
		}
		public String getFile_loc() {
			return file_loc;
		}
		public void setFile_loc(String file_loc) {
			this.file_loc = file_loc;
		}
		public String getFile_size() {
			return file_size;
		}
		public void setFile_size(String file_size) {
			this.file_size = file_size;
		}
		public String getAuthorInfo() {
			return authorInfo;
		}
		public void setAuthorInfo(String authorInfo) {
			this.authorInfo = authorInfo;
		}
		public int getSellCount() {
			return sellCount;
		}
		public void setSellCount(int sellCount) {
			this.sellCount = sellCount;
		}
		public int getStock() {
			return stock;
		}
		public void setStock(int stock) {
			this.stock = stock;
		}
		public int getSaleRate() {
			return saleRate;
		}
		public void setSaleRate(int saleRate) {
			this.saleRate = saleRate;
		}
		public int getSalePrice() {
			return salePrice;
		}
		public void setSalePrice(int salePrice) {
			this.salePrice = salePrice;
		}
		public String getSellState() {
			return sellState;
		}
		public void setSellState(String sellState) {
			this.sellState = sellState;
		}
		public String getDisplay() {
			return display;
		}
		public void setDisplay(String display) {
			this.display = display;
		}
		public String getSellStart() {
			return sellStart;
		}
		public void setSellStart(String sellStart) {
			this.sellStart = sellStart;
		}
		public String getSellEnd() {
			return sellEnd;
		}
		public void setSellEnd(String sellEnd) {
			this.sellEnd = sellEnd;
		}
		public int getRealPrice() {
			return realPrice;
		}
		public void setRealPrice(int realPrice) {
			this.realPrice = realPrice;
		}
		@Override
		public String toString() {
			return "BookModel [pId=" + pId + ", itemId=" + itemId + ", title=" + title + ", isbn=" + isbn + ", author="
					+ author + ", translator=" + translator + ", description=" + description + ", priceStandard="
					+ priceStandard + ", discountRate=" + discountRate + ", priceSales=" + priceSales
					+ ", coverSmallUrl=" + coverSmallUrl + ", coverLargeUrl=" + coverLargeUrl + ", categoryName="
					+ categoryName + ", categoryId=" + categoryId + ", publisher=" + publisher + ", pubDate=" + pubDate
					+ ", regDate=" + regDate + ", service=" + service + ", index=" + index + ", file_nm=" + file_nm
					+ ", file_loc=" + file_loc + ", file_size=" + file_size + ", authorInfo=" + authorInfo
					+ ", sellCount=" + sellCount + ", stock=" + stock + ", saleRate=" + saleRate + ", salePrice="
					+ salePrice + ", realPrice=" + realPrice + ", sellState=" + sellState + ", display=" + display
					+ ", sellStart=" + sellStart + ", sellEnd=" + sellEnd + "]";
		}
	

		
		
}
