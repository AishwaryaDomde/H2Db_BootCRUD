package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.AlienModel;
import com.example.Dao.AlienDao;

@Controller
public class HomeController {
	@Autowired
	AlienDao aliendao;
	
	@RequestMapping("home")
	public String home() {
		return "home";
	}
	@RequestMapping("addAlien")
	public String addAliens(AlienModel alien) {
		aliendao.save(alien);
		return "home";

	}
}
