package com.example.demo.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Dao.EmployeeDAO;
import com.example.demo.model.Employee;

@Service
public class EmployeeServiceImpl implements EmployeeService {
 
	@Autowired
	private EmployeeDAO employeeDAO;
	
	@Transactional
	@Override
	public String get() {
		return employeeDAO.get();
	}
 
	@Transactional
	@Override
	public Employee get(int id) {
		return employeeDAO.get(id);
	}
 
	@Transactional
	@Override
	public void save(Employee employee) {
		employeeDAO.save(employee);
	}
 
	@Transactional
	@Override
	public void delete(int id) {
		employeeDAO.delete(id);
	}
 
}