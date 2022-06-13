package com.ps17855.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.ps17855.entity.Product;

public interface ProductDAO extends JpaRepository<Product, Integer>{
	
	@Query("SELECT p FROM Product p WHERE p.name like %?1%")
	Page<Product> findAllByNameLike(String keywords, Pageable pageable);
	
	@Query("SELECT p FROM Product p WHERE p.category.id = ?1")
	Page<Product> findByCategoryId(Integer categoryId, Pageable pageable);
	
	@Query("SELECT p FROM Product p WHERE p.brand.id = ?1")
	Page<Product> findByBrandId(Integer brandId, Pageable pageable);
	
	@Query("SELECT p FROM Product p WHERE p.name like %?1%")
	List<Product> findAllByKeyword(String keywords);
	
	@Query("SELECT p FROM Product p WHERE p.brand.id = ?1 or p.category.id = ?2")
	List<Product> filter(Integer brandId, Integer categoryId);
	
}
