package com.ps17855.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.thymeleaf.context.Context;

import com.ps17855.dao.UserDAO;
import com.ps17855.entity.User;
import com.ps17855.service.AccountService;
import com.ps17855.service.CookieService;
import com.ps17855.service.EmailService;
import com.ps17855.service.ParamService;
import com.ps17855.service.SessionService;

@Controller
@RequestMapping("/account")
public class AccountController {

	@Autowired
	ParamService paramService;

	@Autowired
	SessionService sessionService;

	@Autowired
	CookieService cookieService;

	@Autowired
	AccountService accountService;

	@Autowired
	EmailService emailService;

	@Autowired
	UserDAO userDAO;

	private String message = "";
	private User userRe;
	private String code = "";

	@RequestMapping("/login")
	public String indexLogin(Model model) {
		if (!accountService.checkLogin()) {
			model.addAttribute("message", message);
			return "login";
		} else {
			return "redirect:/account/user";
		}
	}

	@PostMapping("/login")
	public String login(Model model) {
		String un = paramService.getString("Username", "");
		String pw = paramService.getString("Password", "");
		boolean rm = paramService.getBoolean("remember", false);
		User user = userDAO.findByUsername(un);
		if (user.getUsername().equals(un) && user.getPassword().equals(DigestUtils.md5Hex(pw))) {
			sessionService.set("username", un);
			if (rm) {
				cookieService.add("user", un, 10);
			}
			if (user.isRole()) {
				message = "";
				return "redirect:/admin/index";
			} else {
				message = "";
				return "redirect:/index";
			}
		} else {
			message = "Login failed.";
			return "redirect:/account/login";
		}
	}

	@RequestMapping("/logout")
	public String logout() {
		sessionService.remove("username");
		cookieService.remove("user");
		return "redirect:/index";
	}

	@RequestMapping("/signup")
	public String indexSignup(Model model) {
		if (message.equals("SignUp success. Please login.")) {
			message = "";
		}
		model.addAttribute("message", message);
		return "signup";
	}

	@PostMapping("/signup")
	public String Signup() {
		String un = paramService.getString("Username", "");
		String em = paramService.getString("Email", "");
		String pw = paramService.getString("Password", "");
		String rpw = paramService.getString("Repassword", "");
		boolean check = true;

		List<User> users = userDAO.findAll();
		for (User user : users) {
			if (un.equals(user.getUsername())) {
				if (em.equals(user.getEmail())) {
					check = false;
					break;
				}
			}
		}

		if (check) {
			if (pw.equals(rpw)) {
				String md5Hex = DigestUtils.md5Hex(rpw.getBytes());
				User user = new User();
				user.setUsername(un);
				user.setEmail(em);
				user.setPassword(md5Hex);
				System.out.println(md5Hex);
				user.setImage("null.png");
				user.setRole(false);
				try {
					userDAO.save(user);
					message = "SignUp success. Please login.";
					return "redirect:/account/login";
				} catch (Exception e) {
					message = "SignUp failed. Please try again.";
					System.out.println(e);
					return "redirect:/account/signup";
				}
			} else {
				message = "SignUp failed. Password and Repassword does not match.";
				return "redirect:/account/signup";
			}
		} else {
			message = "SignUp failed. Username in use. Please try again.";
			return "redirect:/account/signup";
		}
	}

	@RequestMapping("/user")
	public String user(Model model) {
		if (!accountService.checkLogin()) {
			return "redirect:/account/login";
		} else {
			String username = sessionService.get("username");
			User user = userDAO.findByUsername(username);
			model.addAttribute("user", user);
			return "user";
		}
	}

	@RequestMapping("/update")
	public String update(@RequestParam("attach") MultipartFile attach) {
		String path = "assets/img/user/";

		String un = paramService.getString("Username", "");
		String em = paramService.getString("Email", "");
		String pw = userDAO.findByUsername(un).getPassword();
		Integer id = userDAO.findByUsername(un).getId();
		String image = attach.getOriginalFilename();

		User user = new User();
		user.setId(id);
		user.setImage(image);
		String md5Hex = DigestUtils.md5Hex(pw.getBytes());
		user.setPassword(md5Hex);
		user.setUsername(un);
		user.setEmail(em);

		try {
			userDAO.save(user);
			paramService.save(attach, path);
			return "redirect:/account/user";
		} catch (Exception e) {
			return "redirect:/account/update";
		}
	}

	@RequestMapping("/sendcode")
	public String indexSendcode(Model model) {
		model.addAttribute("message", message);
		return "sendcode";
	}

	@RequestMapping("/forgot")
	public String indexForgot(Model model) {
		model.addAttribute("message", message);
		model.addAttribute("user", userRe);
		return "forgot";
	}

	@PostMapping("/forgot")
	public String forgot(Model model) {
		String cd = paramService.getString("Code", "");
		String pw = paramService.getString("Password", "");
		String rpw = paramService.getString("Repassword", "");
		if (cd.equals(code)) {
			if (pw.equals(rpw)) {
				User user = new User();
				user.setId(userRe.getId());
				user.setUsername(userRe.getUsername());
				user.setEmail(userRe.getEmail());
				user.setImage(userRe.getImage());
				String md5Hex = DigestUtils.md5Hex(rpw.getBytes());
				user.setPassword(md5Hex);
				user.setRole(false);
				try {
					userDAO.save(user);
					message = "Change password success. Please login.";
					userRe = new User();
					code = "";
					return "redirect:/account/login";
				} catch (Exception e) {
					message = "Change password failed. Please try again.";
					userRe = new User();
					code = "";
					return "redirect:/account/login";
				}
			} else {
				message = "Change password failed. Password and Repassword does not match.";
				return "redirect:/account/forgot";
			}
		} else {
			message = "Please enter code was send to your email.";
			return "forgot";
		}
	}

	@PostMapping("/sendcode")
	public String forgotSendcode(Model model) throws UnsupportedEncodingException, MessagingException {
		String un = paramService.getString("Username", "");
		String em = paramService.getString("Email", "");
		boolean check = false;

		List<User> users = userDAO.findAll();
		for (User user : users) {
			if (un.equals(user.getUsername()) && em.equals(user.getEmail())) {
				userRe = user;
				check = true;
				break;
			}
		}

		if (check) {
			Random random = new Random();
			for (int i = 1; i <= 6; i++) {
				code += random.nextInt(10);
			}
			Context context = new Context();
			context.setVariable("mainTitle", "Forgot Password Code");
			context.setVariable("secondTitle", code);
			emailService.sendMail(em, "Thanks for subscribe.", "sub", context);
			message = "Please enter code was send to your email.";
			return "redirect:/account/forgot";
		} else {
			message = "Can't find account match Username and Email.";
			return "redirect:/account/sendcode";
		}
	}
}
