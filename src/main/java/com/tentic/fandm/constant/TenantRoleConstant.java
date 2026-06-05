package com.tentic.fandm.constant;

public enum TenantRoleConstant {

  OWNER("Owner"),
  ADMIN("Admin"),
  USER("User");

  private final String tenantRole;

  private TenantRoleConstant(String tenantRole) {
    this.tenantRole = tenantRole;
  }

  public String getTenantRole() {
    return tenantRole;
  }

}
