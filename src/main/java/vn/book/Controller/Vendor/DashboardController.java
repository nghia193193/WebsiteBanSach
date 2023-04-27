package vn.book.Controller.Vendor;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cloudinary.Cloudinary;

import vn.book.Entity.Book;
import vn.book.Entity.Store;
import vn.book.Entity.User;
import vn.book.Model.StoreModel;
import vn.book.Model.StoreRevenueReport;
import vn.book.Service.IBookService;
import vn.book.Service.IOrderItemService;
import vn.book.Service.IOrderService;
import vn.book.Service.IStoreService;
import vn.book.Service.IUserService;

@Controller
@RequestMapping("vendor/dashboard")
public class DashboardController {
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
	public String storeDashboard(ModelMap model, Principal principal,
								@ModelAttribute("fromday") String fromday,
								@ModelAttribute("today") String today) {
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		if(storeEntity.isActive()) {
			Long totalBook = bookSer.count();
			model.addAttribute("totalBook", totalBook);
			StoreModel store = new StoreModel();
			BeanUtils.copyProperties(storeEntity, store);
			model.addAttribute("store", store);
			
			List<StoreRevenueReport> listThongKe = orderItemSer.storeRevenueReport(storeEntity.getStoreId(), fromday, today);
			model.addAttribute("listThongKe", listThongKe);
			return "vendor/dashboard";
		}
		return "vendor/storeInActive";
	}
}
