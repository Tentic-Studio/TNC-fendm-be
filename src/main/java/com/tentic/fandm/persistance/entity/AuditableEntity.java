package com.tentic.fandm.persistance.entity;

import java.time.ZonedDateTime;
import java.util.UUID;

import org.hibernate.annotations.UuidGenerator;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;

import jakarta.persistence.Column;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;
import lombok.Getter;
import lombok.Setter;

@MappedSuperclass
@Getter
@Setter
public abstract class AuditableEntity {

  @Id
  @Column(name = "id", nullable = false)
  @UuidGenerator
  private UUID id;

  @Column(name = "created_at", nullable = false, updatable = false)
  @CreatedDate
  private ZonedDateTime createdAt;

  @Column(name = "created_by", nullable = false, updatable = false)
  @CreatedBy
  private String createdBy;

  @Column(name = "updated_at", nullable = false)
  @LastModifiedDate
  private ZonedDateTime updatedAt;

  @Column(name = "updated_by", nullable = false)
  @LastModifiedBy
  private String updatedBy;

}
