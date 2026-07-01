package com.xhzb.nursing.domain.vo;

import lombok.Data;

@Data
public class NursingNameVo {

    /**
     * 老人id
     */
    private Long elderId;

    /**
     * 护理员姓名
     */
    private String nursingName;
}
