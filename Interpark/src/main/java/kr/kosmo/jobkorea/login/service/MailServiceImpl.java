package kr.kosmo.jobkorea.login.service;

import java.util.Map;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import java.util.List;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.login.model.RegisterInfoModel;

@Service
public class MailServiceImpl implements MailService {
	
	@Value("${mail.sender}")
	private String MAIL_SENDER;
	
	@Autowired
	private JavaMailSender mailSender;

	// 아이디 찾기 이메일 발송
	@Override
	public int findId(Map<String, Object> paramMap) throws Exception {

		// 받는 사람 (대표자 이메일)
		String to_mail = (String) paramMap.get("mail");
		String to_name = (String) paramMap.get("loginID");
		
		// 메일 제목
		String subject = " 요청 하신 아이디 입니다.";
		String content = "안녕하세요  MiniBook 입니다.";	
		
		@SuppressWarnings("unchecked")
		List<RegisterInfoModel> loginIdlist = (List<RegisterInfoModel>) paramMap.get("loginIdlist");

		MimeMessage mail = mailSender.createMimeMessage();
		MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
		
		mailHelper.setSubject(subject);
	    mailHelper.setTo(new InternetAddress(to_mail, to_name, "UTF-8"));
	    
	    
		for ( RegisterInfoModel data : loginIdlist ) {
			content += "<br>아이디 : "+data.getLoginID() ;
		}
		content += "<br> 감사합니다. <br>";
		content += " ---------------------------------<br> ";
		
		mailHelper.setText(content, true);
		try{
			mailSender.send(mail);
			return 1;
		}catch( MailException e ){
			return 0;
		}
	}
	
	// 비밀번호 찾기 이메일 발송
	@Override
	public int findPass(Map<String, Object> paramMap) throws Exception {

		// 받는 사람 (대표자 이메일)
		String to_mail = (String) paramMap.get("mail");
		String to_name = (String) paramMap.get("loginID");
		
		// 메일 제목
		String subject = " 변경하신 비밀번호 입니다.";
		String content = " 안녕하세요  해피잡 입니다. <br> "+to_name+" 님의 임시 비빌번호를 알려 드립니다.<br>";	
	           content += " 임시 비밀번호 : "+paramMap.get("password")+"<br>";
	   	   	   content += " 감사합니다. <br>";

	   	MimeMessage mail = mailSender.createMimeMessage();
		MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
		
		mailHelper.setSubject(subject);
	    mailHelper.setTo(new InternetAddress(to_mail, to_name, "UTF-8"));
		mailHelper.setText(content, true);
		try{
			mailSender.send(mail);
			return 1;
		}catch( MailException e ){
			return 0;
		}
	}

}
