package com.tentic.fandm.dto.response;

import java.util.UUID;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TenantResponse {
    private UUID id;
    private String businessName;
    private String address;
    private String phone;
    private String email;
    private String invoiceFooter;
}