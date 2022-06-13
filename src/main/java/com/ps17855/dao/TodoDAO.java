package com.ps17855.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ps17855.entity.Todo;

public interface TodoDAO extends JpaRepository<Todo, Integer> {

}
