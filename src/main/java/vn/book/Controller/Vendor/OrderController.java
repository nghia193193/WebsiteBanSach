package vn.book.Controller.Vendor;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cloudinary.Cloudinary;

import vn.book.Entity.Book;
import vn.book.Entity.Order;
import vn.book.Entity.OrderItem;
import vn.book.Entity.Store;
import vn.book.Entity.User;
import vn.book.Model.BookModel;
import vn.book.Service.IBookService;
import vn.book.Service.IOrderItemService;
import vn.book.Service.IOrderService;
import vn.book.Service.IStoreService;
import vn.book.Service.IUserService;

@Controller
@RequestMapping("vendor/order")
public class OrderController {
	@Autowired
	IUserService userSer;
	@Autowired
	IStoreService storeSer;
	@Autowired
	Cloudinary cloudinary;
	@Autowired
	IBookService bookSer;
	@Autowired
	IOrderService orderSer;
	@Autowired
	IOrderItemService orderItemSer;
	
	@ModelAttribute("newOrders")
	public Long newOrders(Principal principal){
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		return orderSer.countByStoreAndStatus(storeEntity, "not_processed");
	}
	
	@RequestMapping("")
	public String toOrderManagement() {
		return "redirect:/vendor/order/notprocessed";
	}
	
	@GetMapping("notprocessed")
	public String notprocessedStoreOrder(Principal principal,
								ModelMap model) {
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		List<Order> orders = orderSer.findByStoreAndStatus(storeEntity, "not_processed");
		
		model.addAttribute("orders", orders);
		return "vendor/orderManagement";
	}
	
	@GetMapping("processing")
	public String processingStoreOrder(Principal principal,
								ModelMap model) {
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		List<Order> orders = orderSer.findByStoreAndStatus(storeEntity, "processing");
		
		model.addAttribute("orders", orders);
		return "vendor/orderManagement";
	}
	
	@GetMapping("shipped")
	public String shippedStoreOrder(Principal principal,
								ModelMap model) {
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		List<Order> orders = orderSer.findByStoreAndStatus(storeEntity, "shipped");
		
		model.addAttribute("orders", orders);
		return "vendor/orderManagement";
	}
	
	@GetMapping("delivered")
	public String deliveredStoreOrder(Principal principal,
								ModelMap model) {
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		List<Order> orders = orderSer.findByStoreAndStatus(storeEntity, "delivered");
		
		model.addAttribute("orders", orders);
		return "vendor/orderManagement";
	}
	
	@GetMapping("cancelled")
	public String cancelledStoreOrder(Principal principal,
								ModelMap model) {
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		List<Order> orders = orderSer.findByStoreAndStatus(storeEntity, "cancelled");
		
		model.addAttribute("orders", orders);
		return "vendor/orderManagement";
	}
	
	@GetMapping("detail/{orderId}")
	public ModelAndView orderDetail(ModelMap model,
							@PathVariable("orderId") Long orderId) {
		Optional<Order> option = orderSer.findById(orderId);
		
		if (option.isPresent()) {
			Order orderEntity = option.get();
			List<OrderItem> orderItems = orderItemSer.findByOrder(orderEntity);
			model.addAttribute("orderItems", orderItems);
			double totalOrderPrice = 0;
			for(OrderItem oi: orderItems) {
				totalOrderPrice +=  oi.getBook().getPrice() * oi.getCount();
			}
			model.addAttribute("totalOrderPrice", totalOrderPrice);
			return new ModelAndView("vendor/orderDetailForm", model);
		}
		model.addAttribute("message", "Đơn hàng không tồn tại");
		return new ModelAndView("forward:/vendor/order/notprocessed", model);
	}
	
	@PostMapping("updatestatus")
	public ModelAndView updateStatus(ModelMap model,
						@ModelAttribute("status") String status,
						@ModelAttribute("orderId") Long orderId) {
		Optional<Order> option = orderSer.findById(orderId);
		if(option.isPresent()) {
			Order orderEntity = option.get();
			orderEntity.setStatus(status);
			orderSer.save(orderEntity);
			return new ModelAndView("forward:/vendor/order");
		}
		model.addAttribute("message", "Không tìm thấy đơn hàng");
		return new ModelAndView("forward:/vendor/order/notprocessed", model);
	}
}
