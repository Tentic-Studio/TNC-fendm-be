package com.tentic.fandm.security.util;

import java.nio.charset.StandardCharsets;
import java.util.Date;

import javax.crypto.SecretKey;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.tentic.fandm.persistance.entity.UserEntity;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

@Component
public class JwtUtil {

    @Value("${jwt.secret}")
    private String secret;

    @Value("${jwt.expiration}")
    private long expiration;

    public String generateToken(UserEntity user) {
        var builder = Jwts.builder()
                .subject(user.getEmail())
                .claim("role", user.getRole())
                .claim("userId", user.getId().toString())
                .claim("mustChangePassword", user.getMustChangePassword())
                // ← tambah tenant info
                .claim("tenantRole", user.getTenantRole());

        // tenantId bisa null untuk SUPER_ADMIN
        if (user.getTenant() != null) {
            builder.claim("tenantId", user.getTenant().getId().toString());
            builder.claim("businessName", user.getTenant().getBusinessName());
        }

        return builder
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + expiration))
                .signWith(getSigningKey())
                .compact();
    }

    public String extractEmail(String token) {
        return getClaims(token).getSubject();
    }

    public String extractTenantId(String token) {
        return getClaims(token).get("tenantId", String.class);
    }

    public String extractTenantRole(String token) {
        return getClaims(token).get("tenantRole", String.class);
    }

    public Boolean extractMustChangePassword(String token) {
        return getClaims(token).get("mustChangePassword", Boolean.class);
    }

    public boolean isTokenValid(String token) {
        try {
            getClaims(token);
            return true;
        } catch (JwtException | IllegalArgumentException e) {
            return false;
        }
    }

    private Claims getClaims(String token) {
        return Jwts.parser()
                .verifyWith(getSigningKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    private SecretKey getSigningKey() {
        return Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
    }
}