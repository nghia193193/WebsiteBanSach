package vn.book.Util;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Component;

import vn.book.Entity.User;

@Component
public class MailConstructor {
	@Autowired
	Environment env;
	
//	public SimpleMailMessage constructResetTokenEmail(String contextPath, Locale locale, String targetEmail, String otp) {
//		/* String url = contextPath + "/register?token="+token; */
//		String message = "\nMã OTP xác nhận của bạn là: "+ otp;
//		SimpleMailMessage email = new SimpleMailMessage();
//		email.setTo(targetEmail);
//		email.setSubject("Boker - Tài khoản mới");
//		email.setText(message);
//		email.setFrom(env.getProperty("support.email"));
//		return email;
//	}
	
	public SimpleMailMessage constructOtpEmail(Locale locale, String targetEmail, String otp) {
		/* String url = contextPath + "/register?token="+token; */
		String message = "\nMã OTP xác nhận của bạn là: "+ otp;
		SimpleMailMessage email = new SimpleMailMessage();
		email.setTo(targetEmail);
		email.setSubject("Boker - Tài khoản mới");
		email.setText(message);
		email.setFrom(env.getProperty("support.email"));
		return email;
	}
}
