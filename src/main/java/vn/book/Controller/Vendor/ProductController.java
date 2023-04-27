package vn.book.Controller.Vendor;

import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import vn.book.Model.CategoryModel;
import vn.book.Entity.Book;
import vn.book.Entity.Category;
import vn.book.Entity.Store;
import vn.book.Entity.User;
import vn.book.Model.BookModel;
import vn.book.Service.IBookService;
import vn.book.Service.ICategoryService;
import vn.book.Service.IOrderService;
import vn.book.Service.IStoreService;
import vn.book.Service.IUserService;

@Controller
@RequestMapping("vendor/product")
public class ProductController {
	@Autowired
	IBookService bookSer;
	@Autowired
	ICategoryService cateSer;
	@Autowired
	Cloudinary cloudinary;
	@Autowired
	IUserService userSer;
	@Autowired
	IStoreService storeSer;
	@Autowired
	IOrderService orderSer;

	@ModelAttribute("newOrders")
	public Long newOrders(Principal principal) {
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		return orderSer.countByStoreAndStatus(storeEntity, "not_processed");
	}

	@ModelAttribute("categories")
	public List<CategoryModel> getCategory() {
		return cateSer.findByDeleteFalse().stream().map(item -> {
			CategoryModel cate = new CategoryModel();
			BeanUtils.copyProperties(item, cate);
			return cate;
		}).collect(Collectors.toList());
	}

	@RequestMapping("")
	public String toListProduct() {
		return "redirect:/vendor/product/onsale";
	}

	@RequestMapping("onsale")
	public String listOnSale(ModelMap model, Principal principal) {
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		if (storeEntity.isActive()) {
			List<Book> books = bookSer.findByStoreAndSellingTrue(storeEntity);
			model.addAttribute("onSale", true);
			model.addAttribute("books", books);
			return "vendor/listProduct";
		}
		return "vendor/storeInActive";
	}

	@RequestMapping("instorage")
	public String listInStorage(ModelMap model, Principal principal) {
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		if (storeEntity.isActive()) {
			List<Book> books = bookSer.findByStoreAndSellingFalse(storeEntity);
			model.addAttribute("onSale", false);
			model.addAttribute("books", books);
			return "vendor/listProduct";
		}
		return "vendor/storeInActive";
	}

	@GetMapping("add")
	public String add(ModelMap model) {
		BookModel book = new BookModel();
		book.setIsEdit(false);
		book.setSelling(true);
		model.addAttribute("book", book);
		return "vendor/addOrEdit";
	}

	@GetMapping("edit/{bookId}")
	public ModelAndView edit(ModelMap model, @PathVariable("bookId") Long bookId) {
		Optional<Book> option = bookSer.findById(bookId);
		BookModel book = new BookModel();
		if (option.isPresent()) {
			Book bookEntity = option.get();
			BeanUtils.copyProperties(bookEntity, book);
			book.setIsEdit(true);
			book.setCategoryId(bookEntity.getCategory().getCategoryId());
			model.addAttribute("book", book);
			return new ModelAndView("vendor/addOrEdit", model);
		}
		model.addAttribute("message", "Sản phẩm không tồn tại");
		return new ModelAndView("forward:/vendor/product", model);
	}

	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(ModelMap model, @Valid @ModelAttribute("book") BookModel book, Principal principal,
			BindingResult result) {
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		if (storeEntity.isActive()) {
			if (result.hasErrors()) {
				return new ModelAndView("vendor/addOrEdit");
			}
			String message = "";
			Book bookEntity = new Book();
			BeanUtils.copyProperties(book, bookEntity);
			Category cateEntity = new Category();
			cateEntity.setCategoryId(book.getCategoryId());
			bookEntity.setCategory(cateEntity);
			bookEntity.setStore(storeEntity);
			if (!book.getImageFile().isEmpty()) {
				try {
					Map r = this.cloudinary.uploader().upload(book.getImageFile().getBytes(),
							ObjectUtils.asMap("resource_type", "auto"));
					String img = (String) r.get("secure_url");
					bookEntity.setImage(img);
				} catch (Exception e) {
					e.printStackTrace();
					message = "Error: Cannot upload file";
					model.addAttribute("message", message);
					return new ModelAndView("forward:/vendor/product", model);
				}

			}
			if (book.getIsEdit() == true) {
				message = "Cập nhật thành công";
			} else {
				message = "Thêm thành công";
			}
			bookSer.save(bookEntity);

			model.addAttribute("message", message);
			return new ModelAndView("forward:/vendor/product/onsale", model);
		}
		return new ModelAndView("vendor/storeInActive");
	}
	
	@GetMapping("delete/{bookId}")
	public ModelAndView delete(ModelMap model,
			@PathVariable("bookId") Long bookId) {
		bookSer.deleteById(bookId);
		model.addAttribute("message", "Đã xóa thành công");
		return new ModelAndView("forward:/vendor/product/onsale", model);
	}
}
