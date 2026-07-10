package com.food.DAO;

import java.util.List;

import com.food.Model.User;

public interface UserDAO {
	int addUser(User user);
	User getUser(int UserId);
	void updateUser(User user);
	void deleteUser(int UserId);
	List<User> getAllUsers();
	User getUserByUsername(String username);
}