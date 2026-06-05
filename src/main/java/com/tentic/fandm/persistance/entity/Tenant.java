package com.tentic.fandm.persistance.entity;

import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.SQLRestriction;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "tbl_tenants", uniqueConstraints = { @UniqueConstraint(columnNames = { "code" }) })
@SQLDelete(sql = "UPDATE tbl_tenants SET deleted_at = now() WHERE id=? ")
@SQLRestriction("deleted_at IS NULL")
@Getter
@Setter
public class Tenant extends MasterEntity {

  @Column(name = "code", nullable = false)
  private String code;

  @Column(name = "business_name", nullable = false)
  private String businessName;

  @Column(name = "address", nullable = false)
  private String address;

  @Column(name = "phone", nullable = false)
  private String phone;

  @Column(name = "email", nullable = false)
  private String email;

  @Column(name = "invoice_footer")
  private String invoiceFooter;

}
