/**
 * @ClassName: AdminDataManagerController.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月14日
 * 
 */
package com.zhigu.controllers.admin;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.taobao.api.ApiException;
import com.taobao.api.domain.ItemProp;
import com.taobao.api.domain.PropValue;
import com.zhigu.common.constant.enumconst.PlatType;
import com.zhigu.model.Category;
import com.zhigu.model.CategoryRef;
import com.zhigu.model.Property;
import com.zhigu.model.PropertyRef;
import com.zhigu.model.PropertyValue;
import com.zhigu.model.Result;
import com.zhigu.model.ValueRef;
import com.zhigu.service.data.CategoryRefService;
import com.zhigu.service.data.PropertyRefService;
import com.zhigu.service.data.PropertyService;
import com.zhigu.service.data.PropertyValueService;
import com.zhigu.service.data.ValueRefService;
import com.zhigu.service.goods.ICategoryService;
import com.zhigu.service.taobao.ITaobaoCategoryService;
import com.zhigu.service.taobao.ITaobaoItemPropService;

/**
 * @author Administrator 数据中心管理控制器
 */
@Controller
@RequestMapping("/admin/data")
public class AdminDataManagerController {

	/** 日志 */
	private static final Logger LOGGER = Logger.getLogger(AdminDataManagerController.class);

	/** 页面目录 */
	private static final String FOLDER = "admin/data/";

	@Autowired
	private ICategoryService categoryService;

	@Autowired
	private ITaobaoCategoryService taobaoCategoryService;

	@Autowired
	private CategoryRefService categoryRefService;

	@Autowired
	private PropertyService propertyService;

	@Autowired
	private ITaobaoItemPropService taobaoItemPropService;

	@Autowired
	private PropertyRefService propertyRefService;

	@Autowired
	private PropertyValueService propertyValueService;

	@Autowired
	private ValueRefService valueRefService;

	/**
	 * 类目管理列表
	 * 
	 * @param model
	 * @return
	 * @throws ApiException
	 */
	@RequestMapping("/category")
	public String manCategory(ModelMap model) throws ApiException {

		model.addAttribute("tbcategory", taobaoCategoryService.getCats(0L));

		model.addAttribute("category", categoryService.queryCategoryByParent(0));

		model.addAttribute("categorys", categoryService.queryAll());

		return FOLDER + "category";
	}

	/**
	 * 添加类目
	 * 
	 * @param name
	 * @param isParent
	 * @param code
	 * @param parentId
	 * @return
	 */
	@RequestMapping(value = "/category/save", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Result saveCategory(String name, Boolean isParent, String code, Integer parentId) {

		String msg = "添加成功";

		Boolean status = true;

		Category category = new Category();

		try {

			// 业务处理 保存类目，类目映射
			category = categoryService.addCategoryAndRef(name, isParent, code, parentId);

		} catch (Exception e) {

			msg = "失败";

			status = false;

			return new Result(status, msg);

		}

		return new Result(status, msg, category);
	}

	/**
	 * 属性管理
	 * 
	 * @param catId
	 * @param model
	 * @return
	 * @throws ApiException
	 */
	@RequestMapping("/property")
	public String manProperty(Integer catId, ModelMap model) throws ApiException {

		// 加载该类目数据
		Category category = categoryService.queryCategoryById(catId);

		// 加载淘宝类目
		model.addAttribute("tbcategory", taobaoCategoryService.getCats(0L));

		model.addAttribute("category", category);

		model.addAttribute("props", propertyService.queryPropsByCatId(catId));

		return FOLDER + "property";
	}

	/**
	 * 添加属性
	 * 
	 * @param prop
	 * @param catId
	 * @param pid
	 * @param pname
	 * @return
	 */
	@RequestMapping("/propperty/save")
	@ResponseBody
	public Result saveProperty(Property prop, Integer catId, Long pid, String pname) {

		String msg = "success";

		Boolean status = true;

		try {

			// 业务处理 保存属性，关系，属性映射
			propertyService.addPropAndRef(prop, catId, pid, pname);

		} catch (Exception e) {

			msg = "fail";

			status = false;

			LOGGER.error(e.getMessage());
		}

		return new Result(status, msg, prop);

	}

	/**
	 * 属性值管理
	 * 
	 * @param model
	 * @return
	 * @throws ApiException
	 */
	@RequestMapping("/value")
	public String manValue(ModelMap model) throws ApiException {

		model.addAttribute("category", categoryService.queryCategoryByParent(0));

		model.addAttribute("tbcategory", taobaoCategoryService.getCats(0L));

		return FOLDER + "value";
	}

	/**
	 * 添加属性值并且添加与第三方平台的映射
	 * 
	 * @param type
	 *            第三方平台类型
	 * @param propID
	 *            属性ID
	 * @param name
	 *            属性值名称
	 * @param cid
	 *            类目ID
	 * @param tbpvid
	 *            第三方平台属性值ID
	 * @param tbpvname
	 *            第三方平台属性值名称
	 * @return 返回添加结果
	 */
	@RequestMapping(value = "/value/save", method = RequestMethod.POST)
	@ResponseBody
	public Result addPropValueRef(Integer type, Integer propID, String name, Integer cid, Integer tbpvid, String tbpvname) {
		Boolean flag = false;

		PropertyValue prov = new PropertyValue();
		prov.setName(name);
		prov.setPropertyId(propID);
		prov.setStatus(1);
		propertyValueService.add(prov);
		if (prov.getId() > 0) {
			flag = true;
		}

		return new Result(flag, prov);

	}

	/**
	 * 类目映射管理
	 * 
	 * @param model
	 * @return
	 * @throws ApiException
	 */
	@RequestMapping(value = "/categoryref", method = RequestMethod.GET)
	public String manInitCategoryRef(ModelMap model) throws ApiException {

		model.addAttribute("category", categoryService.queryCategoryByParent(0));

		model.addAttribute("tbcategory", taobaoCategoryService.getCats(0L));

		model.addAttribute("catrefs", categoryRefService.selectAll());

		return FOLDER + "categoryref";
	}

	/**
	 * 生成类目映射
	 * 
	 * @param ref
	 * @return
	 */
	@RequestMapping(value = "/categoryref", method = RequestMethod.POST)
	@ResponseBody
	public Result manCategoryRef(CategoryRef ref) {

		ref = categoryRefService.add(ref);

		return new Result(true, ref);

	}

	/**
	 * 删除类目映射
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/delete/catref", method = RequestMethod.GET)
	@ResponseBody
	public Result deleteCatRef(Integer id) {

		categoryRefService.deleteByPrimaryKey(id);

		return new Result(true);
	}

	/**
	 * 属性映射管理
	 * 
	 * @param id
	 * @param model
	 * @return
	 * @throws ApiException
	 */
	@RequestMapping(value = "/propertyref", method = RequestMethod.GET)
	public String manInitPropertyRef(Integer id, ModelMap model) throws ApiException {

		CategoryRef ref = categoryRefService.getById(id);

		model.addAttribute("catRef", ref);

		// 1.加载智谷类目属性
		Integer catId = Integer.parseInt(ref.getCategoryID().toString());

		List<Property> props = propertyService.selectPropByCatId(catId);

		model.addAttribute("props", props);

		// 2.加载淘宝类目属性
		Integer platType = ref.getThirdPlatType();

		Long cid = ref.getThirdCatID();

		if (platType == PlatType.Taobao.getType()) {

			List<ItemProp> itemProps = taobaoItemPropService.getItemProp(cid);

			model.addAttribute("itemProps", itemProps);

		} else if (platType == PlatType.Alibaba.getType()) {

			// TODO

		}

		model.addAttribute("proprefs", propertyRefService.selectByCatId(catId, cid));

		return FOLDER + "propertyref";
	}

	/**
	 * 删除属性映射
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/delete/propref", method = RequestMethod.GET)
	@ResponseBody
	public Result deletePropRef(Integer id) {

		propertyRefService.deleteByPrimaryKey(id);

		return new Result(true);
	}

	/**
	 * 添加属性映射
	 * 
	 * @param ref
	 * @param refId
	 * @return
	 */
	@RequestMapping(value = "/propertyref", method = RequestMethod.POST)
	@ResponseBody
	public Result manPropertyRef(PropertyRef ref, Integer refId) {

		CategoryRef catRef = categoryRefService.getById(refId);

		ref.setCategoryID(catRef.getCategoryID());

		ref.setThirdCatID(catRef.getThirdCatID());

		ref.setThirdPlatType(catRef.getThirdPlatType());

		propertyRefService.insertSelective(ref);

		return new Result(true, ref);
	}

	/**
	 * 属性值映射管理
	 * 
	 * @param refId
	 * @param model
	 * @return
	 * @throws ApiException
	 */
	@RequestMapping(value = "/valueref", method = RequestMethod.GET)
	public String manInitValueRef(Integer refId, ModelMap model) throws ApiException {

		PropertyRef propRef = propertyRefService.selectByPrimaryKey(refId);

		model.addAttribute("propRef", propRef);

		// 获取平台属性值
		Integer propId = Integer.parseInt(propRef.getCategoryPropID().toString());

		List<PropertyValue> propValues = propertyValueService.queryPropertyValue(propId);

		model.addAttribute("propValues", propValues);

		// 平台类型
		Integer platType = propRef.getThirdPlatType();

		// 获取第三方属性值
		Long thirdPropId = propRef.getThirdCatPropID();

		Long thirdCatId = propRef.getThirdCatID();

		if (platType == PlatType.Taobao.getType()) {

			List<PropValue> thirdPropValues = taobaoItemPropService.getPropValues(thirdCatId, thirdPropId);

			model.addAttribute("thirdPropValues", thirdPropValues);

		} else if (platType == PlatType.Alibaba.getType()) {

			// TODO

		}

		List<ValueRef> valueRefs = valueRefService.selectPropValueRefs(refId);

		model.addAttribute("valueRefs", valueRefs);

		return FOLDER + "valueref";

	}

	/**
	 * 添加属性值映射
	 * 
	 * @param ref
	 * @return
	 */
	@RequestMapping(value = "/valueref", method = RequestMethod.POST)
	@ResponseBody
	public Result manValueRef(ValueRef ref) {

		valueRefService.insertSelective(ref);

		return new Result(true, ref);

	}

	/**
	 * 删除属性值映射
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/delete/valueref", method = RequestMethod.GET)
	@ResponseBody
	public Result deleteValueRef(Integer id) {

		valueRefService.deleteByPrimaryKey(id);

		return new Result(true);
	}

	/**
	 * 根据类目id获取属性
	 * 
	 * @param type
	 * @param pid
	 * @return
	 */
	@RequestMapping("/getProperty")
	@ResponseBody
	public Result getProperty(Integer type, Integer cid) {

		List<Property> cats = categoryService.queryPropertyByCategory(cid);

		return new Result(true, cats);
	}

	/**
	 * 根据属性id获取属性值
	 * 
	 * @param type
	 * @param pid
	 * @return
	 */
	@RequestMapping("/getPropertyValueList")
	@ResponseBody
	public Result getPropertyValueList(Integer pid) {

		List<PropertyValue> pvalue = propertyValueService.queryPropertyValue(pid);

		return new Result(true, pvalue);
	}

	/**
	 * 根据类目id获取属性（第三方）
	 * 
	 * @param type
	 * @param pid
	 * @return
	 * @throws ApiException
	 */
	@RequestMapping("/getTbPropertyList")
	@ResponseBody
	public Result getTbPropertyList(Integer tbcid) throws ApiException {

		List<ItemProp> itemProps = taobaoItemPropService.getItemProp((Long.valueOf(tbcid)));

		return new Result(true, itemProps);
	}

	/**
	 * 根据属性id获取属性值(第三方)
	 *
	 * @param type
	 *            淘宝 或 阿里巴巴
	 * @param pid
	 *            属性ID
	 * @return
	 * @throws ApiException
	 */
	@RequestMapping("/getTbPropertyValues")
	@ResponseBody
	public Result getTbPropertyValues(Integer type, Integer tbcid, Integer tbpid) throws ApiException {

		List<PropValue> propValue = taobaoItemPropService.getPropValues(Long.valueOf(tbcid), Long.valueOf(tbpid));

		return new Result(true, propValue);
	}

}
