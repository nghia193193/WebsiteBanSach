package vn.book.Controller.User;

import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.book.Entity.Book;
import vn.book.Entity.Cart;
import vn.book.Entity.CartItem;
import vn.book.Entity.Order;
import vn.book.Entity.Store;
import vn.book.Entity.User;
import vn.book.Repository.CartItemRepository;
import vn.book.Repository.CartRepository;
import vn.book.Service.IBookService;
import vn.book.Service.ICartService;
import vn.book.Service.IOrderService;
import vn.book.Service.IStoreService;
import vn.book.Service.IUserService;

@Controller
@RequestMapping("user")
public class RouteUserController {
	@Autowired
	CartRepository cartRepo;
	@Autowired
	IBookService bookService;
	@Autowired
	IStoreService storeService;
	@Autowired
	IUserService userService;
	@Autowired
	ICartService cartService;
	@Autowired
	CartItemRepository itemRepo;
	
	@RequestMapping("")
	public String homePage() {
		return "user/index";
	}
	@Autowired
	public void setBookService(IBookService bookService){
        this.bookService=bookService;
    }
	@Autowired
	public void setStoreService(IStoreService storeService){
        this.storeService=storeService;
    }
	
	@GetMapping("add/{bookId}/{quantity}")
	public String addToCart(ModelMap model, @PathVariable("bookId") Long bookId,@PathVariable("quantity") int quantity, Principal authentication)
	{
		User user = userService.getCurrentlyLoggedInUser(authentication);
		Cart cart = cartRepo.findByuser(user);
		List<CartItem> cartItems= cartService.listCartItem(user);
		Optional<Book> option = bookService.findById(bookId);
		Date date = new Date(System.currentTimeMillis());
		Book book = option.get();
		CartItem item = new CartItem();
		item.setBook(book);
		item.setCart(cart);
		item.setCount(quantity);
		item.setCreateAt(date);
		item.setUpdateAt(null);
		System.out.println("checker"+item.getCount());
		
		cartItems.add(item);
		itemRepo.saveAll(cartItems);
		return "redirect:/user/orderList";
	}
	
	@GetMapping("list")
	public String searchByPage(ModelMap model, @RequestParam(name="name",required = false)   String name, 
			@RequestParam("page") Optional<Integer> page,@RequestParam("size")Optional<Integer> size)
	{
		int count = (int) bookService.count();
		int cur = page.orElse(1);
		int pageSize = size.orElse(3);
		Pageable pageable = PageRequest.of(cur-1, pageSize,Sort.by("bookName"));
		Page<Book> res=null;
		if(StringUtils.hasText(name)) {
			res=bookService.findBybookNameContaining(name, pageable);
			model.addAttribute("name",name);
			
		}else
		{
			res=bookService.findAll(pageable);
		}
		int sumP= res.getTotalPages();
		if(sumP>0) {
			int start = Math.max(1, cur-2);
			int end = Math.min(cur+2, sumP);
			if(sumP>count) {
				if(end == sumP) {start=end-count;}
				else if (start==1) {end=start+count;}
			}
			List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
			model.addAttribute("pageNumbers",pageNumbers);
		}
		model.addAttribute("bookPage",res);
		return "user/bookList";
	}
	
	@Autowired
	IOrderService orderService;
	
	@GetMapping("orderList")
	public String orderList(ModelMap model,Principal authentication, @RequestParam(name="name",required = false)   String name, 
			@RequestParam("page") Optional<Integer> page,@RequestParam("size")Optional<Integer> size)
	{
		User user = userService.getCurrentlyLoggedInUser(authentication);
		int count = (int) orderService.count();
		int cur = page.orElse(1);
		int pageSize = size.orElse(3);
		Pageable pageable = PageRequest.of(cur-1, pageSize,Sort.by("orderId"));
		Page<Order> res=null;
		res=orderService.findAllByUser(user,pageable);
		int sumP= res.getTotalPages();
		if(sumP>0) {
			int start = Math.max(1, cur-2);
			int end = Math.min(cur+2, sumP);
			if(sumP>count) {
				if(end == sumP) {start=end-count;}
				else if (start==1) {end=start+count;}
			}
			List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
			model.addAttribute("pageNumbers",pageNumbers);
		}
		model.addAttribute("orderPage",res);
		return "user/order";
	}
	
	@GetMapping("storeListByPage")
	public String searchStoreByPage(ModelMap model, @RequestParam(name="name",required = false)   String name, 
			@RequestParam("page") Optional<Integer> page,@RequestParam("size")Optional<Integer> size)
	{
		int count = (int) storeService.count();
		int cur = page.orElse(1);
		int pageSize = size.orElse(3);
		Pageable pageable = PageRequest.of(cur-1, pageSize,Sort.by("storeName"));
		Page<Store> res=null;
		if(StringUtils.hasText(name)) {
			res=storeService.findBystoreNameContaining(name, pageable);
			model.addAttribute("name",name);
			
		}else
		{
			res=storeService.findAll(pageable);
		}
		int sumP= res.getTotalPages();
		if(sumP>0) {
			int start = Math.max(1, cur-2);
			int end = Math.min(cur+2, sumP);
			if(sumP>count) {
				if(end == sumP) {start=end-count;}
				else if (start==1) {end=start+count;}
			}
			List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
			model.addAttribute("pageNumbers",pageNumbers);
		}
		model.addAttribute("storePage",res);
		return "user/storeList";
	}
	//@PutMapping("updateInfo")
//	public User updateInfo(User user)
//	{
//		userService.updateUser(null);
//	}
	
}
