package kr.kosmo.jobkorea.book.util;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;

import org.json.simple.JSONObject;


import org.json.simple.parser.JSONParser;

import kr.kosmo.jobkorea.book.model.BookModel;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;



public class API {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	

	public List<BookModel> bookInfoSave(String service,String categoryId) throws Exception {
		 List<BookModel> bookArr=new ArrayList<>();
		try {
				System.out.println("categoryId:" + categoryId);
	
				String Key = "9BA8380AE658CCAAC396BF4B68655EC852D5109B35BA7C56C060C815673039D7";

				String urlStr = "http://book.interpark.com/api/";
				urlStr += service + ".api";
				urlStr += "?" + URLEncoder.encode("key", "UTF-8") + "=" + Key;
				urlStr += "&" + URLEncoder.encode("categoryId", "UTF-8") + "=" + categoryId;
				urlStr += "&" + URLEncoder.encode("output", "UTF-8") + "=json";

				URL url = new URL(urlStr);

				String line = "";
				String result = "";

				BufferedReader br;
				br = new BufferedReader(new InputStreamReader(url.openStream()));
				while ((line = br.readLine()) != null) {
					result = result.concat(line);
					//logger.info("line:"+line);
				}
				logger.info("result:"+result);

				// JSON parser 만들어 문자열 데이터를 객체화한다.
				JSONParser parser = new JSONParser();
				JSONObject obj = (JSONObject) parser.parse(result);
				logger.info("obj:" + obj);

				// list 아래가 배열형태로
				// {"list" : [ {"returnType":"json","clearDate":"--",.......} ]
				JSONArray parse_listArr = (JSONArray) obj.get("item");
				logger.info("parse_listArr:"+parse_listArr);
				// System.out.println("parse_listArr.size()"+parse_listArr.size());
				// 객체형태로
				// {"returnType":"json","clearDate":"--",.......},...
				

				for (int j = 0; j < parse_listArr.size(); j++) {
					JSONObject jsonobj = (JSONObject) parse_listArr.get(j);

					BookModel book = new BookModel();
					book.setItemId(String.valueOf(jsonobj.get("itemId")));
					book.setTitle(String.valueOf(jsonobj.get("title")));
					book.setIsbn(String.valueOf(jsonobj.get("isbn")));
					book.setAuthor(String.valueOf(jsonobj.get("author")));
					book.setTranslator(String.valueOf(jsonobj.get("translator")));
					book.setDescription(String.valueOf(jsonobj.get("description")));
					book.setPriceStandard(Integer.parseInt((jsonobj.get("priceStandard").toString())));
					book.setCoverSmallUrl(String.valueOf(jsonobj.get("coverSmallUrl")));
					book.setCoverLargeUrl(String.valueOf(jsonobj.get("coverLargeUrl")));
					book.setCategoryName(String.valueOf(jsonobj.get("categoryName")));
					book.setCategoryId(String.valueOf(jsonobj.get("categoryId")));
					book.setPublisher(String.valueOf(jsonobj.get("publisher")));
					book.setPubDate(String.valueOf(jsonobj.get("pubDate")));

					bookArr.add(book);
				}
				br.close();
				if(bookArr.size()==0){
					logger.info("API 읽어오기 성공 - 데이터가 없습니다.");
				}else{
					logger.info("API 읽어오기 성공");
				}	
		} catch (Exception e) {
			e.printStackTrace();
		}

		return bookArr;
	}
	
	public String DelCateNum(String category) throws Exception {
		String cateNum="";
		switch(category){
			case "domestic":
				cateNum="1";
				break;
			case "foreign":
				cateNum="2";
				break;
			case "recode":
				cateNum="3";
				break;
			case "dvd":
				cateNum="4";
				break;
		}
		logger.info("반환된 카테고리 번호: "+cateNum+ "00번대");
		return cateNum;
	}
	
	
	public List<BookModel> searchBook(Map<String, Object> paramMap) throws Exception {
		 List<BookModel> bookArr=new ArrayList<>();
		try {
				//필수 
				String Key = "9BA8380AE658CCAAC396BF4B68655EC852D5109B35BA7C56C060C815673039D7";
				String query=(String)paramMap.get("query");
				logger.info("query: "+query);
				
				//상세 요청 변수
				String queryType=(String)paramMap.get("queryType");
				String searchTarget=(String)paramMap.get("searchTarget");
				String start=(String)paramMap.get("start");
				String maxResults=(String)paramMap.get("maxResults");
				String sort=(String)paramMap.get("sort");
				String categoryId=(String)paramMap.get("categoryId");
				String soldOut=(String)paramMap.get("soldOut");
				
				//필수
				String urlStr = "http://book.interpark.com/api/search.api";
				urlStr += "?" + URLEncoder.encode("key", "UTF-8") + "=" + Key;
				urlStr += "&" + URLEncoder.encode("query", "UTF-8") + "="+URLEncoder.encode(query, "UTF-8");
				urlStr += "&" + URLEncoder.encode("output", "UTF-8") + "=json";
				//urlStr += "&" + URLEncoder.encode("inputEncoding", "UTF-8") + "=utf-8";
				
				//상세 검색요청 변수
				urlStr += (queryType == null ?"":"&" + URLEncoder.encode("queryType", "UTF-8") + "=" + queryType);
				urlStr += (searchTarget == null ?"":"&" + URLEncoder.encode("searchTarget", "UTF-8") + "=" + searchTarget);
				urlStr += (start == null ? "":"&" + URLEncoder.encode("start", "UTF-8") + "=" + start);
				urlStr += (maxResults == null ?"":"&" + URLEncoder.encode("maxResults", "UTF-8") + "=" + maxResults);
				urlStr += (sort == null ?"":"&" + URLEncoder.encode("sort", "UTF-8") + "=" + sort);
				urlStr += (categoryId == null ?"":"&" + URLEncoder.encode("categoryId", "UTF-8") + "=" + categoryId);
				urlStr += (soldOut == null ?"":"&" + URLEncoder.encode("soldOut", "UTF-8") + "=" + soldOut);
				
				
				logger.info("urlStr: "+urlStr);
				URL url = new URL(urlStr);

				String line = "";
				String result = "";

				BufferedReader br;
				br = new BufferedReader(new InputStreamReader(url.openStream()));
				while ((line = br.readLine()) != null) {
					result = result.concat(line);
					//logger.info("line:"+line);
				}
				logger.info("result:"+result);

				// JSON parser 만들어 문자열 데이터를 객체화한다.
				JSONParser parser = new JSONParser();
				JSONObject obj = (JSONObject) parser.parse(result);
				logger.info("obj:" + obj);

				// list 아래가 배열형태로
				// {"list" : [ {"returnType":"json","clearDate":"--",.......} ]
				JSONArray parse_listArr = (JSONArray) obj.get("item");
				logger.info("parse_listArr:"+parse_listArr);
				// System.out.println("parse_listArr.size()"+parse_listArr.size());
				// 객체형태로
				// {"returnType":"json","clearDate":"--",.......},...
				

				for (int j = 0; j < parse_listArr.size(); j++) {
					JSONObject jsonobj = (JSONObject) parse_listArr.get(j);

					BookModel book = new BookModel();
					book.setItemId(String.valueOf(jsonobj.get("itemId")));
					book.setTitle(String.valueOf(jsonobj.get("title")));
					book.setIsbn(String.valueOf(jsonobj.get("isbn")));
					book.setAuthor(String.valueOf(jsonobj.get("author")));
					book.setTranslator(String.valueOf(jsonobj.get("translator")));
					book.setDescription(String.valueOf(jsonobj.get("description")));
					book.setPriceStandard(Integer.parseInt((jsonobj.get("priceStandard").toString())));
					book.setCoverSmallUrl(String.valueOf(jsonobj.get("coverSmallUrl")));
					book.setCoverLargeUrl(String.valueOf(jsonobj.get("coverLargeUrl")));
					book.setCategoryName(String.valueOf(jsonobj.get("categoryName")));
					book.setCategoryId(String.valueOf(jsonobj.get("categoryId")));
					book.setPublisher(String.valueOf(jsonobj.get("publisher")));
					book.setPubDate(String.valueOf(jsonobj.get("pubDate")));

					bookArr.add(book);
				}
				br.close();
				if(bookArr.size()==0){
					logger.info("API 읽어오기 성공 - 데이터가 없습니다.");
				}else{
					logger.info("API 읽어오기 성공");
				}	
		} catch (Exception e) {
			e.printStackTrace();
		}

		return bookArr;
	}
	
	
}
