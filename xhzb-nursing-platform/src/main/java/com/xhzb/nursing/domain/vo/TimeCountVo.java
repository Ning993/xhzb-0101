package com.xhzb.nursing.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * @author itheima
 */
@Data
public class TimeCountVo {

    /**
     * 时间
     */
    @Schema(title = "时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")//get
    private LocalDateTime time;

    /**
     * 次数
     */
    @Schema(title = "次数")
    private Integer count;
}
