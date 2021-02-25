package kr.kosmo.jobkorea.ticketing.util;

import java.time.LocalDate;

public class Helper {
	public static String getDateStr(LocalDate date) {
		
		String dateStr = date.getYear()+"";
		dateStr += (date.getMonthValue() < 10 ? "0"+date.getMonthValue() : date.getMonthValue());
		dateStr += (date.getDayOfMonth() < 10 ? "0"+date.getDayOfMonth() : date.getDayOfMonth());
		
		return dateStr;
	}
}
