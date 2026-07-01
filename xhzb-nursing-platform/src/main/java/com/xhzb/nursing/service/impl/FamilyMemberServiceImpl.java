package com.xhzb.nursing.service.impl;

import java.util.*;

import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.util.RandomUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.xhzb.common.utils.DateUtils;
import com.xhzb.framework.web.service.TokenService;
import com.xhzb.nursing.domain.dto.UserLoginRequestDto;
import com.xhzb.nursing.domain.vo.LoginVo;
import com.xhzb.nursing.service.WechatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xhzb.nursing.mapper.FamilyMemberMapper;
import com.xhzb.nursing.domain.FamilyMember;
import com.xhzb.nursing.service.IFamilyMemberService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 老人家属Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-04-06
 */
@Service
public class FamilyMemberServiceImpl extends ServiceImpl<FamilyMemberMapper, FamilyMember> implements IFamilyMemberService
{
    @Autowired
    private FamilyMemberMapper familyMemberMapper;

    @Autowired
    private WechatService wechatService;

    @Autowired
    private TokenService tokenService;

    static List<String> DEFAULT_NICKNAME_PREFIX = ListUtil.of("生活更美好",
            "大桔大利",
            "日富一日",
            "好柿开花",
            "柿柿如意",
            "一椰暴富",
            "大柚所为",
            "杨梅吐气",
            "天生荔枝"
    );

    /**
     * 小程序登录
     * @param dto
     * @return
     */
    @Override
    public LoginVo login(UserLoginRequestDto dto) {
        // 获取openid  微信开发平台  当是第三方接口的时候，最好封装一个独立类来去完成
        String openid = wechatService.getOpenid(dto.getCode());

        // 获取手机号   微信开发平台
        String phone = wechatService.getPhone(dto.getPhoneCode());

        // 根据openid查用户是否存在，不存在呢，新增，存在呢？数据库中的手机号跟获取手机号不一样，才会修改
        FamilyMember familyMember = getOne(Wrappers.<FamilyMember>lambdaQuery().eq(FamilyMember::getOpenId, openid));
        if(null == familyMember){

            //准备一个默认的名称  随机字符串+ 手机号后4位
            int index = RandomUtil.randomInt(0, 9);
            // 1388888 8888
            String name = DEFAULT_NICKNAME_PREFIX.get(index) + phone.substring(phone.length() - 4);

            familyMember = FamilyMember.builder()
                    .phone(phone)
                    .openId(openid)
                    .name(name)
                    .build();

            //保存用户
            save(familyMember);
        } else if (!familyMember.getPhone().equals(phone)){
            // 从微信获取到的手机号跟数据库中保存的不一致
            familyMember.setPhone(phone);
            updateById(familyMember);
        }

        // 生成token, 返回数据
        Map<String,Object> map = new HashMap<>();
        map.put("userId",familyMember.getId());
        map.put("name",familyMember.getName());

        String token = tokenService.createToken(map);
        LoginVo loginVo = new LoginVo();
        loginVo.setToken(token);
        loginVo.setNickName(familyMember.getName());

        return loginVo;
    }

    /**
     * 查询老人家属
     * 
     * @param id 老人家属主键
     * @return 老人家属
     */
    @Override
    public FamilyMember selectFamilyMemberById(Long id)
    {
        return getById(id);
    }

    /**
     * 查询老人家属列表
     * 
     * @param familyMember 老人家属
     * @return 老人家属
     */
    @Override
    public List<FamilyMember> selectFamilyMemberList(FamilyMember familyMember)
    {
        return familyMemberMapper.selectFamilyMemberList(familyMember);
    }

    /**
     * 新增老人家属
     * 
     * @param familyMember 老人家属
     * @return 结果
     */
    @Override
    public int insertFamilyMember(FamilyMember familyMember)
    {
        return save(familyMember)? 1 : 0;
    }

    /**
     * 修改老人家属
     * 
     * @param familyMember 老人家属
     * @return 结果
     */
    @Override
    public int updateFamilyMember(FamilyMember familyMember)
    {
        return updateById(familyMember)? 1 : 0;
    }

    /**
     * 批量删除老人家属
     * 
     * @param ids 需要删除的老人家属主键
     * @return 结果
     */
    @Override
    public int deleteFamilyMemberByIds(Long[] ids)
    {
        return removeByIds(Arrays.asList(ids))? 1 : 0;
    }

    /**
     * 删除老人家属信息
     * 
     * @param id 老人家属主键
     * @return 结果
     */
    @Override
    public int deleteFamilyMemberById(Long id)
    {
        return removeById(id)? 1 : 0;
    }
}
