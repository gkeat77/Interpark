package kr.kosmo.jobkorea.book.model;


public class BookModel {
	/*   도서 API 시작 */
		private int pId;
		private String itemId;
		private String title;
		private String isbn;
		private String author;
		private String translator;
		private String description;
		private int priceStandard;
		private int discountRate;
		private int priceSales;
		private String coverSmallUrl;
		private String coverLargeUrl;
		private String categoryName;
		private String categoryId;
		private String publisher;
		private String pubDate;
	/*   도서 API 끝  */
		
	/*   쇼핑몰 등록용 도서 정보입력 시작 */
		private String regDate;
		private String serviceType;
		private String index;
		private String file_nm;
		private String file_loc;
		private String file_size;		
		private String authorInfo;
		private int sellCount;
		private int stock;
		private int saleRate;
		private int salePrice;
		private int realPrice;
		private String sellState;
		private String display;
		private String sellStart;
		private String sellEnd;
		private double rStar;
		private int rCount;
		private int mileage;
		private int mileageRate;
		// ahn
		private String loginID;
	/*   쇼핑몰 등록용 도서 정보입력 끝 */	
		
		
		public String getLoginID() {
			return loginID;
		}
		public void setLoginID(String loginID) {
			this.loginID = loginID;
		}
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
		public String getServiceType() {
			return serviceType;
		}
		public void setServiceType(String serviceType) {
			this.serviceType = serviceType;
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
		public int getRealPrice() {
			return realPrice;
		}
		public void setRealPrice(int realPrice) {
			this.realPrice = realPrice;
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
		public double getrStar() {
			return rStar;
		}
		public void setrStar(double rStar) {
			this.rStar = rStar;
		}
		public int getrCount() {
			return rCount;
		}
		public void setrCount(int rCount) {
			this.rCount = rCount;
		}
		public int getMileage() {
			return mileage;
		}
		public void setMileage(int mileage) {
			this.mileage = mileage;
		}
		public int getMileageRate() {
			return mileageRate;
		}
		public void setMileageRate(int mileageRate) {
			this.mileageRate = mileageRate;
		}
		@Override
		public String toString() {
			return "BookModel [pId=" + pId + ", itemId=" + itemId + ", title=" + title + ", isbn=" + isbn + ", author="
					+ author + ", translator=" + translator + ", description=" + description + ", priceStandard="
					+ priceStandard + ", discountRate=" + discountRate + ", priceSales=" + priceSales
					+ ", coverSmallUrl=" + coverSmallUrl + ", coverLargeUrl=" + coverLargeUrl + ", categoryName="
					+ categoryName + ", categoryId=" + categoryId + ", publisher=" + publisher + ", pubDate=" + pubDate
					+ ", regDate=" + regDate + ", serviceType=" + serviceType + ", index=" + index + ", file_nm="
					+ file_nm + ", file_loc=" + file_loc + ", file_size=" + file_size + ", authorInfo=" + authorInfo
					+ ", sellCount=" + sellCount + ", stock=" + stock + ", saleRate=" + saleRate + ", salePrice="
					+ salePrice + ", realPrice=" + realPrice + ", sellState=" + sellState + ", display=" + display
					+ ", sellStart=" + sellStart + ", sellEnd=" + sellEnd + ", rStar=" + rStar + ", rCount=" + rCount
					+ ", mileage=" + mileage + ", mileageRate=" + mileageRate + "]";
		}
}
