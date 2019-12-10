package com.example.demo.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Dao.CandidateDao;
import com.example.demo.model.CandidatesModel;

@Service
public class CandidateServiceImpl implements CandidateService {
	@Autowired
	private CandidateDao candidate;

	@Transactional
	@Override
	public String get() {
		return candidate.get();
	}

	@Transactional
	@Override
	public void save(CandidatesModel employee) {
		candidate.save(employee);
	}

	@Transactional
	@Override
	public CandidatesModel get(int id) {
		return candidate.get(id);
	}

	@Transactional
	@Override
	public void delete(int id) {
		candidate.delete(id);
	}
 

	
}
