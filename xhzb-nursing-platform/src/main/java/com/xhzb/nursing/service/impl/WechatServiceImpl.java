package com.xhzb.nursing.service.impl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.xhzb.nursing.service.WechatService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;


@Service
@Slf4j
public class WechatServiceImpl implements WechatService {


    // 登录
    private static final String REQUEST_URL = "https://api.weixin.qq.com/sns/jscode2session?grant_type=authorization_code";

    // 获取token
    private static final String TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential";

    // 获取手机号
    private static final String PHONE_REQUEST_URL = "https://api.weixin.qq.com/wxa/business/getuserphonenumber?access_token=";


    @Value("${wechat.appid}")
    private String appid;

    @Value("${wechat.secret}")
    private String secret;

    /**
     * 获取openid
     * @param code
     * @return
     */
    @Override
    public String getOpenid(String code) {

        Map<String, Object> params = getParams();
        params.put("js_code",code);

        //发送请求
        String result = HttpUtil.get(REQUEST_URL, params);
        // 转换为json对象
        JSONObject jsonObject = JSONUtil.parseObj(result);
        if(ObjectUtil.isNotEmpty(jsonObject.getInt("errcode"))){
            throw new RuntimeException(jsonObject.getStr("errmsg"));
        }

        return jsonObject.getStr("openid");
    }

    /**
     * 公共参数封装
     * @return
     */
    private Map<String, Object> getParams() {
        Map<String ,Object> params = new HashMap<>();
        params.put("appid",appid);
        params.put("secret",secret);
        return params;
    }

    /**
     * 获取token
     * @return
     */
    private String getToken(){

        Map<String, Object> params = getParams();

        //发送请求
        String result = HttpUtil.get(TOKEN_URL, params);
        // 转换为json对象
        JSONObject jsonObject = JSONUtil.parseObj(result);
        if(ObjectUtil.isNotEmpty(jsonObject.getInt("errcode"))){
            throw new RuntimeException(jsonObject.getStr("errmsg"));
        }

        return jsonObject.getStr("access_token");

    }

    /**
     * 获取手机号
     *
     * @param phoneCode
     * @return
     */
    @Override
    public String getPhone(String phoneCode) {
        //访问路径
        String url = PHONE_REQUEST_URL+getToken();
        Map<String,Object> map = new HashMap<>();
        map.put("code",phoneCode);

        //发送请求
        String result = HttpUtil.post(url, JSONUtil.toJsonStr(map));
        // 转换为json对象
        JSONObject jsonObject = JSONUtil.parseObj(result);

        //
        if(jsonObject.getInt("errcode") != 0){
            throw new RuntimeException(jsonObject.getStr("errmsg"));
        }

        // 获取手机号
        return jsonObject.getJSONObject("phone_info").getStr("phoneNumber");
    }
}
