package com.tentic.fandm.persistance.entity;

import java.time.ZonedDateTime;

import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.SQLRestriction;

import com.tentic.fandm.constant.TenantRoleConstant;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "tbl_users", uniqueConstraints = { @UniqueConstraint(columnNames = { "tenant_id", "username" }) })
@SQLDelete(sql = "UPDATE tbl_users SET deleted_at = now() WHERE id=? ")
@SQLRestriction("deleted_at IS NULL")
@Getter
@Setter
public class User extends MasterEntity {

  @OneToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "tenant_id", nullable = false)
  private Tenant tenant;

  @Column(name = "tenant_role", nullable = false)
  private String tenantRole;

  @Column(name = "username", nullable = false)
  private String username;

  @Column(name = "email", nullable = false)
  private String email;

  @Column(name = "password", nullable = false)
  private String password;

  @Column(name = "role", nullable = false)
  private String role;

  @Column(name = "must_change_password", nullable = false)
  private Boolean mustChangePassword;

  @Column(name = "duration_expired_pass", nullable = false)
  private Integer durationExpiredPass;

  @Column(name = "temp_password_expires_at", nullable = false)
  private ZonedDateTime tempPasswordExpiresAt;

}
