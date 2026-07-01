package com.xhzb.test;

import cn.hutool.http.HttpResponse;
import cn.hutool.http.HttpUtil;
import cn.hutool.http.Method;
import cn.hutool.json.JSONUtil;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.Map;

public class HttpTest {


    @Test
    public void testGet(){
        // 请求百度
        String result = HttpUtil.get("https://www.baidu.com");
        System.out.println(result);
    }

    @Test
    public void testGetByParam(){
        // 请求百度
        String result = HttpUtil.get("http://localhost:8080/nursing/project/all");
        System.out.println(result);
    }

    @Test
    public void testGetByRequest(){
        // 请求百度
        HttpResponse response = HttpUtil.createRequest(Method.GET, "http://localhost:8080/nursing/project/all")
                .header("authorization", "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImxvZ2luX3VzZXJfa2V5IjoiNzY1ZmVhMzMtMjM2Yy00OTk0LWIzYzItZDE5NjNhNWFjZTJlIn0.vPNYM-Y6vMo9vA26HBrNBKDMhMSSqDJkRQ4tiKg1yfceoAoGQcpukkpazNtmRJbUzPw-8L3MznLxEHAd9fwxnQ")
                .execute();
        if(response.isOk()){
            System.out.println(response.body());
        }
    }

    @Test
    public void testPostByRequest(){

        // 准备参数
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("name", "护理项目测试");
        paramMap.put("orderNo", 1);
        paramMap.put("unit", "次");
        paramMap.put("price", 10.00);
        paramMap.put("image", "https://yjy-slwl-oss.oss-cn-hangzhou.aliyuncs.com/ae7cf766-fb7b-49ff-a73c-c86c25f280e1.png");
        paramMap.put("nursingRequirement", "无特殊要求");
        paramMap.put("status", 1);


        // 请求百度
        HttpResponse response = HttpUtil.createRequest(Method.POST, "http://localhost:8080/nursing/project")
                .header("authorization", "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImxvZ2luX3VzZXJfa2V5IjoiNzY1ZmVhMzMtMjM2Yy00OTk0LWIzYzItZDE5NjNhNWFjZTJlIn0.vPNYM-Y6vMo9vA26HBrNBKDMhMSSqDJkRQ4tiKg1yfceoAoGQcpukkpazNtmRJbUzPw-8L3MznLxEHAd9fwxnQ")
                .body(JSONUtil.toJsonStr(paramMap))
                .execute();
        if(response.isOk()){
            System.out.println(response.body());
        }
    }
}
