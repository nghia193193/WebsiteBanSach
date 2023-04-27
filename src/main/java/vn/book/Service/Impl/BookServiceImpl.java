package vn.book.Service.Impl;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import vn.book.Entity.Book;
import vn.book.Entity.Store;
import vn.book.Repository.BookRepository;
import vn.book.Service.IBookService;

@Service
public class BookServiceImpl implements IBookService {
	@Override
	public Page<Book> findBybookNameContaining(String name, Pageable p) {
		// TODO Auto-generated method stub
		return bookRepo.findBybookNameContaining(name, p);
	}
	@Override
	public List<Book> findBybookNameContaining(String name) {
		// TODO Auto-generated method stub
		return bookRepo.findBybookNameContaining(name);
	}

	@Autowired
	BookRepository bookRepo;

	public BookServiceImpl(BookRepository bookRepo) {
		this.bookRepo = bookRepo;
	}
	@Transactional
    public void addClient(Book book){
        bookRepo.saveAndFlush(book);
    }
	@Override
	public <S extends Book> S save(S entity) {
		if(entity.getBookId() != null) {
			Optional<Book> opt = findById(entity.getBookId());
			Date date = new Date(System.currentTimeMillis()); 
			if(opt.isPresent()) {
				if(StringUtils.isEmpty(entity.getImage())) {
					entity.setImage(opt.get().getImage());
				}else {
					entity.setImage(entity.getImage());
				}
				entity.setSold(opt.get().getSold());
				entity.setPromotionalPrice(opt.get().getPromotionalPrice());
				entity.setRating(opt.get().getRating());
				entity.setCreateAt(opt.get().getCreateAt());
				entity.setUpdateAt(date);
			}
		} else {
			Date date = new Date(System.currentTimeMillis()); 
			entity.setCreateAt(date);
		}
		return bookRepo.save(entity);
	}

	@Override
	public List<Book> findAll() {
		return bookRepo.findAll();
	}

	@Override
	public Page<Book> findAll(Pageable pageable) {
		return bookRepo.findAll(pageable);
	}

	@Override
	public List<Book> findAll(Sort sort) {
		return bookRepo.findAll(sort);
	}

	@Override
	public List<Book> findAllById(Iterable<Long> ids) {
		return bookRepo.findAllById(ids);
	}

	@Override
	public Optional<Book> findById(Long id) {
		return bookRepo.findById(id);
	}

	@Override
	public boolean existsById(Long id) {
		return bookRepo.existsById(id);
	}

	@Override
	public long count() {
		return bookRepo.count();
	}

	@Override
	public void deleteById(Long id) {
		bookRepo.deleteById(id);
	}

	@Override
	public void delete(Book entity) {
		bookRepo.delete(entity);
	}

	@Override
	public List<Book> findByStore(Store store) {
		return bookRepo.findByStore(store);
	}

	@Override
	public List<Book> findByStoreAndSellingTrue(Store store) {
		return bookRepo.findByStoreAndSellingTrue(store);
	}

	@Override
	public List<Book> findByStoreAndSellingFalse(Store store) {
		return bookRepo.findByStoreAndSellingFalse(store);
	}

	@Override
	public List<Book> findByBookNameContaining(String name) {
		return bookRepo.findByBookNameContaining(name);
	}

	@Override
	public Page<Book> findByBookNameContaining(String name, Pageable pageable) {
		return bookRepo.findByBookNameContaining(name, pageable);
	}

	@Override
	public Page<Book> findAllByStoreAndCategoryDeleteFalse(Optional<Store> store, Pageable pageable) {
		return bookRepo.findAllByStoreAndCategoryDeleteFalse(store, pageable);
	}

	@Override
	public Page<Book> findAllByStoreAndBookNameContainingAndCategoryDeleteFalse(Optional<Store> store, String name,
			Pageable pageable) {
		return bookRepo.findAllByStoreAndBookNameContainingAndCategoryDeleteFalse(store, name, pageable);
	}

}
