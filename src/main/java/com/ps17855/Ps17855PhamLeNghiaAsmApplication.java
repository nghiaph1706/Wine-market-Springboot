package com.ps17855;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@SpringBootApplication
@EnableScheduling
public class Ps17855PhamLeNghiaAsmApplication {
	
	@RequestMapping("/")
	@ResponseBody
	public String index1() {
		return "redirect:/index";
	}

	public static void main(String[] args) {
		SpringApplication.run(Ps17855PhamLeNghiaAsmApplication.class, args);
	}

}
