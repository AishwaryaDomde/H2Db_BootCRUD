package com.example.demo.Dao;


import java.util.List;

import javax.persistence.EntityManager;

import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.model.CandidatesModel;
import com.google.gson.Gson;

@Repository
public class CandidateDaoImpl implements CandidateDao {
	
	@Autowired
	private EntityManager entityManager;
	@Override
	public void save(CandidatesModel employee) {
		Session currentSession = entityManager.unwrap(Session.class);
		currentSession.saveOrUpdate(employee);
	}
	@Override
	public String get() {
		Session currentSession = entityManager.unwrap(Session.class);
		Query<CandidatesModel> query = currentSession.createQuery("from CandidatesModel", CandidatesModel.class);
		List<CandidatesModel> list = query.getResultList();
		String json = new Gson().toJson(list);
		System.out.println("Cand"+json);
		return json;
	}
	@Override
	public CandidatesModel get(int id) {
		Session currentSession = entityManager.unwrap(Session.class);
		CandidatesModel CandidateObj = currentSession.get(CandidatesModel.class, id);
		return CandidateObj;
	}
	@Override
	public void delete(int id) {
		Session curentSess = entityManager.unwrap(Session.class);
		CandidatesModel candidateObj = curentSess.get(CandidatesModel.class, id);
		curentSess.delete(candidateObj);		
	}
	
}
