package vn.book.Controller.Admin;


import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import vn.book.DTO.IStoreCount;




import vn.book.Service.IStoreService;
import vn.book.Service.IUserService;

@Controller
@RequestMapping("admin/thongke")
public class ThongKeAdminController {
	@Autowired
	IStoreService storeService;
	@Autowired
	IUserService userService;
	
	@GetMapping("thongkeStore")
	public ModelAndView viewStore(ModelMap model)
	{
		List<IStoreCount> listd = storeService.countStoreByDate();
		List<IStoreCount> listm = storeService.countStoreByMonth();
		List<IStoreCount> listy = storeService.countStoreByYear();
		
		List day = listd.stream().map(item -> {
			return item.getCreateAt();
		}).collect(Collectors.toList());
		
		List count = listd.stream().map(item -> {
			return item.getCount();
		}).collect(Collectors.toList());
		
		List month = listm.stream().map(item -> {
			return item.getCreateAt();
		}).collect(Collectors.toList());
		
		List countm = listm.stream().map(item -> {
			return item.getCount();
		}).collect(Collectors.toList());
		
		List year = listy.stream().map(item -> {
			return item.getCreateAt();
		}).collect(Collectors.toList());
		
		List county = listy.stream().map(item -> {
			return item.getCount();
		}).collect(Collectors.toList());
		
		model.addAttribute("day", day);
		model.addAttribute("count", count);
		
		model.addAttribute("month", month);
		model.addAttribute("countm", countm);
		
		model.addAttribute("year", year);
		model.addAttribute("county", county);
		
		return new ModelAndView("admin/thongke/thongkeStore");
	} 
	
	@GetMapping("thongkeUser")
	public ModelAndView viewUser(ModelMap model)
	{
		List<IStoreCount> listd = userService.countUserByDate();
		List<IStoreCount> listm = userService.countUserByMonth();
		List<IStoreCount> listy = userService.countUserByYear();
		
		List day = listd.stream().map(item -> {
			return item.getCreateAt();
		}).collect(Collectors.toList());
		
		List count = listd.stream().map(item -> {
			return item.getCount();
		}).collect(Collectors.toList());
		
		List month = listm.stream().map(item -> {
			return item.getCreateAt();
		}).collect(Collectors.toList());
		
		List countm = listm.stream().map(item -> {
			return item.getCount();
		}).collect(Collectors.toList());
		
		List year = listy.stream().map(item -> {
			return item.getCreateAt();
		}).collect(Collectors.toList());
		
		List county = listy.stream().map(item -> {
			return item.getCount();
		}).collect(Collectors.toList());
		
		model.addAttribute("day", day);
		model.addAttribute("count", count);
		
		model.addAttribute("month", month);
		model.addAttribute("countm", countm);
		
		model.addAttribute("year", year);
		model.addAttribute("county", county);
		
		return new ModelAndView("admin/thongke/thongkeUser");
	} 
	

}
