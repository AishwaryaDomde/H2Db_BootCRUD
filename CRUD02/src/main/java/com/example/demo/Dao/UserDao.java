package com.example.demo.Dao;

import com.example.demo.model.UserModel;

public interface UserDao {

	String getDetails();

	void saveDetails(UserModel user);
}
