package com.xhzb.framework.config;

import com.huaweicloud.sdk.core.auth.AbstractCredentials;
import com.huaweicloud.sdk.core.auth.BasicCredentials;
import com.huaweicloud.sdk.core.auth.ICredential;
import com.huaweicloud.sdk.core.region.Region;
import com.huaweicloud.sdk.iotda.v5.IoTDAClient;
import com.xhzb.framework.config.properties.HuaWeiIotConfigProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class IotClientConfig {

    @Autowired
    private HuaWeiIotConfigProperties huaWeiIotConfigProperties;


    @Bean
    public IoTDAClient instance(){
        ICredential auth = new BasicCredentials()
                .withProjectId(huaWeiIotConfigProperties.getProjectId())
                // 标准版/企业版需要使用衍生算法，基础版请删除配置"withDerivedPredicate";
                .withDerivedPredicate(AbstractCredentials.DEFAULT_DERIVED_PREDICATE) // Used in derivative ak/sk authentication scenarios
                .withAk(huaWeiIotConfigProperties.getAk())
                .withSk(huaWeiIotConfigProperties.getSk());

        IoTDAClient client = IoTDAClient.newBuilder()
                .withCredential(auth)
                // 标准版/企业版：需自行创建Region对象，基础版：请使用IoTDARegion的region对象，如"withRegion(IoTDARegion.CN_NORTH_4)"
                .withRegion(new Region(huaWeiIotConfigProperties.getRegionId(), huaWeiIotConfigProperties.getEndpoint()))
                .build();
        return client;
    }
}
