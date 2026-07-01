package com.xhzb.nursing.job.vo;

import lombok.Data;

import java.util.List;

/**
 * amqp消息-body部分
 *
 * @author itcast
 **/
@Data
public class IotMsgBody {
    /**
     * 服务列表
     */
    private List<IotMsgService> services;
}
