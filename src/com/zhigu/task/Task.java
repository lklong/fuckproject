package com.zhigu.task;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.zhigu.common.constant.enumconst.OrderStatus;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.mapper.OrderMapper;
import com.zhigu.mapper.RechargeRecordMapper;
import com.zhigu.mapper.SystemTaskRecordMapper;
import com.zhigu.model.Order;
import com.zhigu.model.OrderCondition;
import com.zhigu.model.PageBean;
import com.zhigu.model.SystemTaskRecord;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.ICartService;
import com.zhigu.service.user.IOrderService;

/**
 * 系统自动执行处理
 * 
 * @ClassName: Task
 * @Description: 现在部分直接update，在大数据情况下需要修改为分页操作
 * @author hesimin
 * @date 2015年5月12日 下午5:38:41
 *
 */
@Component
public class Task {
	@Autowired
	private ICartService cartService;
	@Autowired
	private SystemTaskRecordMapper systemTaskRecordMapper;
	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private IOrderService orderService;
	@Autowired
	private RechargeRecordMapper rechargeRecordMapper;

	/** 自动删除购物车中多少天以前 */
	private static final int SHOPPING_CART_CLEAR_DAY = 30;
	/** 订单有效时间（小时） */
	private static final int ORDER_WAIT_PAY_HOURS = 24;
	/** 订单待收货自动确认时间（天） */
	private static final int ORDER_WAIT_CONFIRM_RECEIVE_GOODS_DAY = 30;
	/** 充值失效（小时） */
	private static final int RECHARGE_RECORD_EFFECTIVE_HOURS = 24 * 2;

	/**
	 * 购物车清除，每天2点
	 */
	@Scheduled(cron = "0 0 2 * * ?")
	public void shopingCartClear() {
		Date now = new Date();
		SystemTaskRecord record = new SystemTaskRecord();
		record.setType("购物车清除");
		record.setStartTime(now);
		systemTaskRecordMapper.insert(record);
		Date effectiveDate = DateUtils.addDays(now, -SHOPPING_CART_CLEAR_DAY);
		int row = cartService.systemDeleteBeforeByDate(DateUtil.format(effectiveDate, DateUtil.yyyy_MM_dd));
		record.setEndTime(new Date());
		record.setContent("清除行数：" + row);
		systemTaskRecordMapper.updateByPrimaryKey(record);
	}

	/**
	 * 充值失效，每天2点
	 */
	@Scheduled(cron = "0 30 4 * * ?")
	public void rechargeRecordCancel() {
		Date now = new Date();
		SystemTaskRecord record = new SystemTaskRecord();
		record.setType("充值失效");
		record.setStartTime(now);
		systemTaskRecordMapper.insert(record);
		Date effectiveDate = DateUtils.addHours(now, -RECHARGE_RECORD_EFFECTIVE_HOURS);
		int row = rechargeRecordMapper.systemCancel(DateUtil.format(effectiveDate, DateUtil.yyyy_MM_dd));
		record.setEndTime(new Date());
		record.setContent("充值失效处理行数：" + row);
		systemTaskRecordMapper.updateByPrimaryKey(record);
	}

	/**
	 * 订单自动取消
	 */
	@Scheduled(cron = "0 0 0,4,16,23 * * ?")
	public void orderCancel() {
		Date now = new Date();
		SystemTaskRecord record = new SystemTaskRecord();
		record.setType("订单取消");
		record.setStartTime(now);
		systemTaskRecordMapper.insert(record);

		PageBean page = new PageBean();
		OrderCondition oc = new OrderCondition();
		oc.setStatus(OrderStatus.ORDER_WAIT_PAY.getValue());
		oc.setEndDate(DateUtils.addHours(new Date(), -ORDER_WAIT_PAY_HOURS));
		page.addParas("oc", oc);

		orderMapper.queryOrdersByPage(page);
		while (page.getPageNo() <= page.getTotalPage()) {
			List<Order> orderList = orderMapper.queryOrdersByPage(page);
			for (Order o : orderList) {
				MsgBean msg = orderService.handlerCancelOrder(o.getOrderNO(), o.getUserID());

				SystemTaskRecord r = new SystemTaskRecord();
				r.setType("订单取消明细");
				Date n = new Date();
				r.setStartTime(n);
				r.setEndTime(n);
				r.setContent("订单号【" + o.getOrderNO() + "】" + msg.getMsg());
				systemTaskRecordMapper.insert(r);
			}
			page.setPageNo(page.getPageNo() + 1);
		}

		record.setEndTime(new Date());
		record.setContent("取消订单");
		systemTaskRecordMapper.updateByPrimaryKey(record);
	}

	/**
	 * 订单自动取消
	 */
	@Scheduled(cron = "0 0 1,5,19,23 * * ?")
	public void orderConfirmReceipt() {
		Date now = new Date();
		SystemTaskRecord record = new SystemTaskRecord();
		record.setType("订单确认收货");
		record.setStartTime(now);
		systemTaskRecordMapper.insert(record);

		PageBean page = new PageBean();
		OrderCondition oc = new OrderCondition();
		oc.setStatus(OrderStatus.ORDER_WAIT_CONFIRM_RECEIVE_GOODS.getValue());
		oc.setEndDate(DateUtils.addDays(new Date(), -ORDER_WAIT_CONFIRM_RECEIVE_GOODS_DAY));
		page.addParas("oc", oc);

		orderMapper.queryOrdersByPage(page);
		while (page.getPageNo() <= page.getTotalPage()) {
			List<Order> orderList = orderMapper.queryOrdersByPage(page);
			for (Order o : orderList) {
				MsgBean msg = orderService.handlerConfirmReceipt(o.getUserID(), o.getID());

				SystemTaskRecord r = new SystemTaskRecord();
				r.setType("订单确认收货明细");
				Date n = new Date();
				r.setStartTime(n);
				r.setEndTime(n);
				r.setContent("订单号【" + o.getOrderNO() + "】" + msg.getMsg());
				systemTaskRecordMapper.insert(r);
			}
			page.setPageNo(page.getPageNo() + 1);
		}

		record.setEndTime(new Date());
		record.setContent("订单收货");
		systemTaskRecordMapper.updateByPrimaryKey(record);
	}

	// @Scheduled(cron = "0/5 * *  * * ? ")
	// 每5秒执行一次
	public void test() {
		Date now = new Date();
		SystemTaskRecord record = new SystemTaskRecord();
		record.setType("test");
		record.setStartTime(now);
		systemTaskRecordMapper.insert(record);
		System.out.println(this.hashCode() + "task test : " + DateUtil.format(DateUtil.yyyy_MM_dd_HH_mm_ss));
		record.setEndTime(new Date());
		record.setContent("test");
		systemTaskRecordMapper.updateByPrimaryKey(record);
	}

}
