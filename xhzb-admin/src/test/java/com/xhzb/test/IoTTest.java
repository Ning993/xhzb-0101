package com.xhzb.test;

import com.huaweicloud.sdk.iotda.v5.IoTDAClient;
import com.huaweicloud.sdk.iotda.v5.model.ListProductsRequest;
import com.huaweicloud.sdk.iotda.v5.model.ListProductsResponse;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class IoTTest {

    @Autowired
    private IoTDAClient client;

    @Test
    public void test(){
        ListProductsRequest request = new ListProductsRequest();
        request.setLimit(50);
        ListProductsResponse response = client.listProducts(request);
        if(response.getHttpStatusCode() == 200){
            System.out.println(response.getProducts());
        }
    }
}
