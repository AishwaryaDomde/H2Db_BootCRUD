package com.example.demo.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Dao.UserDao;
import com.example.demo.model.UserModel;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDao userdao;
	

	@Transactional
	@Override
	public String getDetails() {
		return userdao.getDetails();
	}

	@Transactional
	@Override
	public void saveDetails(UserModel user) {
		System.out.println(user);
		userdao.saveDetails(user);
	}
}
