package com.xhzb.nursing.job;

import com.xhzb.nursing.service.IAlertRuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AlertJob {

    @Autowired
    private IAlertRuleService alertRuleService;


    public void deviceDataAlertFilter(){
        // 调用报警过滤
        alertRuleService.alertFilter();
    }
}
