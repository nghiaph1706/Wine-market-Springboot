package com.ps17855.controller;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.thymeleaf.context.Context;

import com.ps17855.dao.BrandDAO;
import com.ps17855.dao.CartDAO;
import com.ps17855.dao.CategoryDAO;
import com.ps17855.dao.MessageSPDAO;
import com.ps17855.dao.OrderDAO;
import com.ps17855.dao.ProductDAO;
import com.ps17855.dao.TodoDAO;
import com.ps17855.dao.UserDAO;
import com.ps17855.dao.VoucherDAO;
import com.ps17855.entity.Brand;
import com.ps17855.entity.Cart;
import com.ps17855.entity.Category;
import com.ps17855.entity.MessageSP;
import com.ps17855.entity.Order;
import com.ps17855.entity.Product;
import com.ps17855.entity.Todo;
import com.ps17855.entity.User;
import com.ps17855.entity.Voucher;
import com.ps17855.service.AccountService;
import com.ps17855.service.EmailService;
import com.ps17855.service.ParamService;
import com.ps17855.service.SessionService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	UserDAO userDAO;

	@Autowired
	MessageSPDAO messageSPDAO;

	@Autowired
	BrandDAO brandDAO;

	@Autowired
	CategoryDAO categoryDAO;

	@Autowired
	ProductDAO productDAO;

	@Autowired
	OrderDAO orderDAO;

	@Autowired
	TodoDAO todoDAO;

	@Autowired
	VoucherDAO voucherDAO;

	@Autowired
	CartDAO cartDAO;

	@Autowired
	SessionService sessionService;

	@Autowired
	ParamService paramService;

	@Autowired
	EmailService emailService;

	@Autowired
	AccountService accountService;

	private Product productRe = new Product();

	private Voucher voucherRe = new Voucher();

	private Order orderRe = new Order();

	private User userRe = new User();

	private List<Cart> cartOrder;

	private List<Product> products;

	private List<Order> orders;

	private List<Voucher> vouchers;

	private Integer brandKey = null;

	private Integer categoryKey = null;

	@RequestMapping("/index")
	public String index1(Model model) {
		start(model);
		List<MessageSP> messageSPs = messageSPDAO.findAll();
		model.addAttribute("messageSPs", messageSPs);
		List<Todo> todos = todoDAO.findAll();
		model.addAttribute("todos", todos);

		model.addAttribute("orders", orders);
		try {
			model.addAttribute("todaySale", orderDAO.todaySale());
			model.addAttribute("monthSale", orderDAO.monthSale());
		} catch (Exception e) {
			model.addAttribute("todaySale", 0);
			model.addAttribute("monthSale", 0);
		}
		products = productDAO.findAll();
		Sort sort = Sort.by(Direction.DESC, "id");
		orders = orderDAO.getOrders(sort);
		vouchers = voucherDAO.findAll();
		return "admin/index";
	}

	@PostMapping("/addTodo")
	public String addTodo() {
		String task = paramService.getString("Task", "");
		Todo todo = new Todo();
		todo.setContent(task);
		todoDAO.save(todo);
		return "redirect:/admin/index";
	}

	@RequestMapping("/removeTodo")
	public String removeTodo(@RequestParam("id") Integer id) {
		todoDAO.deleteById(id);
		return "redirect:/admin/index";
	}

	@RequestMapping("/product")
	public String product(Model model) {
		start(model);
		startProduct(model);
		return "admin/product";
	}

	@RequestMapping("/productSearch")
	public String productSearch(@RequestParam("keyword") String keyword) {
		products = productDAO.findAllByKeyword(keyword);
		return "redirect:/admin/product";
	}

	@PostMapping("/productSearch")
	public String productSearch1() {
		brandKey = paramService.getInt("Brand", -1);
		categoryKey = paramService.getInt("Category", -1);
		products = productDAO.filter(brandKey, categoryKey);
		return "redirect:/admin/product";
	}

	@RequestMapping("/editProduct")
	public String editProduct(@RequestParam("id") Integer id, Model model) {
		productRe = productDAO.getById(id);
		start(model);
		startProduct(model);
		model.addAttribute("product", productRe);
		model.addAttribute("seBrand", productRe.getBrand().getId());
		model.addAttribute("seCate", productRe.getCategory().getId());
		products = productDAO.findAll();
		return "/admin/product";
	}

	@RequestMapping("/updateProduct")
	public String updateProduct(@RequestParam("attach") MultipartFile attach) {
		String path = "assets/img/product/";
		String name = paramService.getString("Name", "");
		Integer id = paramService.getInt("Id", -1);
		Integer brand = paramService.getInt("Brand", -1);
		Integer category = paramService.getInt("Category", -1);
		double price = paramService.getDouble("Price", -1);
		String image = attach.getOriginalFilename();

		Product product = new Product();
		product.setId(id);
		product.setName(name);
		product.setPrice(price);
		product.setBrand(brandDAO.getById(brand));
		product.setCategory(categoryDAO.getById(category));
		if (image.length() > 0) {
			product.setImage(image);
			paramService.save(attach, path);
		} else {
			product.setImage(productDAO.getById(id).getImage());
		}
		productDAO.save(product);
		products = productDAO.findAll();
		return "redirect:/admin/product";
	}

	@PostMapping("/addProduct")
	public String addProduct(@RequestParam("attach") MultipartFile attach) {
		String path = "assets/img/product/";
		String name = paramService.getString("Name", "");
		Integer brand = paramService.getInt("Brand", -1);
		Integer category = paramService.getInt("Category", -1);
		double price = paramService.getDouble("Price", -1);
		String image = attach.getOriginalFilename();

		Product product = new Product();
		product.setName(name);
		product.setPrice(price);
		product.setBrand(brandDAO.getById(brand));
		product.setCategory(categoryDAO.getById(category));
		if (image.length() > 0) {
			product.setImage(image);
			paramService.save(attach, path);
		} else {
			product.setImage("null.png");
		}
		productDAO.save(product);
		products = productDAO.findAll();
		return "redirect:/admin/product";
	}

	@RequestMapping("/removeProduct")
	public String removeProduct(@RequestParam("id") Integer id) {
		productDAO.deleteById(id);
		products = productDAO.findAll();
		return "redirect:/admin/product";
	}

	@RequestMapping("/user")
	public String user(Model model) {
		start(model);
		startUser(model);
		return "admin/user";
	}

	@RequestMapping("/updateUser")
	public String updateUser(@RequestParam("attach") MultipartFile attach, @RequestParam("role") String role) {
		String path = "assets/img/user/";
		String un = paramService.getString("Username", "");
		Integer id = paramService.getInt("Id", -1);
		String em = paramService.getString("Email", "");
		Boolean ro = role.equals("Admin") ? true : false;
		String image = attach.getOriginalFilename();
		String pw = userDAO.getById(id).getPassword();
		User user = new User();
		user.setId(id);
		user.setUsername(un);
		user.setEmail(em);
		user.setRole(ro);
		user.setPassword(pw);
		System.out.println(image);
		if (image.length() > 0) {
			user.setImage(image);
			paramService.save(attach, path);
		} else {
			user.setImage(userDAO.getById(id).getImage());
		}
		userDAO.save(user);
		return "redirect:/admin/user";
	}

	@RequestMapping("/addUser")
	public String addUser(@RequestParam("attach") MultipartFile attach, @RequestParam("role") String role) {
		String path = "assets/img/user/";
		String un = paramService.getString("Username", "");
		String em = paramService.getString("Email", "");
		Boolean ro = role.equals("Admin") ? true : false;
		String image = attach.getOriginalFilename();
		User user = new User();
		user.setUsername(un);
		user.setEmail(em);
		user.setRole(ro);
		user.setPassword("123");
		if (image.length() > 0) {
			user.setImage(image);
			paramService.save(attach, path);
		} else {
			user.setImage("null.png");
		}
		userDAO.save(user);
		return "redirect:/admin/user";
	}

	@RequestMapping("/editUser")
	public String editUser(@RequestParam("id") Integer id, Model model) {
		userRe = userDAO.getById(id);
		start(model);
		startUser(model);
		model.addAttribute("user", userRe);
		return "/admin/user";
	}

	@RequestMapping("/removeUser")
	public String removeUser(@RequestParam("id") Integer id, Model model) {
		userDAO.deleteById(id);
		return "redirect:/admin/user";
	}

	@RequestMapping("/message")
	public String message(Model model) {
		start(model);
		startMess(model);
		return "admin/message";
	}

	@PostMapping("/replySupport")
	public String replySupport() throws UnsupportedEncodingException, MessagingException {
		Integer id = paramService.getInt("Id", -1);
		String subject = paramService.getString("Subject", "");
		String mess = paramService.getString("Message", "");
		String email = messageSPDAO.getById(id).getEmail();

		Context context = new Context();
		context.setVariable("mainTitle", subject);
		context.setVariable("secondTitle", mess);
		emailService.sendMail(email, subject, "sub", context);

		messageSPDAO.deleteById(id);
		return "redirect:/admin/message";
	}

	@RequestMapping("/editMessage")
	public String editMessage(@RequestParam("id") Integer id, Model model) {
		MessageSP messageSP = messageSPDAO.getById(id);
		start(model);
		startMess(model);
		model.addAttribute("message", messageSP);
		return "/admin/message";
	}

	@RequestMapping("/removeMessage")
	public String removeMessage(@RequestParam("id") Integer id, Model model) {
		messageSPDAO.deleteById(id);
		return "redirect:/admin/message";
	}

	@RequestMapping("/order")
	public String order(Model model) {
		start(model);
		startOrder(model);
		return "admin/order";
	}

	@PostMapping("/orderSearch")
	public String orderSearch() {
		String status = paramService.getString("Status", "");
		orders = status.equals("0") ? orderDAO.getOrders() : orderDAO.findByStatusLike(status);
		return "redirect:/admin/order";
	}

	@RequestMapping("/orderSort")
	public String orderSort(@RequestParam("by") String by) {
		if (by.equals("DESC")) {
			Sort sort = Sort.by(Direction.DESC, "id");
			orders = orderDAO.getOrders(sort);
		} else {
			Sort sort = Sort.by(Direction.ASC, "id");
			orders = orderDAO.getOrders(sort);
		}
		return "redirect:/admin/order";
	}

	@RequestMapping("/orderUpdate")
	public String orderUpdate(@RequestParam("id") Integer id, @RequestParam("action") String action)
			throws UnsupportedEncodingException, MessagingException {
		Order order = orderDAO.getById(id);
		String email = userDAO.findByUsername(sessionService.get("username")).getEmail();
		if (action.equals("pending")) {
			order.setStatus("Pending");
			orderDAO.save(order);
			Context context = new Context();
			context.setVariable("status", "pending");
			emailService.sendMail(email, "Your order is pending", "order", context);
		} else if (action.equals("delivering")) {
			order.setStatus("Delivering");
			orderDAO.save(order);
			Context context = new Context();
			context.setVariable("status", "delivering");
			emailService.sendMail(email, "Your order is delivering", "order", context);
		} else if (action.equals("done")) {
			order.setStatus("Done");
			orderDAO.save(order);
			Context context = new Context();
			context.setVariable("status", "done");
			emailService.sendMail(email, "Your order is done", "order", context);
		} else if (action.equals("view")) {
			orderRe = order;
			cartOrder = cartDAO.findOrder(userDAO.findByUsername(order.getUser().getUsername()).getId());
		} else {
			order.setHide(true);
			orderDAO.save(order);
			cartDAO.deleteCartOrder(userDAO.findByUsername(order.getUser().getUsername()).getId());
			orderRe = new Order();
			try {
				cartOrder.clear();
			} catch (Exception e) {
				// TODO: handle exception
			}
		}

		orders = orderDAO.getOrders();

		return "redirect:/admin/order";
	}

	@RequestMapping("/voucher")
	public String voucher(Model model) {
		start(model);
		startVoucher(model);
		return "admin/voucher";
	}

	@RequestMapping("/editVoucher")
	public String editProduct(@RequestParam("id") String id, Model model) {
		voucherRe = voucherDAO.getById(id);
		start(model);
		startVoucher(model);
		model.addAttribute("voucher", voucherRe);
		vouchers = voucherDAO.findAll();
		return "/admin/voucher";
	}

	@RequestMapping("/updateVoucher")
	public String updateProduct() throws ParseException {
		String id = paramService.getString("Id", "");
		String content = paramService.getString("Content", "");
		double discount = paramService.getDouble("Discount", -1);
		LocalDate start = paramService.getDate("Start", "");
		LocalDate end = paramService.getDate("End", "");

		Voucher voucher = new Voucher();
		voucher.setId(id);
		voucher.setContent(content);
		voucher.setDiscount(discount);
		voucher.setStart(start);
		voucher.setEnd(end);

		voucherDAO.save(voucher);
		vouchers = voucherDAO.findAll();
		return "redirect:/admin/voucher";
	}

	@PostMapping("/addVoucher")
	public String addVoucher(@RequestParam(value = "Start") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
			@RequestParam(value = "End") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate)
			throws ParseException {
		String id = paramService.getString("Id", "");
		String content = paramService.getString("Content", "");
		double discount = paramService.getDouble("Discount", -1);
		LocalDate start = paramService.getDate("Start", "");
		LocalDate end = paramService.getDate("End", "");

		Voucher voucher = new Voucher();
		voucher.setId(id);
		voucher.setContent(content);
		voucher.setDiscount(discount);
		voucher.setStart(start);
		voucher.setEnd(end);

		voucherDAO.save(voucher);

		vouchers = voucherDAO.findAll();
		return "redirect:/admin/voucher";
	}

	@RequestMapping("/removeVoucher")
	public String removeVoucher(@RequestParam("id") String id) {
		voucherDAO.deleteById(id);
		vouchers = voucherDAO.findAll();
		return "redirect:/admin/voucher";
	}

	@RequestMapping("/sendVoucher")
	public String sendVoucher(@RequestParam("id") String id) throws UnsupportedEncodingException, MessagingException {
		List<User> users = userDAO.findAll();
		Voucher voucher = voucherDAO.getById(id);
		Context context = new Context();
		context.setVariable("content", voucher.getContent());
		context.setVariable("discount", voucher.getDiscount());
		for (User user : users) {
			emailService.sendMail(user.getEmail(), "Join us for a new event", "voucher", context);
		}
		return "redirect:/admin/voucher";
	}

	public void start(Model model) {
		User admin = userDAO.findByUsername(sessionService.get("username"));
		model.addAttribute("admin", admin);
		Product product = new Product();
		product.setImage("null.png");
		model.addAttribute("product", product);
		User user = new User();
		user.setImage("null.png");
		model.addAttribute("user", user);
		model.addAttribute("messageCount", messageSPDAO.count());
		model.addAttribute("orderCount", orderDAO.countByHideIs(false));
	}

	public void startProduct(Model model) {
		List<Brand> brands = brandDAO.findAll();
		List<Category> categories = categoryDAO.findAll();
		model.addAttribute("products", products);
		model.addAttribute("categories", categories);
		model.addAttribute("brands", brands);
	}

	public void startUser(Model model) {
		List<User> users = userDAO.findAll();
		model.addAttribute("users", users);
	}

	public void startMess(Model model) {
		List<MessageSP> messageSPs = messageSPDAO.findAll();
		model.addAttribute("messageSPs", messageSPs);
	}

	public void startOrder(Model model) {
		model.addAttribute("orders", orders);
		List<String> statusList = new ArrayList<String>();
		statusList.add("Pending");
		statusList.add("Delivering");
		statusList.add("Done");
		model.addAttribute("statusList", statusList);
		model.addAttribute("item", orderRe);
		model.addAttribute("carts", cartOrder);
	}

	public void startVoucher(Model model) {
		model.addAttribute("vouchers", vouchers);
	}
}
