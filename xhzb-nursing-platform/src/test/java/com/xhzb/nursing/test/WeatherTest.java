package com.xhzb.nursing.test;

import cn.hutool.http.HttpUtil;

public class WeatherTest {

    public static void main(String[] args) {
        String result = HttpUtil.get("http://t.weather.itboy.net/api/weather/city/101250101");
        System.out.println(result);


    }
}
