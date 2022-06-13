package com.ps17855.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ps17855.dao.BrandDAO;
import com.ps17855.dao.CategoryDAO;
import com.ps17855.dao.ProductDAO;
import com.ps17855.entity.Brand;
import com.ps17855.entity.Category;
import com.ps17855.entity.Product;
import com.ps17855.service.ParamService;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	ProductDAO productDAO;

	@Autowired
	CategoryDAO categoryDAO;

	@Autowired
	BrandDAO brandDAO;

	@Autowired
	ParamService paramService;
	private String title = "product list";

	@RequestMapping
	public String product() {
		title = "product list";
		return "redirect:/product/page";
	}

	@RequestMapping("/page")
	public String productPage(Model model, @RequestParam("p") Optional<Integer> p) {

		Product product = new Product();
		model.addAttribute("product", product);
		Pageable pageable = PageRequest.of(p.orElse(0), 10);
		Page<Product> page = productDAO.findAll(pageable);
		model.addAttribute("page", page);

		fillLeft(model);

		model.addAttribute("btnLoad", "Load More");
		return "product";
	}

	@RequestMapping("/sort")
	public String productSort(Model model, @RequestParam("p") Optional<Integer> p, @RequestParam("by") String by) {

		Product product = new Product();
		model.addAttribute("product", product);
		Sort sort;
		if (by.equals("name")) {
			sort = Sort.by("name").ascending();
			title = "Sort by Name";
		} else {
			sort = Sort.by("price").ascending();
			title = "Sort by Price";
		}
		Pageable pageable = PageRequest.of(p.orElse(0), 10, sort);
		Page<Product> page = productDAO.findAll(pageable);
		model.addAttribute("page", page);

		fillLeft(model);

		model.addAttribute("btnLoad", "Load More");
		return "product";
	}

	@RequestMapping("/category")
	public String productCategory(Model model, @RequestParam("categoryId") Integer categoryId) {
		Product product = new Product();
		model.addAttribute("product", product);
		Pageable pageable = PageRequest.of(0, 20);
		Page<Product> page = productDAO.findByCategoryId(categoryId, pageable);
		model.addAttribute("page", page);

		Category category = categoryDAO.getById(categoryId);
		title = category.getName();

		fillLeft(model);

		model.addAttribute("btnLoad", "View All");

		return "product";
	}

	@RequestMapping("/brand")
	public String productBrand(Model model, @RequestParam("brandId") Integer brandId) {
		Product product = new Product();
		model.addAttribute("product", product);
		Pageable pageable = PageRequest.of(0, 20);
		Page<Product> page = productDAO.findByBrandId(brandId, pageable);
		model.addAttribute("page", page);

		Brand brand = brandDAO.getById(brandId);
		title = brand.getName();

		fillLeft(model);

		model.addAttribute("btnLoad", "View All");

		return "product";
	}

	@PostMapping("/search")
	public String search(Model model) {
		String keyword = paramService.getString("keyword", "");
		Product product = new Product();
		model.addAttribute("product", product);
		Pageable pageable = PageRequest.of(0, 20);
		Page<Product> page = productDAO.findAllByNameLike(keyword, pageable);
		model.addAttribute("page", page);

		title = "Result for: " + keyword;

		fillLeft(model);

		model.addAttribute("btnLoad", "View All");

		return "product";
	}

	@RequestMapping("/details")
	public String details(Model model, @RequestParam("productId") Integer productId) {
		Product product = productDAO.getById(productId);
		model.addAttribute("product", product);
		model.addAttribute("quantity", 1);
		return "details";
	}

	public void fillLeft(Model model) {
		Category category = new Category();
		model.addAttribute("category", category);
		List<Category> categories = categoryDAO.findAll();
		model.addAttribute("categories", categories);

		Brand brand = new Brand();
		model.addAttribute("brand", brand);
		List<Brand> brands = brandDAO.findAll();
		model.addAttribute("brands", brands);

		model.addAttribute("title", title);
	}
}
