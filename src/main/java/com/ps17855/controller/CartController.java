package com.ps17855.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ps17855.dao.CartDAO;
import com.ps17855.dao.OrderDAO;
import com.ps17855.dao.ProductDAO;
import com.ps17855.dao.UserDAO;
import com.ps17855.dao.VoucherDAO;
import com.ps17855.entity.Cart;
import com.ps17855.entity.Order;
import com.ps17855.entity.User;
import com.ps17855.entity.Voucher;
import com.ps17855.service.AccountService;
import com.ps17855.service.ParamService;
import com.ps17855.service.SessionService;

@Controller
@RequestMapping("/cart")
public class CartController {

	@Autowired
	AccountService accountService;

	@Autowired
	SessionService sessionService;

	@Autowired
	ParamService paramService;

	@Autowired
	UserDAO userDAO;

	@Autowired
	ProductDAO productDAO;

	@Autowired
	CartDAO cartDAO;

	@Autowired
	OrderDAO orderDAO;

	@Autowired
	VoucherDAO voucherDAO;

	private double discount = 0;

	private String message = "";

	@RequestMapping
	public String cart(Model model) {
		if (!accountService.checkLogin()) {
			return "redirect:/account/login";
		} else {
			String username = sessionService.get("username");
			User user = userDAO.findByUsername(username);

			List<Cart> carts = cartDAO.findByUserId(user.getId());

			double subtotal = 0;
			for (Cart cart : carts) {
				subtotal += cart.getQuantity() * cart.getProduct().getPrice();
			}

			double discountprice = subtotal * (discount > 0 ? discount / 100 : 0);

			double total = subtotal - discountprice + 10;

			model.addAttribute("carts", carts);
			model.addAttribute("subtotal", subtotal);
			model.addAttribute("total", total);
			model.addAttribute("discount", discount);
			model.addAttribute("message", message);
			return "cart";
		}
	}

	@PostMapping("/add")
	public String cartAdd() {
		Integer productId = paramService.getInt("ProductId", 0);
		Integer quantity = paramService.getInt("Quantity", 0);
		if (accountService.checkLogin()) {
			Cart cart = cartDAO.findByProductId(productId,
					userDAO.findByUsername(sessionService.get("username")).getId());
			if (cart == null) {
				cart = new Cart();
				cart.setQuantity(quantity);
				cart.setProduct(productDAO.getById(productId));
				cart.setUser(userDAO.findByUsername(sessionService.get("username")));
				cart.setHide(false);
			} else {
				cart.setQuantity(cart.getQuantity() + quantity);
			}
			cartDAO.save(cart);
			return "redirect:/product/details?productId=" + productId + "&quantity=" + quantity;
		} else {
			return "redirect:/account/login";
		}
	}

	@RequestMapping("/update/decrement")
	public String decrement(Model model, @RequestParam("cartId") Integer cartId) {
		Cart cart = cartDAO.getById(cartId);
		cart.setQuantity(cart.getQuantity() - 1);
		if (cart.getQuantity() == 0) {
			cartDAO.delete(cart);
		} else {
			cartDAO.save(cart);
		}
		return "redirect:/cart";
	}

	@RequestMapping("/update/increment")
	public String increment(Model model, @RequestParam("cartId") Integer cartId) {
		Cart cart = cartDAO.getById(cartId);
		cart.setQuantity(cart.getQuantity() + 1);
		if (cart.getQuantity() == 0) {
			cartDAO.delete(cart);
		} else {
			cartDAO.save(cart);
		}
		return "redirect:/cart";
	}

	@RequestMapping("/voucher")
	public String voucher(@RequestParam("discount") Optional<String> id) {
		String voucherId = id.orElse("");
		if (voucherId.length() > 0) {
			try {
				Voucher voucher = voucherDAO.getById(voucherId);
				LocalDate now = LocalDate.now();
				if (now.compareTo(voucher.getStart()) >= 0 && now.compareTo(voucher.getEnd()) <= 0) {
					discount = voucher.getDiscount();
				} else {
					message = "Invalid voucher.";
				}
			} catch (Exception e) {
				message = "Invalid voucher.";
			}
		} else {
			message = "Invalid voucher.";
		}
		return "redirect:/cart";
	}

	@RequestMapping("/checkout")
	public String checkOut(@RequestParam("total") double total) {
		Order order = new Order();
		User user = userDAO.findByUsername(sessionService.get("username"));
		order.setUser(user);
		order.setTotal(total);
		order.setStatus("Pending");
		order.setHide(false);
		orderDAO.save(order);
		hideCart();
		return "redirect:/cart";
	}

	public void hideCart() {
		String username = sessionService.get("username");
		User user = userDAO.findByUsername(username);

		List<Cart> carts = cartDAO.findByUserId(user.getId());

		for (Cart cart : carts) {
			cart.setHide(true);
			cartDAO.save(cart);
		}
	}
}
