package vn.book.Util;

import java.security.SecureRandom;
import java.util.Random;

import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class SecurityUtility {
	public static final String SALT = "salt";
	
	@Bean
	public static BCryptPasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder(12, new SecureRandom(SALT.getBytes()));
	}
	
	@Bean
	public static String randomPassword() {
		String SALTCHARS = "ABCEFGHIJKLMNOPQRSTUVWXYZ1234567890";
		StringBuilder salt = new StringBuilder(20);
		Random random = new Random();
		
		 while(salt.length()<17) { 
			 int i = (int)(random.nextFloat()*SALTCHARS.length()); 
			 salt.append(SALTCHARS.charAt(i)); 
		}
		 
		String saltStr = salt.toString();
		return saltStr;	
	}
}
