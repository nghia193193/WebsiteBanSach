package vn.book.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import vn.book.Entity.Category;

public interface ICategoryService {

	void deleteById(Long id);

	long count();

	boolean existsById(Long id);

	Optional<Category> findById(Long id);

	List<Category> findAll();

	<S extends Category> S save(S entity);

	List<Category> findByDeleteFalse();

	Page<Category> findAll(Pageable pageable);

	Page<Category> findByCategoryNameContaining(String name, Pageable pageable);

	List<Category> findByCategoryNameContaining(String name);

}
