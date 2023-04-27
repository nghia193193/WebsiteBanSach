package vn.book.Service.Impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.book.Entity.CartItem;
import vn.book.Repository.CartItemRepository;
import vn.book.Service.ICartItemService;

@Service
public class CartItemServiceImpl implements ICartItemService{
	
	@Autowired
	CartItemRepository itemRepo;
	@Override
	public Optional<CartItem> findById(Long id) {
		// TODO Auto-generated method stub
		return itemRepo.findById(id);
	}
	@Override
	public void deleteById(Long id) {
		// TODO Auto-generated method stub
		itemRepo.deleteById(id);
	}

}
