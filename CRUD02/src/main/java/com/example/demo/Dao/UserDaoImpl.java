package com.example.demo.Dao;

import java.util.List;

import javax.persistence.EntityManager;

import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.model.CandidatesModel;
import com.example.demo.model.UserModel;
import com.google.gson.Gson;
@Repository
public class UserDaoImpl implements UserDao {
	@Autowired
	private EntityManager entityManager;
	
	 
	@Override
	public void saveDetails(UserModel user) {
		Session currentSession = entityManager.unwrap(Session.class);
		currentSession.saveOrUpdate(user);
	}
	@Override
	public String getDetails() {
		Session currentSession = entityManager.unwrap(Session.class);
		//Initially it set value in model class then we are fetching it 
		Query<UserModel> query = currentSession.createQuery("from UserModel", UserModel.class);
		List<UserModel> list = query.getResultList();
		String json = new Gson().toJson(list);
		System.out.println("USer"+json);
		return json;
	}
	
}
