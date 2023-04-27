package vn.book.Controller.Admin;

import java.io.IOException;
import java.time.LocalDate;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import vn.book.Entity.Book;
import vn.book.Entity.Category;
import vn.book.Entity.Order;
import vn.book.Entity.OrderItem;
import vn.book.Entity.Store;
import vn.book.Entity.User;
import vn.book.Model.BookModel;
import vn.book.Model.CategoryModel;
import vn.book.Model.OrderModel;
import vn.book.Model.StoreModel;
import vn.book.Model.UserModel;
import vn.book.Service.IBookService;
import vn.book.Service.ICategoryService;
import vn.book.Service.IOrderItemService;
import vn.book.Service.IOrderService;
import vn.book.Service.IStoreService;
import vn.book.Service.IUserService;


@Controller
@RequestMapping("admin/stores")
public class StoreAdminController {
	@Autowired
	IStoreService storeService;
	@Autowired
	IBookService bookService;
	@Autowired
	ICategoryService categoryService;
	@Autowired
	IOrderService orderService;
	@Autowired
	IOrderItemService orderItemService;
	@Autowired
	Cloudinary cloudinary;
	
	// lấy danh sách category
	@ModelAttribute("categories")
	public List<CategoryModel> getCategory() {
		return categoryService.findAll().stream().map(item -> {
			CategoryModel cate = new CategoryModel();
			BeanUtils.copyProperties(item, cate);
			return cate;
		}).collect(Collectors.toList());
	}

	
	@RequestMapping("")
	public String list(ModelMap model, @RequestParam("page") Optional<Integer> page,
			@RequestParam("size") Optional<Integer> size) {

		int count = (int) storeService.count();
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(3);

		Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("storeId"));
		Page<Store> resultPage = null;
		resultPage = storeService.findAll(pageable);
		int totalPages = resultPage.getTotalPages();
		if (totalPages > 0) {
			int start = Math.max(1, currentPage - 2);
			int end = Math.min(currentPage + 2, totalPages);
			if (totalPages > count) {
				if (end == totalPages)
					start = end - count;
				else if (start == 1)
					end = start + count;
			}
			List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
			model.addAttribute("pageNumbers", pageNumbers);
		}
		model.addAttribute("storePage", resultPage);
		
		return "admin/stores/list";

	}
	 
	
	@GetMapping("add")
	public String Add(ModelMap model) {
		StoreModel cate = new StoreModel();
		cate.setIsEdit(false); 
		model.addAttribute("store",cate);
		return "admin/stores/addOrEdit";
	}
	
	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(ModelMap model,
			@Valid @ModelAttribute("store") StoreModel cate, BindingResult result)

	{
		if(result.hasErrors()){
			System.out.println(result.getAllErrors());
			return new ModelAndView("admin/stores/addOrEdit");
		}
		 
		Store entity = new Store();
		
		BeanUtils.copyProperties(cate,entity);
		
		//xử lí owner
		 User userEntity = new User();
		 userEntity.setUserId(cate.getOwnerId());
		 entity.setOwner(userEntity);
		 
		
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
		storeService.save(entity);
		String message ="";
		if(cate.getIsEdit() == true)
		{
			message ="Update thành công";
		}
		else {message ="Thêm thành công";}
		model.addAttribute("message",message);
		return new ModelAndView("forward:/admin/stores",model);
	}
	
	// begin /{storeId}/books
	@GetMapping("/{storeId}/books")
	public ModelAndView books(ModelMap model, @PathVariable("storeId") Long storeId, @RequestParam("page") Optional<Integer> page, 
			  @RequestParam("size") Optional<Integer> size)
	{
		int count = (int) bookService.count();
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(3);
		
		Optional<Store> storeEntity = storeService.findById(storeId);
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("bookId"));
		Page<Book> resultPage = null;
		resultPage = bookService.findAllByStoreAndCategoryDeleteFalse(storeEntity, pageable);
		int totalPages = resultPage.getTotalPages();
		if (totalPages > 0) {
			int start = Math.max(1, currentPage - 2);
			int end = Math.min(currentPage + 2, totalPages);
			if (totalPages > count) {
				if (end == totalPages)
					start = end - count;
				else if (start == 1)
					end = start + count;
			}
			List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
			model.addAttribute("pageNumbers", pageNumbers);
		}
		model.addAttribute("bookPage", resultPage);
		model.addAttribute("storeId", storeId);
		return new ModelAndView("admin/books/list");
	}
	
	@GetMapping("/{storeId}/books/add")
	public String AddBook(ModelMap model, @PathVariable("storeId") Long storeId) {
		BookModel book = new BookModel();
		book.setIsEdit(false); 
		model.addAttribute("book",book);
		model.addAttribute("storeId", storeId);
		return "admin/books/addOrEdit";
	}
	
	@PostMapping("/{storeId}/books/saveOrUpdate")
	public ModelAndView saveOrUpdate(ModelMap model, @PathVariable("storeId") Long storeId,
			@Valid @ModelAttribute("book") BookModel book, BindingResult result)

	{
		if(result.hasErrors()){
			System.out.println(result.getAllErrors());
			return new ModelAndView("admin/books/addOrEdit");
		}
		
		
		if(book.getIsEdit() == false) {
			book.setSold(0);
			book.setRating(0);
			book.setPromotionalPrice(book.getPrice());
		} 
		Book entity = new Book();
		
		BeanUtils.copyProperties(book,entity);
		
		//xử lí category
		Category cateEntity = new Category();
		cateEntity.setCategoryId(book.getCategoryId());
		entity.setCategory(cateEntity);
		
		//xử lí store
		Store storeEntity = new Store();
		storeEntity.setStoreId(book.getStoreId());
		entity.setStore(storeEntity);
		
		//xử lí hình ảnh
		if(!book.getImageFile().isEmpty()) {
			
			try {
				//lưu file vào cloudinary
				Map r;
				r = this.cloudinary.uploader().upload(book.getImageFile().getBytes(), 
						ObjectUtils.asMap("resource_type","auto"));
				String img = (String) r.get("secure_url");
				entity.setImage(img);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}	
		
		
		bookService.save(entity);
		String message ="";
		if(book.getIsEdit()==true)
		{
			message ="Update thành công";
		}
		else {message ="Thêm thành công";}
		model.addAttribute("message",message);
		
		return new ModelAndView("redirect:/admin/stores/{storeId}/books",model); 
	}
	
	@GetMapping("/{storeId}/books/{bookId}/edit")
	public ModelAndView editBook(ModelMap model, @PathVariable("bookId") Long bookId,@PathVariable("storeId") Long storeId)
	{
		Optional<Book> opt = bookService.findById(bookId);

		BookModel book = new BookModel();
		if(opt.isPresent()){
			Book entity = opt.get();
			BeanUtils.copyProperties(entity,book);
			book.setIsEdit(true);
			model.addAttribute("book",book);
			model.addAttribute("storeId", storeId);
			return new ModelAndView("admin/books/addOrEdit",model);
		}
		model.addAttribute("message","Sách không tồn tại");
		return new ModelAndView("redirect:/admin/stores/{storeId}/books",model);
	}
	
	
	@GetMapping("/{storeId}/books/{bookId}/delete")
	public ModelAndView deleteBook(ModelMap model, @PathVariable("bookId") Long bookId)
	{
		try {
			bookService.deleteById(bookId);
			model.addAttribute("message","Xoá thành công");
			return new ModelAndView("redirect:/admin/stores/{storeId}/books",model);
		} catch (StackOverflowError e) {
			model.addAttribute("message","Xóa không thành công");
			return new ModelAndView("redirect:/admin/stores/{storeId}/books",model);
		}
	}

	
	@GetMapping("/{storeId}/books/searchpagenated")
	public ModelAndView search(ModelMap model, @PathVariable("storeId") Long storeId, 
				@RequestParam(name="name",required = false) String name,
				@RequestParam("page") Optional<Integer> page, 
				@RequestParam("size") Optional<Integer> size)
	{
		int count = (int) bookService.count();
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(3);
		
		Optional<Store> storeEntity = storeService.findById(storeId);
		
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("bookId"));
		Page<Book> resultPage = null;
		if(StringUtils.hasText(name)) {
			resultPage = bookService.findAllByStoreAndBookNameContainingAndCategoryDeleteFalse(storeEntity, name, pageable);
			model.addAttribute("name", name);
		} else {
			resultPage = bookService.findAllByStoreAndCategoryDeleteFalse(storeEntity, pageable);
		}
		
		int totalPages = resultPage.getTotalPages();
		if (totalPages > 0) {
			int start = Math.max(1, currentPage - 2);
			int end = Math.min(currentPage + 2, totalPages);
			if (totalPages > count) {
				if (end == totalPages)
					start = end - count;
				else if (start == 1)
					end = start + count;
			}
			List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
			model.addAttribute("pageNumbers", pageNumbers);
		}
		model.addAttribute("bookPage", resultPage);
		model.addAttribute("storeId", storeId);
		return new ModelAndView("admin/books/searchpagenated");
	}
	// end {storeId}/books
	
	// begin /{storeId}/orders
	@GetMapping("/{storeId}/orders")
	public ModelAndView orders(ModelMap model, @PathVariable("storeId") Long storeId, @RequestParam("page") Optional<Integer> page, 
			  @RequestParam("size") Optional<Integer> size)
	{
		int count = (int) orderService.count();
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(3);
		
		Optional<Store> storeEntity = storeService.findById(storeId);
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("orderId"));
		Page<Order> resultPage = null;
		resultPage = orderService.findAllByStore(storeEntity, pageable);
		int totalPages = resultPage.getTotalPages();
		if (totalPages > 0) {
			int start = Math.max(1, currentPage - 2);
			int end = Math.min(currentPage + 2, totalPages);
			if (totalPages > count) {
				if (end == totalPages)
					start = end - count;
				else if (start == 1)
					end = start + count;
			}
			List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
			model.addAttribute("pageNumbers", pageNumbers);
		}
		model.addAttribute("orderPage", resultPage);
		model.addAttribute("storeId", storeId);
		return new ModelAndView("admin/orders/list");
	}
	
	@PostMapping("/{storeId}/orders/saveOrUpdate")
	public ModelAndView saveOrUpdateOrder(ModelMap model, @PathVariable("storeId") Long storeId,
			@Valid @ModelAttribute("order") OrderModel order, BindingResult result)

	{
		if(result.hasErrors()){
			System.out.println(result.getAllErrors());
			return new ModelAndView("admin/orders/addOrEdit");
		}
		
		Order entity = new Order();
		BeanUtils.copyProperties(order,entity);
		
		orderService.save(entity);
		String message ="";
		if(order.getIsEdit()==true)
		{
			message ="Update thành công";
		}
		else {message ="Thêm thành công";}
		model.addAttribute("message",message);
		
		return new ModelAndView("redirect:/admin/stores/{storeId}/orders",model); 
	}
	
	@GetMapping("/{storeId}/orders/{orderId}/view")
	public ModelAndView viewOrder(ModelMap model, @PathVariable("orderId") Long orderId,@PathVariable("storeId") Long storeId)
	{
		Optional<Order> opt = orderService.findById(storeId);
		List<OrderItem> list = orderItemService.findAllByOrder(opt);
		OrderModel order = new OrderModel();
		if(opt.isPresent()){
			Order entity = opt.get();
			BeanUtils.copyProperties(entity, order);
			model.addAttribute("order", order);
			model.addAttribute("storeId", storeId);
			model.addAttribute("orderItems", list);
			return new ModelAndView("admin/orders/view",model);
		}
		model.addAttribute("message","Đơn hàng không tồn tại");
		return new ModelAndView("redirect:/admin/stores/{storeId}/orders",model);
	}
	
	@GetMapping("/{storeId}/orders/{orderId}/edit")
	public ModelAndView editOrder(ModelMap model, @PathVariable("orderId") Long orderId,@PathVariable("storeId") Long storeId)
	{
		Optional<Order> opt = orderService.findById(storeId);

		OrderModel order = new OrderModel();
		if(opt.isPresent()){
			Order entity = opt.get();
			BeanUtils.copyProperties(entity, order);
			order.setIsEdit(true);
			model.addAttribute("order", order);
			model.addAttribute("storeId", storeId);
			return new ModelAndView("admin/orders/addOrEdit",model);
		}
		model.addAttribute("message","Đơn hàng không tồn tại");
		return new ModelAndView("redirect:/admin/stores/{storeId}/orders",model);
	}
	
	@GetMapping("/{storeId}/orders/searchpagenated")
	public ModelAndView searchOrder(ModelMap model, @PathVariable("storeId") Long storeId, 
				@RequestParam(name="name",required = false) String name,
				@RequestParam("page") Optional<Integer> page, 
				@RequestParam("size") Optional<Integer> size)
	{
		int count = (int) orderService.count();
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(3);
		
		Optional<Store> storeEntity = storeService.findById(storeId);
		
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("orderId"));
		Page<Order> resultPage = null;
		if(StringUtils.hasText(name)) {
			resultPage = orderService.findAllByStoreAndUserUsernameContaining(storeEntity, name, pageable);
			model.addAttribute("name", name);
		} else {
			resultPage = orderService.findAllByStore(storeEntity, pageable);
		}
		
		int totalPages = resultPage.getTotalPages();
		if (totalPages > 0) {
			int start = Math.max(1, currentPage - 2);
			int end = Math.min(currentPage + 2, totalPages);
			if (totalPages > count) {
				if (end == totalPages)
					start = end - count;
				else if (start == 1)
					end = start + count;
			}
			List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
			model.addAttribute("pageNumbers", pageNumbers);
		}
		model.addAttribute("orderPage", resultPage);
		model.addAttribute("storeId", storeId);
		return new ModelAndView("admin/orders/searchpagenated");
	}
	// end {storeId}/books
	// end {storeId}/orders
	
	@GetMapping("edit/{storeId}")
	public ModelAndView edit(ModelMap model, @PathVariable("storeId") Long storeId)
	{
		Optional<Store> opt = storeService.findById(storeId);

		StoreModel cate = new StoreModel();
		if(opt.isPresent()){
			Store entity = opt.get();
			BeanUtils.copyProperties(entity,cate);
			cate.setIsEdit(true);
			cate.setOwnerId(entity.getOwner().getUserId());
			model.addAttribute("store",cate);
			return new ModelAndView("admin/stores/addOrEdit",model);
		}
		model.addAttribute("message","store không tồn tại");
		return new ModelAndView("forward:/admin/stores",model);
	}
	
	@GetMapping("delete/{storeId}")
	public ModelAndView delete(ModelMap model, @PathVariable("storeId") Long storeId)
	{
		try {
			storeService.deleteById(storeId);
			model.addAttribute("message","Xoá thành công");
			return new ModelAndView("forward:/admin/stores",model);
		} catch (StackOverflowError e) {
			model.addAttribute("message","Xóa không thành công");
			return new ModelAndView("forward:/admin/stores",model);
		}
	}

	
	  
	  @RequestMapping("searchpagenated")
	  public String search(ModelMap model,
			  @RequestParam(name="name",required = false) String name,
			  @RequestParam("page") Optional<Integer> page, 
			  @RequestParam("size") Optional<Integer> size) {
		  
		  int count = (int) storeService.count();
		  int currentPage = page.orElse(1);
		  int pageSize = size.orElse(3);
		  
		  Pageable pageable = PageRequest.of(currentPage-1, pageSize,Sort.by("storeId"));
		  Page<Store> resultPage = null;
		  
		  if(StringUtils.hasText(name)) {
			  resultPage = storeService.findByStoreNameContaining(name, pageable);
			  model.addAttribute("name", name);
		  } else {
			  resultPage = storeService.findAll(pageable);
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
		  model.addAttribute("storePage", resultPage);
		  return "admin/stores/searchpagenated";
	  }
	
}
