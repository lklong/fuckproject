/**
 * @ClassName: ITaobaoSKUService.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月18日
 * 
 */
package com.zhigu.service.taobao;

import java.util.List;

import com.taobao.api.ApiException;
import com.taobao.api.domain.Sku;
import com.zhigu.model.ConvertSkuModel;

/**
 * @author Administrator
 *
 */
public interface ITaobaoSKUService {

	public List<Sku> addItemSku(ConvertSkuModel model, Long numIId, String sessionKey) throws ApiException;

}
