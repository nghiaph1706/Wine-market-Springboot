package com.ps17855.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ps17855.entity.Brand;

@Repository
public interface BrandDAO extends JpaRepository<Brand, Integer> {

}
