/**
 * @ClassName: DataConvert.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月16日
 * 
 */
package com.zhigu.service.convert;

import java.util.List;

import com.zhigu.model.CategoryRef;
import com.zhigu.model.ConvertModel;
import com.zhigu.model.ConvertSkuModel;
import com.zhigu.model.Goods;

/**
 * @author Administrator
 *
 */
public interface DataConvertService {

	/**
	 * 属性处理
	 * 
	 * @param goods
	 * @param type
	 * @return
	 */
	List<ConvertModel> convertProperty(Goods goods, Integer type, CategoryRef catRef);

	/**
	 * sku 属性处理
	 * 
	 * @param goods
	 * @param type
	 * @return
	 */
	List<ConvertSkuModel> convertSku(Goods goods, Integer type, CategoryRef catRef);

}
