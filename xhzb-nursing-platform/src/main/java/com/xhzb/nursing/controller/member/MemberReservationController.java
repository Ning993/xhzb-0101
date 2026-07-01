package com.xhzb.nursing.controller.member;

import com.xhzb.common.core.controller.BaseController;
import com.xhzb.common.core.domain.AjaxResult;
import com.xhzb.common.core.domain.R;
import com.xhzb.common.core.page.TableDataInfo;
import com.xhzb.common.utils.UserThreadLocal;
import com.xhzb.nursing.domain.dto.ReservationDto;
import com.xhzb.nursing.domain.vo.TimeCountVo;
import com.xhzb.nursing.service.IReservationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 预约信息Controller
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/member/reservation")
@Tag(name =  "预约信息相关接口")
public class MemberReservationController extends BaseController
{

    @Autowired
    private IReservationService reservationService;

    @GetMapping("/countByTime")
    @Operation(summary = "查询每个时间段剩余预约次数")
    public R<List<TimeCountVo>> countReservationsForEachTimeWithinTimeRange(Long time) {
        List<TimeCountVo> list = reservationService.countReservationsForTime(time);
        return R.ok(list);
    }

    @GetMapping("/cancelled-count")
    @Operation(summary = "查询取消预约数量")
    public R<Integer> getCancelledReservationCount() {
        //获取当前登录人
        Long userId = UserThreadLocal.getUserId();
        int count = reservationService.getCancelledCount(userId);
        return R.ok(count);
    }

    /**
     * 新增预约信息
     */
    @PostMapping
    @Operation(summary = "新增预约信息")
    public AjaxResult add(@RequestBody ReservationDto reservationDto)
    {
        return toAjax(reservationService.insertReservation(reservationDto));
    }

    /*
     *分页查询增加预约人姓名，手机号，状态，类型的查询条件
     */
    @GetMapping("/page")
    @Operation(summary = "分页查询预约")
    public AjaxResult findByPage(@RequestParam(defaultValue = "1") int pageNum,
                                       @RequestParam(defaultValue = "10") int pageSize,
                                       @RequestParam(required = false) Integer status ) {
        TableDataInfo tableDataInfo = reservationService.findByPage(pageNum, pageSize, status);
        return success(tableDataInfo);
    }

    @PutMapping("/{id}/cancel")
    @Operation(summary = "取消预约")
    public AjaxResult cancel(@PathVariable Long id) {
        return toAjax(reservationService.cancelReservation(id));
    }

}