package vn.book.Service.Impl;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import vn.book.Entity.Category;
import vn.book.Repository.CategoryRepository;
import vn.book.Service.ICategoryService;

@Service
public class CategoryServiceImpl implements ICategoryService{
	@Autowired
	CategoryRepository cateRepo;

	public CategoryServiceImpl(CategoryRepository cateRepo) {
		this.cateRepo = cateRepo;
	}

	@Override
	public <S extends Category> S save(S entity) {
		if(entity.getCategoryId() != null) {
			Optional<Category> opt = findById(entity.getCategoryId());
			Date date = new Date(System.currentTimeMillis()); 
			if(opt.isPresent()) {
				if(StringUtils.isEmpty(entity.getImage())) {
					entity.setImage(opt.get().getImage());
				}else {
					entity.setImage(entity.getImage());
				}
				entity.setCreateAt(opt.get().getCreateAt());
				entity.setUpdateAt(date);
			}
		}
		else {
			Date date = new Date(System.currentTimeMillis()); 
			entity.setCreateAt(date);
		}
		
		return cateRepo.save(entity);
	}

	@Override
	public List<Category> findAll() {
		return cateRepo.findAll();
	}

	@Override
	public Optional<Category> findById(Long id) {
		return cateRepo.findById(id);
	}

	@Override
	public boolean existsById(Long id) {
		return cateRepo.existsById(id);
	}

	@Override
	public long count() {
		return cateRepo.count();
	}

	@Override
	public void deleteById(Long id) {
		cateRepo.deleteById(id);
	}

	@Override
	public List<Category> findByDeleteFalse() {
		return cateRepo.findByDeleteFalse();
	}

	@Override
	public List<Category> findByCategoryNameContaining(String name) {
		return cateRepo.findByCategoryNameContaining(name);
	}

	@Override
	public Page<Category> findByCategoryNameContaining(String name, Pageable pageable) {
		return cateRepo.findByCategoryNameContaining(name, pageable);
	}

	@Override
	public Page<Category> findAll(Pageable pageable) {
		return cateRepo.findAll(pageable);
	}
	
	
	
}
