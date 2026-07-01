package com.xhzb.nursing.domain.dto;

import lombok.Data;

import java.util.List;

@Data
public class NursingElderDto {

    /**
     * 老人id
     */
    private Long elderId;

    /**
     * 护理员id列表
     */
    private List<Long> nursingIds;
}
