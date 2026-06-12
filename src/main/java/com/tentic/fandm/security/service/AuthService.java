package com.tentic.fandm.security.service;

import com.tentic.fandm.dto.request.LoginRequest;
import com.tentic.fandm.dto.response.AuthResponse;
import com.tentic.fandm.persistance.entity.UserEntity;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface AuthService {

    AuthResponse login(LoginRequest request, HttpServletResponse response);

    AuthResponse refresh(HttpServletRequest request, HttpServletResponse response);

    void logout(HttpServletRequest request, HttpServletResponse response);

    UserEntity getCurrentUser(String email);

}
