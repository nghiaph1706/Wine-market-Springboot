package com.ps17855.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.ps17855.entity.Category;

@Repository
public interface CategoryDAO extends JpaRepository<Category, Integer> {

}
