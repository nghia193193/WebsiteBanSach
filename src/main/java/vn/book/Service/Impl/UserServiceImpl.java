package vn.book.Service.Impl;


import java.security.Principal;

import java.util.Date;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import vn.book.Config.CustomUserDetails;
import vn.book.DTO.IStoreCount;
import vn.book.Entity.User;
import vn.book.Repository.UserRepository;
import vn.book.Service.CustomerNotFoundException;
import vn.book.Service.IUserService;

@Service
public class UserServiceImpl implements IUserService {
//	@Override
//	public User updateUser(User user) {
//		// TODO Auto-generated method stub
//		return customerRepo.updatUser(user);
//	}
	@Autowired
	private UserRepository customerRepo;
	@Override
	public void updateResetPasswordToken(String token, String email) throws CustomerNotFoundException   {
		User customer = customerRepo.findByEmail(email);
        if (customer != null) {
            customer.setResetPasswordToken(token);
            customerRepo.save(customer);
        } else {
            throw new CustomerNotFoundException("Could not find any customer with the email " + email);
        }
	}

	@Override
	public User getByResetPasswordToken(String token) {
		// TODO Auto-generated method stub
		return customerRepo.findByResetPasswordToken(token);
	}

	@Override
	public void updatePassword(User customer, String newPassword) {
		// TODO Auto-generated method stub
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = passwordEncoder.encode(newPassword);
        customer.setPassword(encodedPassword);
         
        customer.setResetPasswordToken(null);
        customerRepo.save(customer);
	}

	@Autowired
	UserRepository userRepo;

	public UserServiceImpl(UserRepository userRepo) {
		this.userRepo = userRepo;
	}

	@Override
	public <S extends User> S save(S entity) {
		if(entity.getUserId() != null) {
			Optional<User> opt = findById(entity.getUserId());
			Date date = new Date(System.currentTimeMillis()); 
			if(opt.isPresent()) {
				if(StringUtils.isEmpty(entity.getAvatar())) {
					entity.setAvatar(opt.get().getAvatar());
				}else {
					entity.setAvatar(entity.getAvatar());
				}
				entity.setCreateAt(opt.get().getCreateAt());
				entity.setUpdateAt(date);
			}
		} else {
			Date date = new Date(System.currentTimeMillis()); 
			entity.setCreateAt(date);
		}
		return userRepo.save(entity);
	}

	@Override
	public List<User> findAll() {
		return userRepo.findAll();
	}

	@Override
	public Page<User> findAll(Pageable pageable) {
		return userRepo.findAll(pageable);
	}

	@Override
	public List<User> findAll(Sort sort) {
		return userRepo.findAll(sort);
	}

	@Override
	public void deleteById(Long id) {
		userRepo.deleteById(id);
	}

	@Override
	public void deleteAllById(Iterable<? extends Long> ids) {
		userRepo.deleteAllById(ids);
	}

	@Override
	public void deleteAll(Iterable<? extends User> entities) {
		userRepo.deleteAll(entities);
	}

	@Override
	public User findByUsername(String username) {
		return userRepo.findByUsername(username);
	}

	@Override
	public User findByEmail(String email) {
		return userRepo.findByEmail(email);
	}

	@Override
	public Optional<User> findById(Long id) {
		return userRepo.findById(id);
	}

	@Override
	public List<User> findByUsernameContaining(String name) {
		return userRepo.findByUsernameContaining(name);
	}

	@Override
	public Page<User> findByUsernameContaining(String name, Pageable pageable) {
		return userRepo.findByUsernameContaining(name, pageable);
	}

	@Override
	public long count() {
		return userRepo.count();
	}
	

	@Override
	public User getCurrentlyLoggedInUser(Principal principal) {
		String username = principal.getName();
		User userEntity = findByUsername(username);
		
		return userEntity;
	}

	@Override
	public List<IStoreCount> countUserByDate() {
		// TODO Auto-generated method stub
		return userRepo.countUserByDate();
	}

	@Override
	public List<IStoreCount> countUserByMonth() {
		// TODO Auto-generated method stub
		return userRepo.countUserByMonth();
	}

	@Override
	public List<IStoreCount> countUserByYear() {
		// TODO Auto-generated method stub
		return userRepo.countUserByYear();
	}
	
}	
