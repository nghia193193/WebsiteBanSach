package vn.book.Service;

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


public interface ICartService {


	List<CartItem> listCartItem(User user);
	
	//public CartItem findItem(Book book,Cart cart);
}
