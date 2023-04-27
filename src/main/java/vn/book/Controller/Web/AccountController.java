package vn.book.Controller.Web;

import java.util.Arrays;
import java.util.Date;
import java.util.Map;
import java.util.Random;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import net.bytebuddy.utility.RandomString;
import vn.book.Entity.User;
import vn.book.Model.UserModel;
import vn.book.Service.CustomerNotFoundException;
import vn.book.Service.IUserService;
import vn.book.Service.Impl.UserSecurityService;
import vn.book.Util.MailConstructor;
import vn.book.Util.SecurityUtility;
import vn.book.Util.Utility;

@Controller
@RequestMapping
public class AccountController {
	@Autowired
	IUserService userSer;
	@Autowired
	JavaMailSender mailSender;
	@Autowired
	MailConstructor mailConstructor;
	@Autowired
	UserSecurityService userSecurityService;
	@Autowired 
	Cloudinary cloudinary;

	@GetMapping("forgot_password")
    public String showForgotPasswordForm() {
		return "web/forgot_password_form";
    }
	@PostMapping("forgot_password")
    public String processForgotPassword(HttpServletRequest request, Model model) {
		String email = request.getParameter("email");
	    String token = RandomString.make(30);
	     
	    try {
	    	userSer.updateResetPasswordToken(token, email);
	        String resetPasswordLink = Utility.getSiteURL(request) + "/reset_password?token=" + token;
	        sendEmail(email, resetPasswordLink);
	        model.addAttribute("message", "We have sent a reset password link to your email. Please check.");
	         
	    } catch (CustomerNotFoundException ex) {
	        model.addAttribute("error", ex.getMessage());
	    } catch (UnsupportedEncodingException | MessagingException e) {
	        model.addAttribute("error", "Error while sending email");
	    }
	         
	    return "web/forgot_password_form";
    }
     
	public void sendEmail(String recipientEmail, String link)
	        throws MessagingException, UnsupportedEncodingException {
		MimeMessage message = mailSender.createMimeMessage();              
	    MimeMessageHelper helper = new MimeMessageHelper(message);
	     
	    helper.setFrom("contact@shopme.com", "Shopme Support");
	    helper.setTo(recipientEmail);
	     
	    String subject = "Here's the link to reset your password";
	     
	    String content = "<p>Hello,</p>"
	            + "<p>You have requested to reset your password.</p>"
	            + "<p>Click the link below to change your password:</p>"
	            + "<p><a href=\"" + link + "\">Change my password</a></p>"
	            + "<br>"
	            + "<p>Ignore this email if you do remember your password, "
	            + "or you have not made the request.</p>";
	     
	    helper.setSubject(subject);
	     
	    helper.setText(content, true);
	     
	    mailSender.send(message);
    }  
     
     
	@GetMapping("reset_password")
	public String showResetPasswordForm(@Param(value = "token") String token, Model model) {
	    User customer = userSer.getByResetPasswordToken(token);
	    model.addAttribute("token", token);
	     
	    if (customer == null) {
	        model.addAttribute("message", "Invalid Token");
	        return "message";
	    }
	     
	    return "web/reset_password_form";
	}
     
	@PostMapping("reset_password")
	public String processResetPassword(HttpServletRequest request, Model model) {
	    String token = request.getParameter("token");
	    String password = request.getParameter("password");
	     
	    User customer = userSer.getByResetPasswordToken(token);
	    model.addAttribute("title", "Reset your password");
	     
	    if (customer == null) {
	        model.addAttribute("message", "Invalid Token");
	        return "message";
	    } else {           
	    	userSer.updatePassword(customer, password);
	         
	        model.addAttribute("message", "You have successfully changed your password.");
	    }
	     
	    return "message";
	}
    
	@RequestMapping("login")
	public String login(ModelMap model) {
		return "web/login";
	}

	@RequestMapping("register")
	public String registerForm(ModelMap model) {
		model.addAttribute("userModel", new UserModel());
		return "web/userRegister";
	}

	@PostMapping("register")
	public String registerPost(HttpServletRequest request, @Valid @ModelAttribute("userModel") UserModel user,
			ModelMap model, BindingResult result) throws Exception {
		if (result.hasErrors()) {
			return "web/userRegister";
		}
		model.addAttribute("email", user.getEmail());
		model.addAttribute("username", user.getUsername());

		if (userSer.findByUsername(user.getUsername()) != null) {
			model.addAttribute("usernameExists", true);

			return "web/userRegister";
		}

		if (userSer.findByEmail(user.getEmail()) != null) {
			model.addAttribute("emailExists", true);

			return "web/userRegister";
		}
		HttpSession session = request.getSession();
		Random rand = new Random();
		int[] otpvalue = new int[6];
		for(int i=0;i<6;i++) {
			otpvalue[i] = rand.nextInt(6);
		}
		String otp = Arrays
	            .stream(otpvalue)
	            .mapToObj(String::valueOf)
	            .reduce((a, b) -> a.concat(b))
	            .get();
		System.out.print(otp);
		
		session.setAttribute("otp", otp);
		session.setAttribute("username", user.getUsername());
		session.setAttribute("email", user.getEmail());
		/*
		 * user.setRole("USER"); User userEntity = new User();
		 * 
		 * BeanUtils.copyProperties(user, userEntity);
		 * 
		 * String password = SecurityUtility.randomPassword();
		 * 
		 * 
		 * userEntity.setPassword(password); userSer.save(userEntity);
		 */

		//String appUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();

		SimpleMailMessage email = mailConstructor.constructOtpEmail(request.getLocale(), user.getEmail(), otp);

		mailSender.send(email);

		model.addAttribute("emailSent", "true");
		return "web/verify";
	}

	@PostMapping("verifyRegister")
	public String verifyOTP(@ModelAttribute("otp") String otp, HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		String trueOtp = (String) session.getAttribute("otp");
		String username = (String) session.getAttribute("username");
		String email = (String) session.getAttribute("email");
		// user.setUsername(userEntity.getUsername());
		if (otp.equals(trueOtp)) {
			UserModel user = new UserModel();
			user.setUsername(username);
			user.setEmail(email);
			model.addAttribute("user", user);
			return "web/informationRegister";
		}
		model.addAttribute("message", "Opt không đúng");
		return "web/verify";

	}

	@PostMapping("newuserinfo")
	public String updateUserInfo(@Valid @ModelAttribute("user") UserModel user,
								@ModelAttribute("confirmPassword") String confirmPass,
								ModelMap model,
								BindingResult result) throws Exception {
			if(result.hasErrors()) {
				return "web/informationRegister";
			}
			User userEntity = new User();
			
			/*check email already exists*/
			if (userSer.findByEmail(user.getEmail())!=null) {
					model.addAttribute("emailExists", true);
					return "web/informationRegister";
			}
			
			/*check username already exists*/
			if (userSer.findByUsername(user.getUsername())!=null) {
					model.addAttribute("usernameExists", true);
					return "web/informationRegister";
			}
			BeanUtils.copyProperties(user, userEntity);
			//update password
			if (user.getPassword() != null && !user.getPassword().isEmpty() && !user.getPassword().equals("")){
				BCryptPasswordEncoder passwordEncoder = SecurityUtility.passwordEncoder();
				if(confirmPass.equals(user.getPassword())) {
					userEntity.setPassword(passwordEncoder.encode(user.getPassword()));
				} else {
					model.addAttribute("incorrectConfirmPassword", true);
					return "web/informationRegister";
				}
			}
			
			userEntity.setRole("USER");
			Date date = new Date(System.currentTimeMillis());
			userEntity.setCreateAt(date);
			
			
			if(!user.getAvatarFile().isEmpty()) {
				try {
					Map r = this.cloudinary.uploader().upload(user.getAvatarFile().getBytes(),
							ObjectUtils.asMap("resource_type", "auto"));
					String img = (String) r.get("secure_url");
					userEntity.setAvatar(img);
				} catch (Exception e) {
					e.printStackTrace();
					String message = "Error: Cannot upload file";
					model.addAttribute("message", message);
					return "web/informationRegister";
				}
				
			}
			
			userSer.save(userEntity);
			
			UserDetails userDetails = userSecurityService.loadUserByUsername(userEntity.getUsername());

			Authentication authentication = new UsernamePasswordAuthenticationToken(userDetails, userDetails.getPassword(),
					userDetails.getAuthorities());
			
			SecurityContextHolder.getContext().setAuthentication(authentication);
			return "web/registerSuccess";
		}
}
