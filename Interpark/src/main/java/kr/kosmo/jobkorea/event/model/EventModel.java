package kr.kosmo.jobkorea.event.model;

import java.util.Date;
import java.util.List;

public class EventModel {
	
		private int e_id;
		private String e_title;
		private Date e_sdate;
		private Date e_edate;
		private String e_content;
		private int f_id;
		private Date reg_date;
		
		private String longinID;
		private String coupon_no;
		private String thumnail_img;
		private String detail_banner;
		
		private List<EventModel> targets;
		
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
		public Date getReg_date() {
			return reg_date;
		}
		public void setReg_date(Date reg_date) {
			this.reg_date = reg_date;
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
		public String getThumnail_img() {
			return thumnail_img;
		}
		public void setThumnail_img(String thumnail_img) {
			this.thumnail_img = thumnail_img;
		}
		public String getDetail_banner() {
			return detail_banner;
		}
		public void setDetail_banner(String detail_banner) {
			this.detail_banner = detail_banner;
		}		

		@Override
		public String toString() {
			return "EventModel [e_id=" + e_id + ", e_title =" + e_title + ", e_sdate=" + e_sdate + ", e_edate="
					+ e_edate + ", e_content=" + e_content + ", f_id=" + f_id + ", reg_date="+ reg_date + ", "
					+ "longinID=" + longinID + ", coupon_no=" + coupon_no +  ", thumnail_img=" + thumnail_img +  ", detail_banner=" + detail_banner + "]";
		}		
}
