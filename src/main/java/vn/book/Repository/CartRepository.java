package vn.book.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.book.Entity.Cart;
import vn.book.Entity.CartItem;
import vn.book.Entity.User;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
	public Cart findByuser(User user);

	public void save(List<CartItem> cartItems);
	

}
