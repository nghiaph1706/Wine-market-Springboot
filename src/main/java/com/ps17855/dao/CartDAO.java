package com.ps17855.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.ps17855.entity.Cart;

@Transactional
public interface CartDAO extends JpaRepository<Cart, Integer> {

	@Query("SELECT c FROM Cart c WHERE c.user.id = ?1 and c.hide = 0")
	List<Cart> findByUserId(Integer userId);
	
	@Query("SELECT c FROM Cart c WHERE c.product.id = ?1 and c.hide = 0 and c.user.id = ?2")
	Cart findByProductId(Integer productId, Integer userId);
	
	@Query("SELECT c FROM Cart c WHERE c.hide = 1 and c.user.id = ?1")
	List<Cart> findOrder(Integer userId);
	
	@Modifying
	@Query("DELETE FROM Cart c WHERE c.hide = 1 and c.user.id = ?1")
	void deleteCartOrder(Integer userId);
}
