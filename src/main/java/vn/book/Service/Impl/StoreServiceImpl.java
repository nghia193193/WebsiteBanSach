package vn.book.Service.Impl;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import vn.book.DTO.IStoreCount;
import vn.book.Entity.Book;
import vn.book.Repository.StoreRepository;
import vn.book.Service.IStoreService;

import vn.book.Entity.Store;
import vn.book.Entity.User;

@Service
public class StoreServiceImpl implements IStoreService{
	@Autowired
	StoreRepository storeRepo;

	public StoreServiceImpl(StoreRepository storeRepo) {
		this.storeRepo = storeRepo;
	}//

	@Override
	public <S extends Store> S save(S entity) {
		if(entity.getStoreId() != null) {
			Optional<Store> opt = findById(entity.getStoreId());
			Date date = new Date(System.currentTimeMillis()); 
			if(opt.isPresent()) {
				if(StringUtils.isEmpty(entity.getAvatar())) {
					entity.setAvatar(opt.get().getAvatar());
				}else {
					entity.setAvatar(entity.getAvatar());
				}
				entity.setOpen(opt.get().isOpen());
				entity.setCreateAt(opt.get().getCreateAt());
				entity.setUpdateAt(date);
			}
		}
		else {
			Date date = new Date(System.currentTimeMillis()); 
			entity.setCreateAt(date);
		}
		
		return storeRepo.save(entity);
	}//

	@Override
	public List<Store> findAll() {
		return storeRepo.findAll();
	}//

	@Override
	public Optional<Store> findById(Long id) {
		return storeRepo.findById(id);
	}//

	@Override
	public <S extends Store> boolean exists(Example<S> example) {
		return storeRepo.exists(example);
	}//

	@Override
	public long count() {
		return storeRepo.count();
	}//

	@Override
	public void deleteById(Long id) {
		storeRepo.deleteById(id);
	}//

	@Override
	public Store findByOwner(User owner) {
		return storeRepo.findByOwner(owner);
	}

	@Override
	public List<Store> findByStoreNameContaining(String name) {
		return storeRepo.findByStoreNameContaining(name);
	}

	@Override
	public Page<Store> findByStoreNameContaining(String name, Pageable pageable) {
		return storeRepo.findByStoreNameContaining(name, pageable);
	}

	
	

	@Override
	public void delete(Store entity) {
		// TODO Auto-generated method stub
		storeRepo.delete(entity);
	}


	@Override
	public boolean existsById(Long id) {
		// TODO Auto-generated method stub
		return storeRepo.existsById(id);
	}
	
	@Transactional
    public void addClient(Store store1){
        storeRepo.saveAndFlush(store1);
    }


	@Override
	public List<Store> findAllById(Iterable<Long> ids) {
		// TODO Auto-generated method stub
		return storeRepo.findAllById(ids);
	}

	@Override
	public List<Store> findAll(Sort sort) {
		// TODO Auto-generated method stub
		return storeRepo.findAll(sort);
	}

	@Override
	public Page<Store> findAll(Pageable pageable) {
		// TODO Auto-generated method stub
		return storeRepo.findAll(pageable);
	}



	@Override
	public List<Store> findBystoreNameContaining(String name) {
		// TODO Auto-generated method stub
		return storeRepo.findBystoreNameContaining(name);
	}

	@Override
	public Page<Store> findBystoreNameContaining(String name, Pageable p) {
		// TODO Auto-generated method stub
		return storeRepo.findBystoreNameContaining(name, p);
	}

	@Override
	public List<IStoreCount> countStoreByDate() {
		return storeRepo.countStoreByDate();
	}

	@Override
	public List<IStoreCount> countStoreByMonth() {
		// TODO Auto-generated method stub
		return storeRepo.countStoreByMonth();
	}

	@Override
	public List<IStoreCount> countStoreByYear() {
		// TODO Auto-generated method stub
		return storeRepo.countStoreByYear();
	}

}
