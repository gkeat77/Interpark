package kr.kosmo.jobkorea.event.model;

import java.util.Date;

public class EventModel {
	
		private int e_id;
		private String e_title;
		private Date e_sdate;
		private Date e_edate;
		private String e_content;
		private int f_id;

		private String longinID;
		private String coupon_no;
		public int getE_id() {
			return e_id;
		}
		public void setE_id(int e_id) {
			this.e_id = e_id;
		}
		public String getE_title() {
			return e_title;
		}
		public void setE_title(String e_title) {
			this.e_title = e_title;
		}
		public Date getE_sdate() {
			return e_sdate;
		}
		public void setE_sdate(Date e_sdate) {
			this.e_sdate = e_sdate;
		}
		public Date getE_edate() {
			return e_edate;
		}
		public void setE_edate(Date e_edate) {
			this.e_edate = e_edate;
		}
		public String getE_content() {
			return e_content;
		}
		public void setE_content(String e_content) {
			this.e_content = e_content;
		}
		public int getF_id() {
			return f_id;
		}
		public void setF_id(int f_id) {
			this.f_id = f_id;
		}
		public String getLonginID() {
			return longinID;
		}
		public void setLonginID(String longinID) {
			this.longinID = longinID;
		}
		public String getCoupon_no() {
			return coupon_no;
		}
		public void setCoupon_no(String coupon_no) {
			this.coupon_no = coupon_no;
		}
		
//		@Override
//		public String toString() {
//			return "EventModel [e_id=" + e_id + ", e_title =" + e_title + ", e_sdate=" + e_sdate + ", e_edate="
//					+ e_edate + ", e_content=" + e_content + ", f_id=" + f_id + ", longinID="
//					+ longinID + ", coupon_no=" + coupon_no +  "]";
//		}
		
		//도서 
//		private int pId;
//		private String itemId;
//		private String title;
//		private String isbn;
//		private String author;
//		private String translator;
//		private String description;
//		private int priceStandard;
//		private int discountRate;
//		private int priceSales;
//		private String coverSmallUrl;
//		private String coverLargeUrl;
//		private String categoryName;
//		private String categoryId;
//		private String publisher;
//		private String pubDate;
//		private String regDate;
//		private String serviceType;
//		private String index;
//		private String file_nm;
//		private String file_loc;
//		private String file_size;		
//		private String authorInfo;
//		private int sellCount;
//		private int stock;
//		private int saleRate;
//		private int salePrice;
//		private int realPrice;
//		private String sellState;
//		private String display;
//		private String sellStart;
//		private String sellEnd;
//		private double rStar;
//		private int rCount;
//		private int mileage;
//		private int mileageRate;
//		// ahn
//		private String loginID;
//		
//		
//		
//		public String getLoginID() {
//			return loginID;
//		}
//		public void setLoginID(String loginID) {
//			this.loginID = loginID;
//		}
//		public int getpId() {
//			return pId;
//		}
//		public void setpId(int pId) {
//			this.pId = pId;
//		}
//		public String getItemId() {
//			return itemId;
//		}
//		public void setItemId(String itemId) {
//			this.itemId = itemId;
//		}
//		public String getTitle() {
//			return title;
//		}
//		public void setTitle(String title) {
//			this.title = title;
//		}
//		public String getIsbn() {
//			return isbn;
//		}
//		public void setIsbn(String isbn) {
//			this.isbn = isbn;
//		}
//		public String getAuthor() {
//			return author;
//		}
//		public void setAuthor(String author) {
//			this.author = author;
//		}
//		public String getTranslator() {
//			return translator;
//		}
//		public void setTranslator(String translator) {
//			this.translator = translator;
//		}
//		public String getDescription() {
//			return description;
//		}
//		public void setDescription(String description) {
//			this.description = description;
//		}
//		public int getPriceStandard() {
//			return priceStandard;
//		}
//		public void setPriceStandard(int priceStandard) {
//			this.priceStandard = priceStandard;
//		}
//		public int getDiscountRate() {
//			return discountRate;
//		}
//		public void setDiscountRate(int discountRate) {
//			this.discountRate = discountRate;
//		}
//		public int getPriceSales() {
//			return priceSales;
//		}
//		public void setPriceSales(int priceSales) {
//			this.priceSales = priceSales;
//		}
//		public String getCoverSmallUrl() {
//			return coverSmallUrl;
//		}
//		public void setCoverSmallUrl(String coverSmallUrl) {
//			this.coverSmallUrl = coverSmallUrl;
//		}
//		public String getCoverLargeUrl() {
//			return coverLargeUrl;
//		}
//		public void setCoverLargeUrl(String coverLargeUrl) {
//			this.coverLargeUrl = coverLargeUrl;
//		}
//		public String getCategoryName() {
//			return categoryName;
//		}
//		public void setCategoryName(String categoryName) {
//			this.categoryName = categoryName;
//		}
//		public String getCategoryId() {
//			return categoryId;
//		}
//		public void setCategoryId(String categoryId) {
//			this.categoryId = categoryId;
//		}
//		public String getPublisher() {
//			return publisher;
//		}
//		public void setPublisher(String publisher) {
//			this.publisher = publisher;
//		}
//		public String getPubDate() {
//			return pubDate;
//		}
//		public void setPubDate(String pubDate) {
//			this.pubDate = pubDate;
//		}
//		public String getRegDate() {
//			return regDate;
//		}
//		public void setRegDate(String regDate) {
//			this.regDate = regDate;
//		}
//		public String getServiceType() {
//			return serviceType;
//		}
//		public void setServiceType(String serviceType) {
//			this.serviceType = serviceType;
//		}
//		public String getIndex() {
//			return index;
//		}
//		public void setIndex(String index) {
//			this.index = index;
//		}
//		public String getFile_nm() {
//			return file_nm;
//		}
//		public void setFile_nm(String file_nm) {
//			this.file_nm = file_nm;
//		}
//		public String getFile_loc() {
//			return file_loc;
//		}
//		public void setFile_loc(String file_loc) {
//			this.file_loc = file_loc;
//		}
//		public String getFile_size() {
//			return file_size;
//		}
//		public void setFile_size(String file_size) {
//			this.file_size = file_size;
//		}
//		public String getAuthorInfo() {
//			return authorInfo;
//		}
//		public void setAuthorInfo(String authorInfo) {
//			this.authorInfo = authorInfo;
//		}
//		public int getSellCount() {
//			return sellCount;
//		}
//		public void setSellCount(int sellCount) {
//			this.sellCount = sellCount;
//		}
//		public int getStock() {
//			return stock;
//		}
//		public void setStock(int stock) {
//			this.stock = stock;
//		}
//		public int getSaleRate() {
//			return saleRate;
//		}
//		public void setSaleRate(int saleRate) {
//			this.saleRate = saleRate;
//		}
//		public int getSalePrice() {
//			return salePrice;
//		}
//		public void setSalePrice(int salePrice) {
//			this.salePrice = salePrice;
//		}
//		public int getRealPrice() {
//			return realPrice;
//		}
//		public void setRealPrice(int realPrice) {
//			this.realPrice = realPrice;
//		}
//		public String getSellState() {
//			return sellState;
//		}
//		public void setSellState(String sellState) {
//			this.sellState = sellState;
//		}
//		public String getDisplay() {
//			return display;
//		}
//		public void setDisplay(String display) {
//			this.display = display;
//		}
//		public String getSellStart() {
//			return sellStart;
//		}
//		public void setSellStart(String sellStart) {
//			this.sellStart = sellStart;
//		}
//		public String getSellEnd() {
//			return sellEnd;
//		}
//		public void setSellEnd(String sellEnd) {
//			this.sellEnd = sellEnd;
//		}
//		public double getrStar() {
//			return rStar;
//		}
//		public void setrStar(double rStar) {
//			this.rStar = rStar;
//		}
//		public int getrCount() {
//			return rCount;
//		}
//		public void setrCount(int rCount) {
//			this.rCount = rCount;
//		}
//		public int getMileage() {
//			return mileage;
//		}
//		public void setMileage(int mileage) {
//			this.mileage = mileage;
//		}
//		public int getMileageRate() {
//			return mileageRate;
//		}
//		public void setMileageRate(int mileageRate) {
//			this.mileageRate = mileageRate;
//		}
//		@Override
//		public String toString() {
//			return "BookModel [pId=" + pId + ", itemId=" + itemId + ", title=" + title + ", isbn=" + isbn + ", author="
//					+ author + ", translator=" + translator + ", description=" + description + ", priceStandard="
//					+ priceStandard + ", discountRate=" + discountRate + ", priceSales=" + priceSales
//					+ ", coverSmallUrl=" + coverSmallUrl + ", coverLargeUrl=" + coverLargeUrl + ", categoryName="
//					+ categoryName + ", categoryId=" + categoryId + ", publisher=" + publisher + ", pubDate=" + pubDate
//					+ ", regDate=" + regDate + ", serviceType=" + serviceType + ", index=" + index + ", file_nm="
//					+ file_nm + ", file_loc=" + file_loc + ", file_size=" + file_size + ", authorInfo=" + authorInfo
//					+ ", sellCount=" + sellCount + ", stock=" + stock + ", saleRate=" + saleRate + ", salePrice="
//					+ salePrice + ", realPrice=" + realPrice + ", sellState=" + sellState + ", display=" + display
//					+ ", sellStart=" + sellStart + ", sellEnd=" + sellEnd + ", rStar=" + rStar + ", rCount=" + rCount
//					+ ", mileage=" + mileage + ", mileageRate=" + mileageRate + "]";
//		}
}
