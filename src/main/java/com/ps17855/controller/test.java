package com.ps17855.controller;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ps17855.dao.BrandDAO;
import com.ps17855.dao.CartDAO;
import com.ps17855.dao.CategoryDAO;
import com.ps17855.dao.UserDAO;
import com.ps17855.entity.Brand;
import com.ps17855.entity.Cart;
import com.ps17855.entity.Category;
import com.ps17855.entity.User;

@Controller
public class test {
	@Autowired
	CartDAO repo;
	@RequestMapping("/test")
	public String list3(Model model) {
		return "admin/order";
	}
}
