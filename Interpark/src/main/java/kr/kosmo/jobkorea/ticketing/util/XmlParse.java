package kr.kosmo.jobkorea.ticketing.util;

import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import kr.kosmo.jobkorea.ticketing.model.Boxof;

public class XmlParse {
	
	public static List<Boxof> getBoxofs(String stsType, String date, String cateCode, String area){
		
		List<Boxof> boxofs = null;
		
		try {
			String url = "http://www.kopis.or.kr/openApi/restful/boxoffice?"
					+ "service=36a3d2fd0b614425af270960e6ed5275&"
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
             */
        	boxofs = new ArrayList<>();
            for(int temp = 0; temp < nList.getLength(); temp++){
                Node nNode = nList.item(temp);
                if(nNode.getNodeType() == Node.ELEMENT_NODE){
                    Boxof boxof = new Boxof();
                    Element eElement = (Element)nNode;
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
        NodeList nlList =  eElement.getElementsByTagName(tag).item(0).getChildNodes();
        Node nValue = (Node) nlList.item(0);
        if(nValue == null) {
            return null;
        }    
        return nValue.getNodeValue();
    }




}
