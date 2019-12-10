package com.example.demo.Dao;

import java.util.List;

import com.example.demo.model.Employee;


public interface EmployeeDAO {

	String get();
	
	Employee get(int id);
	
	void save(Employee employee);
	
	void delete(int id);
}
