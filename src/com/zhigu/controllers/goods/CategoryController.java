package com.zhigu.controllers.goods;

import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.taobao.api.ApiException;
import com.taobao.api.domain.ItemCat;
import com.zhigu.model.Category;
import com.zhigu.model.Property;
import com.zhigu.model.Result;
import com.zhigu.service.goods.ICategoryService;
import com.zhigu.service.taobao.ITaobaoCategoryService;

/**
 * 类别
 * 
 * @author zhouqibing 2014年9月28日下午6:21:11
 */
@Controller
@RequestMapping("/category")
public class CategoryController {
	@Autowired
	private ICategoryService categoryService;

	/**
	 * 商品类别初始化
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/choose")
	public ModelAndView preAdd(ModelAndView mv) {

		List<Category> properties = categoryService.queryCategoryByParent(0);
		mv.addObject("properties", properties);
		mv.setViewName("goods/category");
		return mv;
	}

	@RequestMapping("/getCategory")
	@ResponseBody
	public JSONArray getCategory(int catagoryId) {
		List<Category> categories = categoryService.queryCategoryByParent(catagoryId);
		return new JSONArray().fromObject(categories);
	}

	@RequestMapping("/loadProperty")
	public ModelAndView loadProperty(Integer categoryId, ModelAndView mv) {
		List<Property> properties = categoryService.queryPropertyByCategory(categoryId);
		mv.addObject("properties", properties);
		mv.setViewName("/supplier/goods/shoe/include");
		return mv;
	}

	@Autowired
	private ITaobaoCategoryService taobaoCategoryService;

	@RequestMapping("/tbcategory")
	@ResponseBody
	public Result getTBCategory(Integer type, Long pid) {

		Boolean status = true;

		List<ItemCat> cats = null;

		try {

			cats = taobaoCategoryService.getCats(pid);

		} catch (ApiException e) {

			status = false;

		}

		return new Result(status, cats);

	}

	@RequestMapping("/getcat")
	@ResponseBody
	public Result getCategory(Integer pid) {

		Boolean status = true;

		List<Category> cats = categoryService.queryCategoryByParent(pid);

		return new Result(status, cats);

	}
}
