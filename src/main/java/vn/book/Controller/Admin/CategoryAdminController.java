package vn.book.Controller.Admin;

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
import vn.book.Model.CategoryModel;
import vn.book.Service.ICategoryService;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime; 
import java.time.format.DateTimeFormatter; 


@Controller
@RequestMapping("admin/categories")
public class CategoryAdminController {
	@Autowired
	ICategoryService categoryService;
	@Autowired
	Cloudinary cloudinary;
	
	@RequestMapping("")
	public String list(ModelMap model, @RequestParam("page") Optional<Integer> page, 
			  @RequestParam("size") Optional<Integer> size) {

		
		  int count = (int) categoryService.count(); 
		  int currentPage = page.orElse(1);
		  int pageSize = size.orElse(3);
		  
		  Pageable pageable = PageRequest.of(currentPage-1, pageSize, Sort.by("categoryId")); 
		  Page<Category> resultPage = null; 
		  resultPage = categoryService.findAll(pageable); 
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
		  model.addAttribute("categoryPage", resultPage);
		  
		  return "admin/categories/list";
		 
	}
	
	@GetMapping("view/{categoryId}")
	public ModelAndView view(ModelMap model, @PathVariable("categoryId") Long categoryId)
	{
		Optional<Category> opt = categoryService.findById(categoryId);

		CategoryModel cate = new CategoryModel();
		if(opt.isPresent()){
			Category entity = opt.get();
			BeanUtils.copyProperties(entity,cate);
			model.addAttribute("category",cate);
			return new ModelAndView("admin/categories/view",model);
		}
		model.addAttribute("message","Category không tồn tại");
		return new ModelAndView("forward:/admin/categories",model);
	}
	
	@GetMapping("add")
	public String Add(ModelMap model) {
		CategoryModel cate = new CategoryModel();
		cate.setIsEdit(false); 
		cate.setDelete(false); 
		model.addAttribute("category",cate);
		return "admin/categories/addOrEdit";
	}
	
	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(ModelMap model,
			@Valid @ModelAttribute("category") CategoryModel cate, BindingResult result)

	{
		if(result.hasErrors()){
			return new ModelAndView("admin/categories/addOrEdit");
		}
		
		Category entity = new Category();
		
		BeanUtils.copyProperties(cate,entity);
		
		// xử lí hình ảnh
		if (!cate.getImageFile().isEmpty()) {

			try {
				// lưu file vào cloudinary
				Map r;
				r = this.cloudinary.uploader().upload(cate.getImageFile().getBytes(),
						ObjectUtils.asMap("resource_type", "auto"));
				String img = (String) r.get("secure_url");
				entity.setImage(img);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		categoryService.save(entity);
		
		String message ="";
		if(cate.getIsEdit()==true)
		{
			message ="Update thành công";
		}
		else {message ="Thêm thành công";}
		model.addAttribute("message",message);
		return new ModelAndView("forward:/admin/categories",model);
	}

	@GetMapping("edit/{categoryId}")
	public ModelAndView edit(ModelMap model, @PathVariable("categoryId") Long categoryId)
	{
		Optional<Category> opt = categoryService.findById(categoryId);

		CategoryModel cate = new CategoryModel();
		if(opt.isPresent()){
			Category entity = opt.get();
			BeanUtils.copyProperties(entity,cate);
			cate.setIsEdit(true);
			model.addAttribute("category",cate);
			return new ModelAndView("admin/categories/addOrEdit",model);
		}
		model.addAttribute("message","Category không tồn tại");
		return new ModelAndView("forward:/admin/categories",model);
	}
	
	@GetMapping("delete/{categoryId}")
	public ModelAndView delete(ModelMap model, @PathVariable("categoryId") Long categoryId)
	{
		
		try {
			categoryService.deleteById(categoryId);
			model.addAttribute("message","Xoá thành công");
			return new ModelAndView("forward:/admin/categories",model);
		} catch (StackOverflowError e) {
			model.addAttribute("message","Xóa không thành công");
			return new ModelAndView("forward:/admin/categories",model);
		}
		
	}

	
	  @RequestMapping("searchpagenated")
	  public String search(ModelMap model,
			  @RequestParam(name="name",required = false) String name,
			  @RequestParam("page") Optional<Integer> page, 
			  @RequestParam("size") Optional<Integer> size) {
		  
		  int count = (int) categoryService.count();
		  int currentPage = page.orElse(1);
		  int pageSize = size.orElse(3);
		  
		  Pageable pageable = PageRequest.of(currentPage-1, pageSize, Sort.by("categoryId"));
		  Page<Category> resultPage = null;
		  
		  if(StringUtils.hasText(name)) {
			  resultPage = categoryService.findByCategoryNameContaining(name, pageable);
			  model.addAttribute("name", name);
		  } else {
			  resultPage = categoryService.findAll(pageable);
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
		  model.addAttribute("categoryPage", resultPage);
		  return "admin/categories/searchpagenated";
	  }
	
}
