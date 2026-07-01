package com.xhzb.framework.interceptor;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.ObjectUtil;
import com.sun.jna.platform.win32.Netapi32Util;
import com.xhzb.common.exception.base.BaseException;
import com.xhzb.common.utils.StringUtils;
import com.xhzb.common.utils.UserThreadLocal;
import com.xhzb.framework.web.service.TokenService;
import io.jsonwebtoken.Claims;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class MemberInterceptor implements HandlerInterceptor {

    @Autowired
    private TokenService tokenService;


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 获取token
        String token = request.getHeader("authorization");
        if(StringUtils.isEmpty(token)){
            throw new BaseException("认证失败，请重新登录");
        }
        // 解析token
        Claims claims = tokenService.parseToken(token);
        if(ObjectUtil.isEmpty(claims)){
            throw new BaseException("认证失败，请重新登录");
        }
        // 获取数据
//        Object userId = claims.get("userId");
        Long userId = MapUtil.get(claims, "userId", Long.class);
        if(ObjectUtil.isEmpty(userId)){
            throw new BaseException("认证失败，请重新登录");
        }
        // 存储到线程变量中
        UserThreadLocal.set(userId);
        return true;

    }


    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        UserThreadLocal.remove();
    }
}
