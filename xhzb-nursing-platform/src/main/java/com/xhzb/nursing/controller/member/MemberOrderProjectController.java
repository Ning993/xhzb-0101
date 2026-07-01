package com.xhzb.nursing.controller.member;

import com.xhzb.common.core.controller.BaseController;
import com.xhzb.common.core.domain.AjaxResult;
import com.xhzb.common.core.page.TableDataInfo;
import com.xhzb.nursing.domain.NursingProject;
import com.xhzb.nursing.service.INursingProjectService;
import org.aspectj.weaver.loadtime.Aj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.crypto.interfaces.PBEKey;
import java.util.List;

@RestController
@RequestMapping("/member/orders/project")
public class MemberOrderProjectController extends BaseController {

    @Autowired
    private INursingProjectService nursingProjectService;

    /**
     * 1.1 分页查询护理项目列表
     */
    @GetMapping("/page")
    public AjaxResult page(NursingProject nursingProject) {
        startPage();
        List<NursingProject> list = nursingProjectService.selectNursingProjectList(nursingProject);
        return success(getDataTable(list));
    }

    /**
     * 1.2 根据编号查询护理项目信息
     */
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) {
        return success(nursingProjectService.selectNursingProjectById(id));
    }
}
