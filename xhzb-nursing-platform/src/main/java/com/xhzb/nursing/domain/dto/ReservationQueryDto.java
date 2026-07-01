package com.xhzb.nursing.domain.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ReservationQueryDto {

    /**
     * 预约人
     */
    @Schema(title = "预约人")
    private String name;

    /**
     * 预约人手机号
     */
    @Schema(title = "预约人手机号")
    private String mobile;

    /**
     * 时间
     */
    @Schema(title = "开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime startTime;

    /**
     * 时间
     */
    @Schema(title = "结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime endTime;

    /**
     * 预约状态，0：待报道，1：已完成，2：取消，3：过期
     */
    @Schema(title = "预约状态，0：待报道，1：已完成，2：取消，3：过期")
    private Integer status;

    /**
     * 预约类型，0：参观预约，1：探访预约
     */
    @Schema(title = "预约类型，0：参观预约，1：探访预约")
    private Integer type;


}
