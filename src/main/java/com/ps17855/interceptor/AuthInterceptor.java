package com.ps17855.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.ps17855.dao.UserDAO;
import com.ps17855.entity.User;
import com.ps17855.service.SessionService;

@Service
public class AuthInterceptor implements HandlerInterceptor {
	@Autowired
	SessionService session;
	
	@Autowired
	UserDAO userDAO;

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String uri = request.getRequestURI();
		User user = userDAO.findByUsername(session.get("username"));
		
		try {
			if (user == null) {
				response.sendRedirect("/account/login");
			} else if (!user.isRole() && uri.startsWith("/admin/")) {
				response.sendRedirect("/index");
			}
		} catch (Exception e) {
			response.sendRedirect("/account/login");
		}
		return true;
	}
}
