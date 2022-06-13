package com.ps17855.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.ps17855.entity.User;

public interface UserDAO extends JpaRepository<User, Integer> {
	
	@Query("SELECT u FROM User u WHERE u.username = ?1")
	User findByUsername(String username);
	
}
