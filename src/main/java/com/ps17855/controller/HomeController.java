package com.ps17855.controller;

import java.io.UnsupportedEncodingException;
import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.thymeleaf.context.Context;

import com.ps17855.dao.MessageSPDAO;
import com.ps17855.dao.ProductDAO;
import com.ps17855.entity.MessageSP;
import com.ps17855.entity.Product;
import com.ps17855.service.AccountService;
import com.ps17855.service.CookieService;
import com.ps17855.service.EmailService;
import com.ps17855.service.ParamService;
import com.ps17855.service.SessionService;

@Controller
public class HomeController {
	@Autowired
	ProductDAO productDAO;

	@Autowired
	MessageSPDAO messageSPDAO;

	@Autowired
	SessionService sessionService;

	@Autowired
	CookieService cookieService;

	@Autowired
	AccountService accountService;

	@Autowired
	EmailService emailService;

	@Autowired
	ParamService paramService;

	@RequestMapping("/index")
	public String index(Model model) {
		Product product = new Product();
		model.addAttribute("product", product);
		Pageable pageable = PageRequest.of(0, 6);
		Page<Product> products = productDAO.findAll(pageable);
		model.addAttribute("products", products);

		if (accountService.checkLogin()) {
			String unss = sessionService.get("username");
			if (unss == null || unss.equals("")) {
				String unck = cookieService.getValue("user", "");
				sessionService.set("username", unck);
			}
		}
		return "index";
	}

	@RequestMapping("/about")
	public String about() {
		return "about";
	}

	@RequestMapping("/contact")
	public String contact() {
		return "contact";
	}

	@PostMapping("/contact/support")
	public String support() throws UnsupportedEncodingException, MessagingException {
		String name = paramService.getString("name", "");
		String email = paramService.getString("email", "");
		String subject = paramService.getString("subject", "");
		String message = paramService.getString("message", "");
		MessageSP messageSP = new MessageSP();
		messageSP.setName(name);
		messageSP.setEmail(email);
		messageSP.setSubject(subject);
		messageSP.setMessage(message);

		messageSPDAO.save(messageSP);

		Context context = new Context();
		context.setVariable("mainTitle", "Thanks for contact.");
		context.setVariable("secondTitle", "We will reply soon.");
		emailService.sendMail(email, "Thanks for contact.", "sub", context);

		return "contact";
	}

	@PostMapping("/subscribe")
	public String subscribe() throws UnsupportedEncodingException, MessagingException {
		String email = paramService.getString("Email", "");
		Context context = new Context();
		context.setVariable("mainTitle", "Thanks for subscribe.");
		context.setVariable("secondTitle", "We will reply soon.");
		emailService.sendMail(email, "Thanks for subscribe.", "sub", context);
		return "index";
	}
}
