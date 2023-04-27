package vn.book.Service;

import java.util.Optional;

import vn.book.Entity.CartItem;

public interface ICartItemService {
	public Optional<CartItem> findById(Long id);
	public void deleteById(Long id);
}
