package com.smartfarming.service;

import com.smartfarming.dao.UserDAO;
import com.smartfarming.model.User;

public class UserService {
    private UserDAO userDAO = new UserDAO();

    public boolean registerUser(User user) {

        return userDAO.register(user);
    }

    public User login(String email, String password) {
        return userDAO.login(email, password);
    }
}