package com.xhzb.nursing.job;

import com.xhzb.nursing.service.IContractService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class ContractStatusJob {


    @Autowired
    private IContractService contractService;

    public void updateContractStatus(){
        contractService.updateContractStatus();
        log.info("定时修改合同状态成功!");
    }
}
