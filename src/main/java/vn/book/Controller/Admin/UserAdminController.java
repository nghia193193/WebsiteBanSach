package vn.book.Controller.Admin;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import vn.book.Entity.Category;
import vn.book.Entity.User;
import vn.book.Model.CategoryModel;
import vn.book.Model.UserModel;
import vn.book.Service.ICategoryService;
import vn.book.Service.IUserService;

@Controller
@RequestMapping("admin/users")
public class UserAdminController {
	@Autowired
	IUserService userService;
	@Autowired
	Cloudinary cloudinary;
	
	
	  @RequestMapping("") 
	  public String list(ModelMap model, @RequestParam("page") Optional<Integer> page, 
			  @RequestParam("size") Optional<Integer> size) {
	  
		  int count = (int) userService.count(); 
		  int currentPage = page.orElse(1);
		  int pageSize = size.orElse(3);
		  
		  Pageable pageable = PageRequest.of(currentPage-1, pageSize, Sort.by("userId")); 
		  Page<User> resultPage = null; 
		  resultPage = userService.findAll(pageable); 
		  int totalPages = resultPage.getTotalPages(); 
		  if(totalPages>0) { 
			  int start = Math.max(1, currentPage-2); 
			  int end = Math.min(currentPage+2, totalPages); 
			  if(totalPages > count) { 
				  if (end == totalPages) start = end - count; 
				  else if (start == 1) end = start + count; 
			  } 
			  List<Integer> pageNumbers = IntStream.rangeClosed(start, end) 
					  					.boxed() 
					  					.collect(Collectors.toList());
			  model.addAttribute("pageNumbers", pageNumbers); 
		  }
		  model.addAttribute("userPage", resultPage);
		  
		  return "admin/users/list";
	  
	  }
	
	
	  @GetMapping("view/{userId}")
		public ModelAndView view(ModelMap model, @PathVariable("userId") Long userId)
		{
			Optional<User> opt = userService.findById(userId);

			UserModel cate = new UserModel();
			if(opt.isPresent()){
				User entity = opt.get();
				BeanUtils.copyProperties(entity,cate);
				model.addAttribute("user",cate);
				return new ModelAndView("admin/users/view",model);
			}
			model.addAttribute("message","User không tồn tại");
			return new ModelAndView("forward:/admin/users",model);
		} 
	
	@GetMapping("add")
	public String Add(ModelMap model) {
		UserModel cate = new UserModel();
		cate.setIsEdit(false); 
		cate.setDelete(false); 
		model.addAttribute("user",cate);
		return "admin/users/addOrEdit";
	}
	
	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(ModelMap model,
			@Valid @ModelAttribute("user") UserModel cate, BindingResult result)

	{
		if(result.hasErrors()){
			System.out.println(result.getAllErrors());
			return new ModelAndView("admin/users/addOrEdit");
		}
		 
		User entity = new User();
		
		BeanUtils.copyProperties(cate,entity);
		//xử lí hình ảnh
		if(!cate.getAvatarFile().isEmpty()) {
			
			try {
				//lưu file vào cloudinary
				Map r;
				r = this.cloudinary.uploader().upload(cate.getAvatarFile().getBytes(), 
						ObjectUtils.asMap("resource_type","auto"));
				String img = (String) r.get("secure_url");
				entity.setAvatar(img);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}			
		userService.save(entity);
		String message ="";
		if(cate.getIsEdit() == true)
		{
			message ="Update thành công";
		}
		else {message ="Thêm thành công";}
		model.addAttribute("message",message);
		return new ModelAndView("forward:/admin/users",model);
	}

	@GetMapping("edit/{userId}")
	public ModelAndView edit(ModelMap model, @PathVariable("userId") Long userId)
	{
		Optional<User> opt = userService.findById(userId);

		UserModel cate = new UserModel();
		if(opt.isPresent()){
			User entity = opt.get();
			BeanUtils.copyProperties(entity,cate);
			cate.setIsEdit(true);
			model.addAttribute("user",cate);
			return new ModelAndView("admin/users/addOrEdit",model);
		}
		model.addAttribute("message","User không tồn tại");
		return new ModelAndView("forward:/admin/users",model);
	}
	
	@GetMapping("delete/{userId}")
	public ModelAndView delete(ModelMap model, @PathVariable("userId") Long userId)
	{
		try {			
			userService.deleteById(userId);
			model.addAttribute("message","Xoá thành công");
			return new ModelAndView("forward:/admin/users",model);
		} catch (StackOverflowError e) {
			model.addAttribute("message","Xóa không thành công");
			return new ModelAndView("forward:/admin/users",model);
		}
	}

	
	 
	  @RequestMapping("searchpagenated")
	  public String search(ModelMap model,
			  @RequestParam(name="name",required = false) String name,
			  @RequestParam("page") Optional<Integer> page, 
			  @RequestParam("size") Optional<Integer> size) {
		  
		  int count = (int) userService.count();
		  int currentPage = page.orElse(1);
		  int pageSize = size.orElse(3);
		  
		  Pageable pageable = PageRequest.of(currentPage-1, pageSize,Sort.by("userId"));
		  Page<User> resultPage = null;
		  
		  if(StringUtils.hasText(name)) {
			  resultPage = userService.findByUsernameContaining(name, pageable);
			  model.addAttribute("name", name);
		  } else {
			  resultPage = userService.findAll(pageable);
		  }
		  
		  int totalPages = resultPage.getTotalPages();
		  if(totalPages>0) {
			  int start = Math.max(1, currentPage-2);
			  int end = Math.min(currentPage+2, totalPages);
			  if(totalPages > count) {
				  if (end == totalPages) start = end - count;
				  else if (start == 1) end = start + count;  
			  }
			  List<Integer> pageNumbers = IntStream.rangeClosed(start, end)
					  .boxed()
					  .collect(Collectors.toList());
			  model.addAttribute("pageNumbers", pageNumbers);
		  }
		  model.addAttribute("userPage", resultPage);
		  return "admin/users/searchpagenated";
	  }
	
}
