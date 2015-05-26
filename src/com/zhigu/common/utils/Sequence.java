package com.zhigu.common.utils;

import org.springframework.context.ApplicationContext;

import com.zhigu.common.constant.SequenceConstant;
import com.zhigu.common.utils.StringUtil.RandomType;
import com.zhigu.mapper.OrderMapper;

/**
 * 序号
 * 
 * @author zhouqibing 2014年8月9日上午11:05:43
 */
public class Sequence {
	/**
	 * 自增序号
	 * 
	 * @param type
	 * @param length
	 * @return
	 */
	private static String getSequence(SequenceConstant sc, int length) {
		ApplicationContext context = SpringContextUtil.getApplicationContext();
		OrderMapper orderDao = context.getBean(OrderMapper.class);
		return orderDao.sequence(sc.getValue(), length);
	}

	/**
	 * 生成序列号
	 * 
	 * @return
	 */
	public static String generateSeq(SequenceConstant sc) {
		if (sc == SequenceConstant.ORDER) {
			return getSequence(sc, 6) + StringUtil.randomStr(RandomType.NUMBER, 3);
		} else if (sc == SequenceConstant.FLOW) {
			return getSequence(sc, 0);
		}

		return generateSeq(SequenceConstant.FLOW);
	}

}
