package vn.book.Repository;


import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import vn.book.DTO.IStoreCount;
import vn.book.Entity.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
	User findByUsername(String username);
	User findByEmail(String email);
	public User findByResetPasswordToken(String token);
	//public User updatUser(User user);
	List<User> findByUsernameContaining(String name);
	Page<User> findByUsernameContaining(String name, Pageable pageable);
	
	@Query(value = 
			"select day(create_at) as createAt , count(user_id) as count " +
			"from users " +
			"where month(create_at) = month(GETDATE()) and year(create_at) = year(GETDATE()) " +
			"group by day(create_at)" , nativeQuery = true
			)
	List<IStoreCount> countUserByDate();
	
	@Query(value = 
			"select month(create_at) as createAt, count(user_id) as count " +
			"from users " +
			"where year(create_at) = year(GETDATE()) " +
			"group by month(create_at)" , nativeQuery = true
			)
	List<IStoreCount> countUserByMonth();
	
	@Query(value = 
			"select year(create_at) as createAt, count(user_id) as count " +
			"from users " +
			"group by year(create_at)" , nativeQuery = true
			)
	List<IStoreCount> countUserByYear();
}	
