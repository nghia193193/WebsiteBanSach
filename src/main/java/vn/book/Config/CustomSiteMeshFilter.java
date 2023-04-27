package vn.book.Config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		builder.addDecoratorPath("/home/*", "/decorators/web.jsp")
				.addDecoratorPath("/listByPage", "/decorators/web.jsp")
				.addDecoratorPath("/storeListByPage", "/decorators/web.jsp")
				.addDecoratorPath("/admin/*", "/decorators/admin.jsp")
				.addDecoratorPath("/cart/*", "/decorators/user.jsp")
				.addDecoratorPath("/vendor/*", "/decorators/vendor.jsp")
				.addDecoratorPath("/user/*", "/decorators/user.jsp")
				.addExcludedPath("/login").addExcludedPath("/login/*")
				.addExcludedPath("/verifyRegister")
				.addExcludedPath("/register").addExcludedPath("/register/*")
				.addExcludedPath("/adminlogin").addExcludedPath("/adminlogin/*");
	}
	
}
