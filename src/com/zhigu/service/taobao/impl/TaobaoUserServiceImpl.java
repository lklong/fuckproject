/**
 * @ClassName: TaobaoUserServiceImpl.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年5月27日
 * 
 */
package com.zhigu.service.taobao.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.TaobaoUserMapper;
import com.zhigu.model.TaobaoUser;
import com.zhigu.service.taobao.ITaobaoUserService;

/**
 * @author Administrator
 *
 */
@Service
public class TaobaoUserServiceImpl implements ITaobaoUserService {

	@Autowired
	private TaobaoUserMapper taobaoUserMapper;

	@Override
	public int insertSelective(TaobaoUser user) {
		return taobaoUserMapper.insertSelective(user);

	}

	@Override
	public TaobaoUser selectByUid(String uid) {
		return taobaoUserMapper.selectByPrimaryKey(uid);
	}

}
