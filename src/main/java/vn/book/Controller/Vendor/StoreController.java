package vn.book.Controller.Vendor;

import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import vn.book.Entity.Store;
import vn.book.Entity.User;
import vn.book.Model.CategoryModel;
import vn.book.Model.StoreModel;
import vn.book.Service.IBookService;
import vn.book.Service.IOrderService;
import vn.book.Service.IStoreService;
import vn.book.Service.IUserService;

@Controller
@RequestMapping("vendor")
public class StoreController {
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
	
	@ModelAttribute("newOrders")
	public Long newOrders(Principal principal){
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		return orderSer.countByStoreAndStatus(storeEntity, "not_processed");
	}
	
	@RequestMapping("")
	public String goToStore(ModelMap model, Principal principal) {
		//if(principal!=null) {
			String username = principal.getName();
			User userEntity = userSer.findByUsername(username);
			
			if(storeSer.findByOwner(userEntity)==null) {
				return "redirect:/vendor/storeregister";
			}else {
				return "redirect:/vendor/dashboard";
			}
		//}
		//return "redirect:/login";
	}
	
	@GetMapping("storeregister")
	public String storeRegisForm() {
		return "vendor/storeRegisterForm";
	}
	
	@PostMapping("storeregister")
	public String newStore(@Valid @ModelAttribute("store") StoreModel store,
							Principal principal,
							BindingResult result,
							ModelMap model) {
		if(result.hasErrors()) {
			return "vendor/storeRegisterForm";
		}
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = new Store();
		BeanUtils.copyProperties(store, storeEntity);
		storeEntity.setActive(true);
		storeEntity.setOpen(true);
		storeEntity.setOwner(userEntity);
		if(!store.getAvatarFile().isEmpty()) {
			try {
				Map r = this.cloudinary.uploader().upload(store.getAvatarFile().getBytes(),
						ObjectUtils.asMap("resource_type", "auto"));
				String img = (String) r.get("secure_url");
				userEntity.setAvatar(img);
			} catch (Exception e) {
				e.printStackTrace();
				String message = "Error: Cannot upload file";
				model.addAttribute("message", message);
				return "web/informationRegister";
			}
		}
		Date date = new Date(System.currentTimeMillis());
		storeEntity.setCreateAt(date);
		storeSer.save(storeEntity);
		return "redirect:/vendor/dashboard";
	}
	
	@GetMapping("storeprofile")
	public String storeProfile(@ModelAttribute("store") StoreModel store, ModelMap model, Principal principal) {
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		if(storeEntity.isActive()) {
			BeanUtils.copyProperties(storeEntity, store);
			model.addAttribute("store", store);
			return "vendor/storeProfile";
		}
		return "vendor/storeInActive";
	}
	
	@PostMapping("storeprofile")
	public String updateStoreProfile(@Valid @ModelAttribute("store") StoreModel store,
									ModelMap model,
									Principal principal,
									BindingResult result) {
		if(result.hasErrors()) {
			return "vendor/storeProfile";
		}
		String username = principal.getName();
		User userEntity = userSer.findByUsername(username);
		Store storeEntity = storeSer.findByOwner(userEntity);
		store.setStoreId(storeEntity.getStoreId());
		store.setCreateAt(storeEntity.getCreateAt());
		store.setActive(storeEntity.isActive());
		if(store.getAvatarFile().isEmpty()) {
			store.setAvatar(storeEntity.getAvatar());
		}
		BeanUtils.copyProperties(store, storeEntity);
		if(!store.getAvatarFile().isEmpty()) {
			try {
				Map r = this.cloudinary.uploader().upload(store.getAvatarFile().getBytes(),
						ObjectUtils.asMap("resource_type", "auto"));
				String img = (String) r.get("secure_url");
				storeEntity.setAvatar(img);
			} catch (Exception e) {
				e.printStackTrace();
				String message = "Error: Cannot upload file";
				model.addAttribute("message", message);
				return "vendor/storeProfile";
			}
		}
		Date date = new Date(System.currentTimeMillis());
		storeEntity.setUpdateAt(date);
		storeSer.save(storeEntity);
		BeanUtils.copyProperties(storeEntity, store);
		model.addAttribute("store", store);
		model.addAttribute("success", true);
		return "vendor/storeProfile";
	}
}
