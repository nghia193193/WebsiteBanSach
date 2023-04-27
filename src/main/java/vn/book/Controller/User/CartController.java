package vn.book.Controller.User;

import java.io.Console;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.Optional;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.server.Session;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import ch.qos.logback.core.joran.util.beans.BeanUtil;
import vn.book.Entity.Book;
import vn.book.Entity.Cart;
import vn.book.Entity.CartItem;
import vn.book.Entity.Order;
import vn.book.Entity.OrderItem;
import vn.book.Entity.Store;
import vn.book.Entity.User;
import vn.book.Repository.BookRepository;
import vn.book.Repository.CartItemRepository;
import vn.book.Repository.CartRepository;
import vn.book.Repository.OrderRepository;
import vn.book.Service.ICartItemService;
import vn.book.Service.ICartService;
import vn.book.Service.IOrderService;
import vn.book.Service.IUserService;
import vn.book.Util.StripeResponse;

@Controller
@RequestMapping("cart")
public class CartController {
	@Autowired
	ICartService cartService;
	
	@Autowired
	CartRepository cartRepo;
	
	@Autowired
	CartItemRepository itemRepo;
	
	@Autowired
	BookRepository bookRepo;
	
	@Autowired
	IUserService userService;
	
	@GetMapping("list")
	public String showCart(Model model,Principal authentication) {
		
		User user = userService.getCurrentlyLoggedInUser(authentication);
		List<CartItem> cartItems= cartService.listCartItem(user);
		model.addAttribute("cartItems",cartItems);
		return "cart/list";
	}
	@Autowired
    private IOrderService orderService;
	
	@Autowired
	CartItemRepository itemrepo;
	
	@Autowired
	OrderRepository orderRepo;
	
	
	@Transactional
	@GetMapping("checkout")
	public String checkout(Model model,Principal authentication) 
	{
		User user = userService.getCurrentlyLoggedInUser(authentication);
		Cart cart = cartRepo.findByuser(user);
		List<CartItem> cartItems= cartService.listCartItem(user);
		List<Order> orders=new ArrayList<Order>();
		for (CartItem cartItem : cartItems) {
			Order order=new Order();
			order.setUser(user);
			order.setPhone(user.getPhone());
			
			Date date = new Date(System.currentTimeMillis());
			order.setCreateAt(date);
			order.setStatus("processing");
			order.setPaidBefore(true);
			order.setUpdateAt(null);
			order.setAddress(user.getAddress());
			order.setStore(cartItem.getBook().getStore());
			
			order.setAmountFromUser(cartItem.getCount());
			orders.add(order);
//			cartRepo.save(cartItem);
//			cartItem = null;
		}
		orderRepo.saveAll(orders);
		
		itemrepo.deleteBycart(cart);
		System.out.println("!!! CHECKER HERE"+cartItems.size());

		return "cart/list";
	}
	
	@Autowired
	ICartItemService itemService;
	
	@Transactional
	@GetMapping("remove/{itemId}")
	public String removerItem(ModelMap model, @PathVariable("itemId") Long itemID, Principal authentication) {
		User user = userService.getCurrentlyLoggedInUser(authentication);
		Cart cart = cartRepo.findByuser(user);
		List<CartItem> cartItems= cartService.listCartItem(user);
		Optional<CartItem> option = itemService.findById(itemID);
		CartItem item=option.get();
		System.out.print("Check :"+item.getId());
		itemService.deleteById(itemID);
		
		return "redirect:/cart/list";
	}
	
	/*
	 * @PostMapping("/create-checkout-session") public
	 * ResponseEntity<StripeResponse> checkoutList(@RequestBody List<OrderItem>
	 * checkoutItemDtoList){ Session session =
	 * orderService.createSession(checkoutItemDtoList); StripeResponse
	 * stripeResponse = new StripeResponse(session.getId()); return new
	 * ResponseEntity<StripeResponse>(stripeResponse,HttpStatus.OK); }
	 */
//	public Integer addProduct(Long id,User user)
//	{
//		Integer quan=1;
//		Book book=bookRepo.findById(id).get();
//		Cart cart= cartRepo.findByuser(user);
//		CartItem item= cartService.findItem(book, cart);
//		if(item !=null)
//		{
//			quan = item.getCount()+quan;
//			item.setCount(quan);
//		}
//		else
//		{
//			item = new CartItem();
//			item.setCount(quan);
//			item.setBook(book);
//			item.setCart(cart);
//		}
//		itemRepo.save(item);
//		return quan;
//	}
}
