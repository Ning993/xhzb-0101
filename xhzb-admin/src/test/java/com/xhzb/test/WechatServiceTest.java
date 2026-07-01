package com.xhzb.test;

import com.xhzb.nursing.service.WechatService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class WechatServiceTest {

    @Autowired
    private WechatService wechatService;

    @Test
    public void testGetOpenid(){
        String openid = wechatService.getOpenid("0a1SsQll26Vmh4Xdkll2NXAJF4SsQlM");
        System.out.println(openid);
    }


    @Test
    public void testGetPhone(){
        String openid = wechatService.getPhone("4b88f16455e3e6273693426d5266b7fc12da6ace387dcfda60b3b88fa02cad84");
        System.out.println(openid);
    }
}
