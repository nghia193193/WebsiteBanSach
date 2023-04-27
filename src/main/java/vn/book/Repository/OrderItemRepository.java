package vn.book.Repository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import vn.book.Entity.Order;
import vn.book.Entity.OrderItem;
import vn.book.Model.StoreRevenueReport;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, Long>{
	List<OrderItem> findByOrderIn(Collection<Order> orders);
	List<OrderItem> findByOrder(Order order);
	@Query("SELECT new vn.book.Model.StoreRevenueReport(sum(o.book.price*o.count), o.createAt) "
			+ "FROM OrderItem o "
			+ "WHERE o.order.store.storeId = ?1 AND o.createAt BETWEEN CAST(?2 as java.util.Date) AND CAST(?3 as java.util.Date) GROUP BY o.createAt")
	List<StoreRevenueReport> storeRevenueReport(Long storeId, String fromday, String today);
	List<OrderItem> findAllByOrder(Optional<Order> order);
}
