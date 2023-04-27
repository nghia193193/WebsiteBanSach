package vn.book.Controller.Admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.book.Entity.Category;
import vn.book.Service.ICategoryService;

@Controller
@RequestMapping("admin")
public class HomeAdminController {
	
	@Autowired
	ICategoryService categoryService;
	
	@RequestMapping("home")
	public String home() {
		return "admin/index";
	}
	
}
