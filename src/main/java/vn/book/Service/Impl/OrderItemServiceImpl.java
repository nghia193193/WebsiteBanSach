package vn.book.Service.Impl;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.book.Entity.Order;
import vn.book.Entity.OrderItem;
import vn.book.Model.StoreRevenueReport;
import vn.book.Repository.OrderItemRepository;
import vn.book.Service.IOrderItemService;

@Service
public class OrderItemServiceImpl implements IOrderItemService {
	@Autowired
	OrderItemRepository orderItemRepo;

	public OrderItemServiceImpl(OrderItemRepository orderItemRepo) {
		this.orderItemRepo = orderItemRepo;
	}

	@Override
	public List<OrderItem> findByOrderIn(Collection<Order> orders) {
		return orderItemRepo.findByOrderIn(orders);
	}

	@Override
	public <S extends OrderItem> List<S> saveAll(Iterable<S> entities) {
		return orderItemRepo.saveAll(entities);
	}

	@Override
	public Optional<OrderItem> findById(Long id) {
		return orderItemRepo.findById(id);
	}

	@Override
	public long count() {
		return orderItemRepo.count();
	}

	@Override
	public void deleteById(Long id) {
		orderItemRepo.deleteById(id);
	}

	@Override
	public List<OrderItem> findByOrder(Order order) {
		return orderItemRepo.findByOrder(order);
	}

	@Override
	public List<StoreRevenueReport> storeRevenueReport(Long storeId, String fromday, String today) {
		return orderItemRepo.storeRevenueReport(storeId, fromday, today);
	}

	@Override
	public List<OrderItem> findAllByOrder(Optional<Order> order) {
		return orderItemRepo.findAllByOrder(order);
	}
	
	
}
