package vn.book.Config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import vn.book.Service.Impl.UserSecurityService;
import vn.book.Util.SecurityUtility;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig {
	@Autowired
	UserSecurityService userSecurityService;
	private BCryptPasswordEncoder passwordEncoder() {
		return SecurityUtility.passwordEncoder();
	}
	
	private static final String[] PUBLIC_MATCHERS = {
			"/css/**",
			"/js/**",
			"/image/**",
			"/templates/**",
			"/**",
			"/home/**",
			"/register",
			"/verifyRegister",
			"/newuserinfo",
			"/forgotpassword",
			"/login",
			"/fonts/**",
			"/detail",
			"/search",
	};

	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.authorizeRequests().antMatchers("/admin/*").hasAuthority("ADMIN");
		
		http.authorizeRequests().antMatchers("/vendor/**","/user/**","/cart/**").hasAuthority("USER");
		
		http.authorizeRequests().antMatchers("/cart/**").authenticated();
		
		http.authorizeRequests().antMatchers(PUBLIC_MATCHERS)
			.permitAll().anyRequest().authenticated();
		
		http.csrf().disable().cors().disable()
			.formLogin().failureUrl("/login?error")
			//.defaultSuccessUrl("/home")
			.loginPage("/login").permitAll()
			.and()
			.logout().logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
			.logoutSuccessUrl("/").deleteCookies("remember-me").permitAll()
			.and()
			.rememberMe();
		
		
		return http.build();
	}

	@Autowired
	protected void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userSecurityService).passwordEncoder(passwordEncoder());
	}
	
	
}
