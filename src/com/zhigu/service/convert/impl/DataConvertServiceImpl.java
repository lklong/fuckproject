/**
 * @ClassName: DataConvertServiceImpl.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月16日
 * 
 */
package com.zhigu.service.convert.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.commons.beanutils.BeanComparator;
import org.apache.commons.collections.ComparatorUtils;
import org.apache.commons.collections.comparators.ComparableComparator;
import org.apache.commons.collections.comparators.ComparatorChain;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taobao.api.domain.ItemProp;
import com.zhigu.common.constant.enumconst.PlatType;
import com.zhigu.mapper.CategoryRefMapper;
import com.zhigu.mapper.PropertyRefMapper;
import com.zhigu.mapper.ValueRefMapper;
import com.zhigu.model.CategoryRef;
import com.zhigu.model.ConvertModel;
import com.zhigu.model.ConvertSkuModel;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsProperty;
import com.zhigu.model.GoodsSku;
import com.zhigu.model.PropertyRef;
import com.zhigu.model.ValueRef;
import com.zhigu.service.convert.DataConvertService;
import com.zhigu.service.taobao.ITaobaoItemPropService;

/**
 * @author Administrator
 *
 */
@Service
public class DataConvertServiceImpl implements DataConvertService {

	/**
	 * 正序
	 */
	public static final String SORT_ORDER_ASC = "asc";

	/**
	 * 逆序
	 */
	public static final String SORT_ORDER_DESC = "desc";

	@Autowired
	private CategoryRefMapper categoryRefMapper;

	@Autowired
	private PropertyRefMapper propertyRefMapper;

	@Autowired
	private ValueRefMapper propValueRefMapper;

	@Autowired
	private ITaobaoItemPropService taobaoItemPropService;

	@Override
	public List<ConvertModel> convertProperty(Goods goods, Integer type, CategoryRef catRef) {

		Integer catId = goods.getCategoryId();

		List<GoodsProperty> props = goods.getProperties();

		List<ConvertModel> models = new ArrayList<ConvertModel>();

		// 淘宝类目id,类目名称
		Long thirdCatId = catRef.getThirdCatID();

		String thirdCatName = catRef.getThirdCatName();

		for (GoodsProperty prop : props) {

			Integer propId = prop.getPropertyId();

			Integer valueId = prop.getPropertyValueId();

			if (type == PlatType.Taobao.getType()) {

				ConvertModel model = cobinModel(prop, catId, propId, valueId, thirdCatId);
				if (model != null) {
					model.setCatName(thirdCatName);
					models.add(model);
				}

			} else if (type == PlatType.Alibaba.getType()) {

				// 转阿里巴巴数据 TODO

			}

		}

		return models;
	}

	public List<ConvertSkuModel> convertSku(Goods goods, Integer type, CategoryRef catRef) {

		Integer catId = goods.getCategoryId();

		// 淘宝类目id,类目名称
		Long thirdCatId = catRef.getThirdCatID();

		String thirdCatName = catRef.getThirdCatName();

		List<GoodsSku> skus = goods.getSkus();

		List<ConvertSkuModel> skuModels = new ArrayList<ConvertSkuModel>();

		if (type.equals(PlatType.Taobao.getType())) {

			for (GoodsSku sku : skus) {
				ConvertSkuModel skuModel = new ConvertSkuModel();

				Integer skuId = sku.getId();

				String propStr = sku.getPropertyStr();
				String[] propCobins = propStr.split(",");

				String _propStr = "";
				List<ConvertModel> models = null;
				if (propCobins != null) {

					// 对颜色特殊处理
					if (propCobins.length > 1 && propCobins[1].startsWith("18")) {
						String temp = propCobins[0];
						propCobins[0] = propCobins[1];
						propCobins[1] = temp;
					}

					models = new ArrayList<ConvertModel>();

					for (String cobin : propCobins) {

						Integer _propId = Integer.parseInt(cobin.split(":")[0]);
						Integer _valueId = Integer.parseInt(cobin.split(":")[1]);
						ConvertModel model = cobinModel(null, catId, _propId, _valueId, thirdCatId);
						if (model != null) {
							model.setCatName(thirdCatName);
							_propStr += model.getPropId() + ":" + model.getValueId() + ";";
							models.add(model);
						}

					}
				}
				skuModel.setPropIdStr(_propStr.substring(0, _propStr.length() - 1));
				skuModel.setPlatSkuId(skuId);
				skuModel.setPrice(sku.getPrice());
				skuModel.setQuality(sku.getAmount());
				skuModel.setModels(models);

				skuModels.add(skuModel);

			}

		} else if (type == PlatType.Alibaba.getType()) {

			// 转阿里巴巴数据 TODO

		}

		sortTheList(skuModels, "propIdStr", SORT_ORDER_ASC);

		return skuModels;

	}

	/**
	 * 属性包装
	 * 
	 * @param catId
	 * @param propId
	 * @param valueId
	 * @param thirdCatId
	 * @return
	 */
	private ConvertModel cobinModel(GoodsProperty prop, Integer catId, Integer propId, Integer valueId, Long thirdCatId) {

		// 根据类目和属性id 获取refid，淘宝属性id,属性名称
		PropertyRef propRef = propertyRefMapper.selectTBPropByPlat(catId, propId);
		if (propRef != null) {
			Long thirdPropId = propRef.getThirdCatPropID();
			String thirdPropName = propRef.getCatPropName();
			Integer refId = propRef.getId();

			// 获取属性的附加信息
			ItemProp itemProp = taobaoItemPropService.getProp(thirdCatId, thirdPropId);

			ConvertModel model = new ConvertModel();
			// 主要信息
			model.setCatId(thirdCatId);
			model.setPropId(thirdPropId);
			model.setPropName(thirdPropName);

			// 附加信息
			model.setIsColorProp(itemProp.getIsColorProp());
			model.setIsEnumProp(itemProp.getIsEnumProp());
			model.setIsInputProp(itemProp.getIsInputProp());
			model.setIsKeyProp(itemProp.getIsKeyProp());
			model.setIsSaleProp(itemProp.getIsSaleProp());
			model.setIsItemProp(itemProp.getIsItemProp());
			model.setType(itemProp.getType());
			model.setIsMulti(itemProp.getMulti());

			if (valueId != -1) {

				// 根据refid,valueId 获取淘宝属性值id，属性值名称
				ValueRef valueRef = propValueRefMapper.selectTBValueByPlat(refId, valueId);

				if (valueRef != null) {
					Long thirdValueId = valueRef.getThirdPropVID();
					String thirdValueName = valueRef.getValueName();

					model.setValueId(thirdValueId);
					model.setValueName(thirdValueName);
				}
			} else {// 输入属性处理
				model.setValueId(Long.valueOf(valueId));
				model.setValueName(prop.getPropertyValueName());
			}

			return model;

		}
		return null;
	}

	/**
	 * 方法名称：sortTheList 内容摘要：根据指定的字段数组对List中的对象进行排序
	 * 
	 * @param <T>
	 * 
	 * @param list
	 * @param sortFields
	 * @param sortOrder
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private static <T> void sortTheList(List<T> list, String[] sortFields, String sortOrder) {
		if (sortFields == null || sortFields.length <= 0) {
			return;
		}

		ArrayList<T> sorts = new ArrayList<T>();

		Comparator c = ComparableComparator.getInstance();
		c = ComparatorUtils.nullLowComparator(c); // 允许null
		if (SORT_ORDER_DESC.equalsIgnoreCase(sortOrder)) {
			c = ComparatorUtils.reversedComparator(c); // 逆序
		}

		String sortField = null;
		for (int i = 0; i < sortFields.length; i++) {
			sortField = sortFields[i];
			if (StringUtils.isNotEmpty(sortField)) {
				sorts.add((T) new BeanComparator(sortField, c));
			}
		}

		ComparatorChain multiSort = new ComparatorChain(sorts);

		Collections.sort(list, multiSort);
	}

	/**
	 * 方法名称：sortTheList 内容摘要：根据指定的字段对List中的对象进行排序
	 * 
	 * @param <T>
	 * 
	 * @param list
	 * @param sortFiled
	 * @param sortOrder
	 */
	@SuppressWarnings({ "unchecked", "unchecked" })
	private static <T> void sortTheList(List<T> list, String sortFiled, String sortOrder) {
		if (StringUtils.isEmpty(sortFiled)) {
			return;
		}

		String[] sortFields = new String[] { sortFiled };

		sortTheList(list, sortFields, sortOrder);
	}

}
