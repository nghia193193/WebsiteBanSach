package vn.book;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import vn.book.Config.CustomSiteMeshFilter;

@SpringBootApplication
public class WebBanSachApplication {

	public static void main(String[] args) {
		SpringApplication.run(WebBanSachApplication.class, args);
	}
	
	@Bean
	public Cloudinary cloudinary() {
		Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
				  "cloud_name", "dmsv3ph70",
				  "api_key", "374365432651938",
				  "api_secret", "t8SiqMWEER42yXxxqlBMI2FQAD8",
				  "secure",true
				));
		return cloudinary;
	}
	
	@Bean
    public FilterRegistrationBean<CustomSiteMeshFilter> siteMeshFilter() {
        FilterRegistrationBean<CustomSiteMeshFilter> filterRegistrationBean = new FilterRegistrationBean<CustomSiteMeshFilter>();
        filterRegistrationBean.setFilter(new CustomSiteMeshFilter());
        return filterRegistrationBean;
    }

}
