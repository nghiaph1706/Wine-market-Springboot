package com.ps17855.dao;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.ps17855.entity.Order;

public interface OrderDAO extends JpaRepository<Order, Integer> {
	@Query("SELECT SUM(o.total) FROM Order o WHERE CONVERT(date,o.dateOrder) = CONVERT(date,GETDATE())  ")
	double todaySale();
	
	@Query("SELECT SUM(o.total) FROM Order o WHERE MONTH(o.dateOrder) = MONTH(GETDATE())")
	double monthSale();
	
	@Query("SELECT o FROM Order o WHERE o.hide = 0")
	List<Order> getOrders();
	
	@Query("SELECT o FROM Order o WHERE o.hide = 0")
	List<Order> getOrders(Sort sort);

	@Query("SELECT o FROM Order o WHERE o.hide = 0 and o.status like ?1 ")
	List<Order> findByStatusLike(String status);
	
	Integer countByHideIs(boolean hide);
	
	
}
