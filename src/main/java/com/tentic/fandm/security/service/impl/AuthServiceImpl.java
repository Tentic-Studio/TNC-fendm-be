package com.tentic.fandm.security.service.impl;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.tentic.fandm.dto.request.LoginRequest;
import com.tentic.fandm.dto.response.AuthResponse;
import com.tentic.fandm.dto.response.TenantResponse;
import com.tentic.fandm.dto.response.UserResponse;
import com.tentic.fandm.persistance.entity.RefreshTokenEntity;
import com.tentic.fandm.persistance.entity.UserEntity;
import com.tentic.fandm.persistance.repository.RefreshTokenRepository;
import com.tentic.fandm.persistance.repository.UserRepository;
import com.tentic.fandm.security.service.AuthService;
import com.tentic.fandm.security.util.JwtUtil;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    @Value("${jwt.refresh-expiration}")
    private Long refreshExpiration;

    private final UserRepository userRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private final JwtUtil jwtUtil;
    private final PasswordEncoder passwordEncoder;

    @Override
    public AuthResponse login(LoginRequest request, HttpServletResponse response) {
        // Cari user by email
        UserEntity user = userRepository.findByEmailIgnoreCase(request.getEmail())
                .orElseThrow(() -> new RuntimeException("User tidak tersedia"));

        // Cek password
        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new RuntimeException("Email atau password salah");
        }

        // Cek apakah user aktif
        if (!user.getIsActive()) {
            throw new RuntimeException("Akun tidak aktif");
        }

        // Generate Access Token
        String accessToken = jwtUtil.generateToken(user);

        // Generate Refresh Token & simpan ke DB
        String refreshToken = generateAndSaveRefreshToken(user);

        // Set Refresh Token ke HttpOnly Cookie
        setRefreshTokenCookie(response, refreshToken);

        return AuthResponse.builder()
                .accessToken(accessToken)
                .mustChangePassword(user.getMustChangePassword())
                .user(UserResponse.builder()
                        .id(user.getId())
                        .name(user.getUsername())
                        .email(user.getEmail())
                        .role(user.getRole())
                        .tenantRole(user.getTenantRole())
                        .build())
                .tenant(user.getTenant() != null
                        ? TenantResponse.builder()
                                .id(user.getTenant().getId())
                                .businessName(user.getTenant().getBusinessName())
                                .address(user.getTenant().getAddress())
                                .phone(user.getTenant().getPhone())
                                .email(user.getTenant().getEmail())
                                .invoiceFooter(user.getTenant().getInvoiceFooter())
                                .build()
                        : null)
                .build();
    }

    @Override
    public AuthResponse refresh(HttpServletRequest request, HttpServletResponse response) {
        // Ambil refresh token dari Cookie
        String refreshToken = extractRefreshTokenFromCookie(request);

        if (refreshToken == null) {
            throw new RuntimeException("Refresh token tidak ditemukan");
        }

        // Cari di DB
        RefreshTokenEntity tokenEntity = refreshTokenRepository.findByToken(refreshToken)
                .orElseThrow(() -> new RuntimeException("Refresh token tidak valid"));

        // Cek apakah expired
        if (tokenEntity.getExpiresAt().isBefore(LocalDateTime.now())) {
            refreshTokenRepository.delete(tokenEntity);
            throw new RuntimeException("Refresh token expired, silakan login ulang");
        }

        // Generate Access Token baru
        UserEntity user = tokenEntity.getUser();
        String newAccessToken = jwtUtil.generateToken(user);

        // Rotate refresh token — hapus lama, buat baru
        // Lebih aman: kalau refresh token lama dicuri, tidak bisa dipakai lagi
        refreshTokenRepository.delete(tokenEntity);
        String newRefreshToken = generateAndSaveRefreshToken(user);
        setRefreshTokenCookie(response, newRefreshToken);

        return AuthResponse.builder()
                .accessToken(newAccessToken)
                .user(UserResponse.builder()
                        .id(user.getId())
                        .name(user.getUsername())
                        .email(user.getEmail())
                        .role(user.getRole())
                        .build())
                .build();
    }

    @Override
    public void logout(HttpServletRequest request, HttpServletResponse response) {
        // Ambil refresh token dari Cookie
        String refreshToken = extractRefreshTokenFromCookie(request);

        // Hapus dari DB kalau ada
        if (refreshToken != null) {
            refreshTokenRepository.findByToken(refreshToken)
                    .ifPresent(refreshTokenRepository::delete);
        }

        // Hapus Cookie
        clearRefreshTokenCookie(response);
    }

    @Override
    public UserEntity getCurrentUser(String email) {
        return userRepository.findByEmailIgnoreCase(email)
                .orElseThrow(() -> new RuntimeException("User tidak ditemukan"));
    }

    // ── HELPER METHODS ─────────────────────────────────

    private String generateAndSaveRefreshToken(UserEntity user) {
        // Generate random UUID sebagai refresh token
        String token = UUID.randomUUID().toString();

        RefreshTokenEntity refreshTokenEntity = new RefreshTokenEntity();
        refreshTokenEntity.setUser(user);
        refreshTokenEntity.setToken(token);
        refreshTokenEntity.setExpiresAt(
                LocalDateTime.now().plusSeconds(refreshExpiration / 1000));

        refreshTokenRepository.save(refreshTokenEntity);
        return token;
    }

    private void setRefreshTokenCookie(HttpServletResponse response, String token) {
        ResponseCookie cookie = ResponseCookie.from("refreshToken", token)
                .httpOnly(true)
                .secure(false)
                .path("/")
                .maxAge(refreshExpiration / 1000)
                .sameSite("Lax")
                .build();
        response.addHeader(HttpHeaders.SET_COOKIE, cookie.toString());
    }

    private void clearRefreshTokenCookie(HttpServletResponse response) {
        ResponseCookie cookie = ResponseCookie.from("refreshToken", "")
                .httpOnly(true)
                .secure(false)
                .path("/")
                .maxAge(0)
                .sameSite("Lax")
                .build();
        response.addHeader(HttpHeaders.SET_COOKIE, cookie.toString());
    }

    private String extractRefreshTokenFromCookie(HttpServletRequest request) {
        if (request.getCookies() == null)
            return null;

        return Arrays.stream(request.getCookies())
                .filter(c -> "refreshToken".equals(c.getName()))
                .map(Cookie::getValue)
                .findFirst()
                .orElse(null);
    }

}
