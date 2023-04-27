package vn.book.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.book.Entity.Order;
import vn.book.Entity.Store;
import vn.book.Entity.User;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
	List<Order> findByStore(Store store);
	List<Order> findByStoreAndStatus(Store store, String status);
	Long countByStoreAndStatus(Store store, String status);

	Page<Order> findAllByuser(User user, Pageable pageable);

	Page<Order> findAllByStore(Optional<Store> store, Pageable pageable); 
	Page<Order> findAllByStoreAndUserUsernameContaining(Optional<Store> store,String name, Pageable pageable); 

}
