package com.example.demo.Dao;

import com.example.demo.model.CandidatesModel;

public interface CandidateDao {

	void save(CandidatesModel employee);

	String get();

	 CandidatesModel get(int id) ;

	void delete(int id);

}
