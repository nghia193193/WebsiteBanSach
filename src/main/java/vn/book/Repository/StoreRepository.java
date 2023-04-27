package vn.book.Repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

import vn.book.DTO.IStoreCount;
import vn.book.Entity.Book;
import vn.book.Entity.Store;
import vn.book.Entity.User;

@Repository
@EnableJpaRepositories
public interface StoreRepository extends JpaRepository<Store, Long> {

	Store findByOwner(User owner);

	List<Store> findBystoreNameContaining(String name);
	Page<Store> findBystoreNameContaining(String name,Pageable p);

	List<Store> findByStoreNameContaining(String name);
	Page<Store> findByStoreNameContaining(String name, Pageable pageable);
	
	@Query(value = 
			"select day(create_at) as createAt , count(store_id) as count " +
			"from stores " +
			"where month(create_at) = month(GETDATE()) and year(create_at) = year(GETDATE()) " +
			"group by day(create_at)" , nativeQuery = true
			)
	List<IStoreCount> countStoreByDate();
	
	@Query(value = 
			"select month(create_at) as createAt, count(store_id) as count " +
			"from stores " +
			"where year(create_at) = year(GETDATE()) " +
			"group by month(create_at)" , nativeQuery = true
			)
	List<IStoreCount> countStoreByMonth();
	
	@Query(value = 
			"select year(create_at) as createAt, count(store_id) as count " +
			"from stores " +
			"group by year(create_at)" , nativeQuery = true
			)
	List<IStoreCount> countStoreByYear();

}
