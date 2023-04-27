package vn.book.Service.Impl;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;

import vn.book.Entity.Book;
import vn.book.Entity.Cart;
import vn.book.Entity.CartItem;
import vn.book.Entity.User;
import vn.book.Repository.CartItemRepository;
import vn.book.Repository.CartRepository;
import vn.book.Service.ICartService;


@Service
public class CartServiceImpl implements ICartService{

	@Autowired
	CartRepository cartRepo;
	
	@Autowired
	CartItemRepository itemRepo;
	
	@Override
	public List<CartItem> listCartItem(User user) {
		// TODO Auto-generated method stub
		Cart cart= cartRepo.findByuser(user);
		List<CartItem> list= itemRepo.findBycart(cart);
		return list;
	}
	
//	public CartItem findItem(Book book,Cart cart) {
//		CartItem carTitem;
//		carTitem=itemRepo.findBybookAndcart(book, cart);
//		return carTitem;
//	}
	
}

