package kr.kosmo.jobkorea.ticketing.util;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import kr.kosmo.jobkorea.ticketing.model.Boxof;
import kr.kosmo.jobkorea.ticketing.model.Db;

public class XmlParse {
	public static final String SERVICE_KEY = "36a3d2fd0b614425af270960e6ed5275";
	
	// 예약상황판 조회
	public static List<Boxof> getBoxofs(String stsType, String date, String cateCode, String area){
		
		List<Boxof> boxofs = null;
		
		try {
			String url = "http://www.kopis.or.kr/openApi/restful/boxoffice?"
					+ "service="+ SERVICE_KEY +"&"
					+ "ststype="+stsType
					+ "&date="+date;// 필수항목
			url += (cateCode == null ? "" : "&catecode="+cateCode);
			url += (area == null ? "" : "&area="+area);
			
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder(); 
            Document doc = dBuilder.parse(url);

            // DOM Tree가 XML 문서의 구조대로 완성될 수 있게 한다.
            doc.getDocumentElement().normalize();
            System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
            // 
            NodeList nList = doc.getElementsByTagName("boxof");
            System.out.println("파싱할 리스트 수 : "+ nList.getLength());
            
            /*
             *  <area>서울</area>
            	<prfdtcnt>43</prfdtcnt>
            	<prfpd>2021.02.12~2021.05.01</prfpd>
            	<cate>뮤지컬</cate>
            	<prfplcnm>블루스퀘어 인터파크홀</prfplcnm>
            	<prfnm>위키드</prfnm>
            	<rnum>1</rnum>
            	<seatcnt>1766</seatcnt>
            	<poster>/upload/pfmPoster/PF_PF171092_210119_100127.gif</poster>
            	<mt20id>PF171092</mt20id>
          	 *
             */
        	boxofs = new ArrayList<>();
            for(int temp = 0; temp < nList.getLength(); temp++){
                Node nNode = nList.item(temp);
                if(nNode.getNodeType() == Node.ELEMENT_NODE){
                    Boxof boxof = new Boxof();
                    Element eElement = (Element)nNode;
                    
                    LocalDate day = LocalDate.now();
                    String today = day.getYear()+"";
            		today += day.getMonthValue() < 10 ? "0"+day.getMonthValue() : day.getMonthValue();
            		today += day.getDayOfMonth() < 10 ? "0"+day.getDayOfMonth() : day.getDayOfMonth();
            		 
                    boxof.setDay(today);
                    boxof.setArea(getTagValue("area", eElement));
                    boxof.setPrfdtcnt(Integer.parseInt(getTagValue("prfdtcnt", eElement)));
                    boxof.setPrfnm(getTagValue("prfnm", eElement));
                    boxof.setPrfpd(getTagValue("prfpd", eElement));
                    boxof.setCate(getTagValue("cate", eElement));
                    boxof.setPrfplcnm(getTagValue("prfplcnm", eElement));
                    boxof.setRnum(Integer.parseInt(getTagValue("rnum", eElement)));
                    boxof.setSeatcnt(Integer.parseInt(getTagValue("seatcnt", eElement)));
                    // poster는 호스트이름이 없으면 붙여준다.
                    String poster = getTagValue("poster", eElement);
                    if(!poster.contains("http://www.kopis.or.kr")){
                    	poster = "http://www.kopis.or.kr"+poster;
                    }
                    boxof.setPoster(poster);
                    boxof.setMt20id(getTagValue("mt20id",eElement));
                    
                    boxofs.add(boxof);
                }
            }	
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		System.out.println("boxofs: "+boxofs);
		return boxofs;
	}
	
	// tag값의 정보를 가져오는 메소드
    public static String getTagValue(String tag, Element eElement) {
    	if(eElement.getElementsByTagName(tag).getLength() == 0) return "";
        NodeList nlList =  eElement.getElementsByTagName(tag).item(0).getChildNodes();
        Node nValue = (Node) nlList.item(0);
        if(nValue == null) {
            return null;
        }    
        return nValue.getNodeValue();
    }
    
    //공연목록 조회
    public static List<Db> getPfrList(PblpfrRequest request){
    	List<Db> dbs = null;
    	
    	try {
			String url = "http://www.kopis.or.kr/openApi/restful/pblprfr?"
					+ "service="+ SERVICE_KEY +"&"
					+ "stdate="+ request.getStdata()
					+ "&eddate="+ request.getEddate()
					+ "&cpage=" + request.getCpage()
					+ "&rows=" + request.getRows();// 필수항목
			url += (request.shcate == null ? "" : "&shcate="+request.shcate);
			url += (request.shprfnm == null ? "" : "&shprfnm="+request.shprfnm);
			url += (request.shprfnmfct == null ? "" : "&shprfnmfct="+request.shprfnmfct);
			url += (request.prfplccd == null ? "" : "&prfplccd="+request.prfplccd);
			url += (request.signgucode == null ? "" : "&signgucode="+request.signgucode);
			url += (request.signgucodesub == null ? "" : "&signgucodesub="+request.signgucodesub);
			url += (request.kidstate == null ? "" : "&kidstate="+request.kidstate);
			url += (request.prfstate == null ? "" : "&prfstate="+request.prfstate);
			
			
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder(); 
            Document doc = dBuilder.parse(url);

            // DOM Tree가 XML 문서의 구조대로 완성될 수 있게 한다.
            doc.getDocumentElement().normalize();
            System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
            // 
            NodeList nList = doc.getElementsByTagName("db");
            System.out.println("파싱할 리스트 수 : "+ nList.getLength());
           
        	dbs = new ArrayList<>();
            for(int temp = 0; temp < nList.getLength(); temp++){
                Node nNode = nList.item(temp);
                if(nNode.getNodeType() == Node.ELEMENT_NODE){
                    Db db = new Db();
                    Element eElement = (Element)nNode;
                    db.setMt20id(getTagValue("mt20id", eElement));
                    db.setPrfnm(getTagValue("prfnm", eElement));
                    db.setGenrenm(getTagValue("genrenm", eElement));
                    db.setPrfstate(getTagValue("prfstate", eElement));
                    db.setPrfpdfrom(getTagValue("prfpdfrom", eElement));
                    db.setPrfpdto(getTagValue("prfpdto", eElement));
                    db.setFcltynm(getTagValue("fcltynm", eElement));
                    db.setOpenrun(getTagValue("openrun", eElement));
                    // poster는 호스트이름이 없으면 붙여준다.
                    String poster = getTagValue("poster", eElement);
                    if(!poster.contains("http://www.kopis.or.kr")){
                    	poster = "http://www.kopis.or.kr"+poster;
                    }
                    db.setPoster(poster);
                    
                    dbs.add(db);
                }
            }	
			
		} catch(Exception e){
			e.printStackTrace();
		}
    	
    	return dbs;
    }
    
    //공연상세 조회(공연ID: mt20id)
    public static Db getDetailPfr(String mt20id){
    	Db db = null;
    	try {
			String url = "http://www.kopis.or.kr/openApi/restful/pblprfr/"+mt20id+"?"
					+ "service="+ SERVICE_KEY ;// 필수항목
			
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder(); 
            Document doc = dBuilder.parse(url);

            // DOM Tree가 XML 문서의 구조대로 완성될 수 있게 한다.
            doc.getDocumentElement().normalize();
            System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
            NodeList nList = doc.getElementsByTagName("db");
            System.out.println("파싱할 리스트 수 : "+ nList.getLength());
       
	        Node nNode = nList.item(0);
	        db = new Db();
	        if(nNode.getNodeType() == Node.ELEMENT_NODE){	
	            Element eElement = (Element)nNode;
	            db.setMt20id(getTagValue("mt20id", eElement));
	            db.setMt10id(getTagValue("mt10id", eElement));
	            db.setPrfnm(getTagValue("prfnm", eElement));
	            db.setGenrenm(getTagValue("genrenm", eElement));
	            db.setPrfstate(getTagValue("prfstate", eElement));
	            db.setPrfpdfrom(getTagValue("prfpdfrom", eElement));
	            db.setPrfpdto(getTagValue("prfpdto", eElement));
	            db.setFcltynm(getTagValue("fcltynm", eElement));
	            db.setPrfcast(getTagValue("prfcast", eElement));
	            db.setPrfcrew(getTagValue("prfcrew", eElement));
	            db.setPrfruntime(getTagValue("prfruntime", eElement));
	            db.setPrfage(getTagValue("prfage", eElement));
	            db.setEntrpsnm(getTagValue("entrpsnm", eElement));
	            db.setPcseguidance(getTagValue("pcseguidance", eElement));
	            db.setSty(getTagValue("sty", eElement));
	            db.setDtguidance(getTagValue("dtguidance", eElement));
	            
	            db.setOpenrun(getTagValue("openrun", eElement));
	            // poster는 호스트이름이 없으면 붙여준다.
	            String poster = getTagValue("poster", eElement);
	            if(!poster.contains("http://www.kopis.or.kr")){
	            	poster = "http://www.kopis.or.kr"+poster;
	            }
	            db.setPoster(poster);
	        } 
	        
	        NodeList styurlList = doc.getElementsByTagName("styurls"); 
	        List<String> styurls = new ArrayList<>();
	        System.out.println("styurlList.getLength()=> "+styurlList.getLength());
	        for(int temp = 0; temp < styurlList.getLength(); temp++){
                Node styurlNode = styurlList.item(temp);
                if(styurlNode.getNodeType() == Node.ELEMENT_NODE){
                    Element eElement = (Element)styurlNode;
                    String styurl = getTagValue("styurl", eElement); 
                    System.out.println("styurl=>"+styurl);
                    styurls.add(styurl);
                }
            }
            db.setStyurls(styurls);
       		
		} catch(Exception e){
			e.printStackTrace();
		}
    	
    	return db;
    }

}
