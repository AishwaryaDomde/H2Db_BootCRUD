package com.example.demo.service;

import com.example.demo.model.UserModel;

public interface UserService {
	String getDetails();
	void saveDetails(UserModel user);
}
