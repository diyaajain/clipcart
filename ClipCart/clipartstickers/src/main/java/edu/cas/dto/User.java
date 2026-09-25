package edu.cas.dto;

import java.sql.Date;


public class User {
	private int user_id;
	private int user_roleid;
	private String user_name;
	private String user_password;
	private String user_firstname;
	private String user_lastname;
	private String user_address;
	private String user_emailid;
	private String user_rolename;
	
	
	public String getUser_rolename() {
		return user_rolename;
	}



	public void setUser_rolename(String user_rolename) {
		this.user_rolename = user_rolename;
	}
	

	public int getUser_id() {
		return user_id;
	}



	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}



	public int getUser_roleid() {
		return user_roleid;
	}



	public void setUser_roleid(int user_roleid) {
		this.user_roleid = user_roleid;
	}



	public String getUser_name() {
		return user_name;
	}



	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}



	public String getUser_password() {
		return user_password;
	}



	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}



	public String getUser_firstname() {
		return user_firstname;
	}



	public void setUser_firstname(String user_firstname) {
		this.user_firstname = user_firstname;
	}



	public String getUser_lastname() {
		return user_lastname;
	}



	public void setUser_lastname(String user_lastname) {
		this.user_lastname = user_lastname;
	}



	public String getUser_address() {
		return user_address;
	}



	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}



	public String getUser_emailid() {
		return user_emailid;
	}



	public void setUser_emailid(String user_emailid) {
		this.user_emailid = user_emailid;
	}


	@Override
	public String toString() {
		return "User [user_id=" + user_id + ", user_roleid=" + user_roleid + ", user_name=" + user_name + ", user_password=" + user_password
				+ ", user_firstname=" + user_firstname + ", user_lastname=" + user_lastname + ", user_address=" + user_address + ", user_emailid=" + user_emailid
				+ "]";
	}

	
}
