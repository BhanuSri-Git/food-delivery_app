package com.food.Model;
import java.sql.Timestamp;

public class User {
	private int UserId;
	private String UserName;
	private String password;
	private String email;
	private String address;
	private String role;
	private Timestamp createDate ;
	private Timestamp lastLoginDate;
	public User() {

	}
	public User(String UserName, String password, String email, String address, String role) {
		super();
		this.UserName = UserName;
		this.password = password;
		this.email = email;
		this.address = address;
		this.role = role;
	}
	public User(int UserId,String UserName, String password, String email,String address, String role, Timestamp createDate,
			Timestamp lastLoginDate) {
		super();
		this.UserId = UserId;
		this.UserName = UserName;
		this.password=password;
		this.email = email;
		this.address = address;
		this.role = role;
		this.createDate = createDate;
		this.lastLoginDate = lastLoginDate;
	}
	public int getUserId() {
		return UserId;
	}

	public void setUserId(int UserId) {
		this.UserId = UserId;
	}

	public String getUserName() {
		return UserName;
	}

	public void setUserName(String UserName) {
		this.UserName = UserName;
	}
	public String getpassword() {
		return password;
	}

	public void setpassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Timestamp getcreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public Timestamp getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(Timestamp lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	@Override
	public String toString() {
		return "User [UserId=" + UserId + ", UserName=" + UserName + ", password=" + password + ", email=" + email
				+ ", address=" + address + ", role=" + role + ", createDate=" + createDate + ", lastLoginDate="
				+ lastLoginDate + "]";
	}
	}