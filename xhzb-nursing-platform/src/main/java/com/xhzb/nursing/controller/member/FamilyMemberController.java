package com.xhzb.nursing.controller.member;

import com.xhzb.common.core.controller.BaseController;
import com.xhzb.common.core.domain.AjaxResult;
import com.xhzb.nursing.domain.dto.UserLoginRequestDto;
import com.xhzb.nursing.domain.vo.LoginVo;
import com.xhzb.nursing.service.IFamilyMemberService;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 老人家属Controller
 * 
 * @author ruoyi
 * @date 2026-04-06
 */
@RestController
@RequestMapping("/member/user")
@Tag(name = "老人家属相关接口")
public class FamilyMemberController extends BaseController
{
    @Autowired
    private IFamilyMemberService familyMemberService;

    @PostMapping("/login")
    public AjaxResult login(@RequestBody UserLoginRequestDto dto){
        LoginVo loginVo = familyMemberService.login(dto);
        return success(loginVo);
    }


}
