package com.ps17855.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ps17855.dao.UserDAO;

@Service
public class AccountService {

	@Autowired
	SessionService sessionService;

	@Autowired
	CookieService cookieService;

	@Autowired
	UserDAO userDAO;

	public boolean checkLogin() {
		String unss = sessionService.get("username");
		String unck = cookieService.getValue("user", "");
		try {
			if (unss == null && unss.equals("") && unck == null && unck.equals("")) {
				return false;
			} else {
				return true;
			}
		} catch (Exception e) {
			return false;
		}
	}

	public boolean checkAdmin() {
		if (checkLogin()) {
			if (userDAO.findByUsername(sessionService.get("username")).isRole()) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
}
