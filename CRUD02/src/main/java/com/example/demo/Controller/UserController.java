package com.example.demo.Controller;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.UserModel;
import com.example.demo.service.UserService;
@Controller
public class UserController {

	@Autowired
	@Qualifier(value = "UserModel")
	private UserModel usermodel;
	
	@Autowired 
	UserService userService;
	
	@RequestMapping("/SaveDetails")
	public @ResponseBody String saveDetails(Model model, @RequestBody String dataJsonObj) {
		JSONObject obj = new JSONObject(dataJsonObj);
		usermodel.setUser_Email(obj.getString("user_email"));
		usermodel.setUser_first_name(obj.getString("user_first_name"));
		usermodel.setUser_last_name(obj.getString("user_last_name"));
		int id;
		try {
			id=obj.getInt("user_id");
			usermodel.setUser_id(id);
		} catch (Exception e) {
			// TODO: handle exception
		}		
		System.out.println(usermodel+"usermodel");
		userService.saveDetails(usermodel);
		return "home";
	}
}
