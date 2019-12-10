package com.example.demo.service;

import com.example.demo.model.CandidatesModel;

public interface CandidateService {
	void save(CandidatesModel candidates);

	String get();

	CandidatesModel get(int id);

	void delete(int id);
}
