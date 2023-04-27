package vn.book.Service;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

import vn.book.Entity.Order;
import vn.book.Entity.OrderItem;
import vn.book.Model.StoreRevenueReport;

public interface IOrderItemService {

	void deleteById(Long id);

	long count();

	Optional<OrderItem> findById(Long id);

	<S extends OrderItem> List<S> saveAll(Iterable<S> entities);

	List<OrderItem> findByOrderIn(Collection<Order> orders);

	List<OrderItem> findByOrder(Order order);

	List<StoreRevenueReport> storeRevenueReport(Long storeId, String fromday, String today);

	List<OrderItem> findAllByOrder(Optional<Order> order);

}
