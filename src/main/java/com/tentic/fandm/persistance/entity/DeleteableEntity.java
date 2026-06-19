package com.tentic.fandm.persistance.entity;

import java.time.ZonedDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.MappedSuperclass;
import lombok.Getter;
import lombok.Setter;

@MappedSuperclass
@Getter
@Setter
public abstract class DeleteableEntity extends AuditableEntity {

  @Column(name = "deleted_at")
  private ZonedDateTime deletedAt;

  @Column(name = "deleted_by")
  private String deletedBy;

}
