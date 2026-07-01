package com.xhzb.nursing.domain;

import com.xhzb.common.annotation.Excel;
import com.xhzb.common.core.domain.BaseEntity;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 预约信息对象 reservation
 * 
 * @author ruoyi
 * @date 2024-06-07
 */
@Data
public class Reservation extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 预约人姓名 */
    @Excel(name = "预约人姓名")
    private String name;

    /** 预约人手机号 */
    @Excel(name = "预约人手机号")
    private String mobile;

    /** 预约时间 */
    @Excel(name = "预约时间")
    private LocalDateTime time;

    /** 探访人 */
    @Excel(name = "探访人")
    private String visitor;

    /** 预约类型，0：参观预约，1：探访预约 */
    @Excel(name = "预约类型，0：参观预约，1：探访预约")
    private Integer type;

    /** 预约状态，0：待报道，1：已完成，2：取消，3：过期 */
    @Excel(name = "预约状态，0：待报道，1：已完成，2：取消，3：过期")
    private Integer status;

}
