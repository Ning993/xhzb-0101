package com.xhzb.nursing.domain.vo;

import com.xhzb.nursing.domain.DeviceData;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Schema(description = "设备信息响应模型")
@Data
public class DeviceInfo {

    @Schema(title = "主键")
    private Long id;

    @Schema(title = "物联网设备ID")
    private String iotId;

    @Schema(title = "设备名称")
    private String deviceName;

    @Schema(title = "产品key")
    public String productKey;

    @Schema(title = "产品名称")
    public String productName;

    @Schema(title = "设备数据")
    private List<DeviceData> deviceDataVos;
}