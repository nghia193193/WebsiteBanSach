package vn.book.Controller.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import vn.book.Service.ICartService;

@RestController
public class CartRestController {
	@Autowired
	public ICartService cartSer;
}
