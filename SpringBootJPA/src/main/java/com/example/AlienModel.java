package com.example;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/*if you define only entity here the table create by ModelCass name. as eg. alien_model*/
@Entity
/*
 * here we defining table name as we want,if dont define then table create by
 * modelclass name
 */
@Table(name = "Alien")
public class AlienModel {
	@Id
	private int aid;
	private String aname;

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getAname() {
		return aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	@Override
	public String toString() {
		return "AlienModel [aid=" + aid + ", aname=" + aname + "]";
	}
}
