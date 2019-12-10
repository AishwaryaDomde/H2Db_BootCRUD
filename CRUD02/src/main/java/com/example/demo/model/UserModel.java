package com.example.demo.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;
@Component(value = "UserModel")
@Entity
@Table(name="USER_LOG")
public class UserModel {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column
	private Integer user_id;
	@Column
	private String user_first_name;
	@Column
	private String user_last_name;
	@Column
	private String user_email;
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public String getUser_first_name() {
		return user_first_name;
	}
	public void setUser_first_name(String user_first_name) {
		this.user_first_name = user_first_name;
	}
	public String getUser_last_name() {
		return user_last_name;
	}
	public void setUser_last_name(String user_last_name) {
		this.user_last_name = user_last_name;
	}
	public String getEmail() {
		return user_email;
	}
	public void setUser_Email(String email) {
		this.user_email = email;
	}
	@Override
	public String toString() {
		return "User [user_id=" + user_id + ", user_first_name=" + user_first_name + ", user_last_name="
				+ user_last_name + ", email=" + user_email + "]";
	}
	
}
