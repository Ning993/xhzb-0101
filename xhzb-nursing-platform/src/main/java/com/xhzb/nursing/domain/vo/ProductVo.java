package com.xhzb.nursing.domain.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "产品VO")
public class ProductVo {

    /**
     * 产品id
     */
    @Schema(title = "产品id")
    private String productId;

    /**
     * 产品名称
     */
    @Schema(title = "产品名称")
    private String name;
}
