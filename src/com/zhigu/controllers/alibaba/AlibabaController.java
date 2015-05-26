/**
 * 
 */
package com.zhigu.controllers.alibaba;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zhigu.common.alibaba.AlibabaConfig;
import com.zhigu.common.alibaba.AlibabaUtil;
import com.zhigu.common.utils.taobao.FileUtil;
import com.zhigu.model.Goods;
import com.zhigu.model.alibaba.Product;
import com.zhigu.model.alibaba.ProductPropList;
import com.zhigu.service.alibaba.AliDeliveryAddressService;
import com.zhigu.service.alibaba.AliItemCategoryService;
import com.zhigu.service.alibaba.AliItemPropService;
import com.zhigu.service.alibaba.AliItemService;
import com.zhigu.service.alibaba.AliPhotoAlbumService;
import com.zhigu.service.alibaba.AliUserService;
import com.zhigu.service.goods.IGoodsService;

/**
 * @author lkl
 *
 */
@Controller
@RequestMapping("/alibaba")
public class AlibabaController {

	@Autowired
	private AliItemCategoryService itemCategoryService;

	@Autowired
	private IGoodsService goodsService;

	@Autowired
	private AliItemCategoryService aliItemCategoryService;

	@Autowired
	private AliItemPropService aliItemPropService;

	@Autowired
	private AliPhotoAlbumService aliPhotoAlbumService;

	@Autowired
	private AliUserService aliUserService;

	@Autowired
	private AliItemService aliItemService;

	@Autowired
	private AliDeliveryAddressService aliDeliveryAddressService;

	@RequestMapping("/auth")
	public String getAuth(String goodsId) {

		String url = AlibabaUtil.getCodeUrl(goodsId);

		return "redirect:" + url;

	}

	@RequestMapping("/category/choose")
	public String initCategory(String code, String state, ModelMap model) throws IOException {

		model.addAttribute("code", code);

		model.addAttribute("goodsId", state);

		return "/alibaba/category";
	}

	@RequestMapping("/publish")
	public String initPublish(String code, Integer goodsId, Long cid, ModelMap model) throws IOException, InterruptedException, ExecutionException, TimeoutException {

		Goods goods = goodsService.queryGoods(goodsId);

		String token = AlibabaUtil.getTokenFromStore(code);

		model.addAttribute("goods", goods);

		model.addAttribute("goodsImages", JSONArray.fromObject(goods.getImages()));

		model.addAttribute("tradeProps", aliItemPropService.getCateTradeProps(cid, token));

		model.addAttribute("catProps", aliItemPropService.getItemCateProps(cid, token));

		model.addAttribute("user", aliUserService.getUser(code));

		model.addAttribute("addrList", aliDeliveryAddressService.getSendAddressList(token));

		model.addAttribute("templates", JSONArray.fromObject(aliDeliveryAddressService.getDeliveryTemplateList(token)));

		model.addAttribute("cid", cid);

		model.addAttribute("paths", aliItemCategoryService.getItemCatPath(cid, token));

		model.addAttribute("code", code);

		return "/alibaba/publish";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/save")
	@ResponseBody
	public com.zhigu.common.taobao.JSONObject publish(String code, ProductPropList propList, HttpServletRequest request, String match, String main, Product product) throws IOException,
			InterruptedException, ExecutionException, TimeoutException {

		String token = AlibabaUtil.getTokenFromStore(code);

		// 价格区间处理
		String ranges = "";

		List<String> priceRanges = propList.getPriceranges();

		List<String> numRanges = propList.getNumRanges();

		if (priceRanges != null && numRanges != null && priceRanges.size() > 0 && numRanges.size() > 0) {

			for (int k = 0; k < numRanges.size(); k++) {

				if (k + 1 == numRanges.size())

					ranges += numRanges.get(k) + ":" + priceRanges.get(k);

				else

					ranges += numRanges.get(k) + ":" + priceRanges.get(k) + "`";

			}

		}

		product.setPriceRanges(ranges);

		// 属性处理
		Map<String, String[]> map = request.getParameterMap();

		Set<String> set = map.keySet();

		Iterator<String> it = set.iterator();

		Map<String, String> attrs = new HashMap<String, String>();

		while (it.hasNext()) {

			String key = it.next();

			if (key.contains("feature")) {

				String[] value = map.get(key);

				for (int j = 0; j < value.length; j++) {

					if (StringUtils.isNotBlank(value[j])) {

						String co = ",";

						String val = attrs.get(key);

						if (StringUtils.isNotBlank(val)) {

							val = val + co + value[j];

							attrs.put(key, val);

						} else {

							attrs.put(key, value[j]);

						}

					}

				}

			}

		}

		JSONObject jsonObject = JSONObject.fromObject(attrs);

		String attr = jsonObject.toString();

		attr = attr.replaceAll("\\[\\]", "").replaceAll("feature_", "").replace("\\s", "");

		// product.setProductFeatures(JSONObject.fromObject(attr));

		// 颜色配图处理
		String[] matchImages = match.split("\\|");

		Map<String, String> map2 = null;

		List<Map<String, String>> list = new ArrayList<Map<String, String>>();

		Map<String, List<Map<String, String>>> mapsku = new HashMap<String, List<Map<String, String>>>();

		Long albumId = aliPhotoAlbumService.createPhotoAlbum("zhigu", token);

		if (StringUtils.isNotBlank(match)) {

			for (int i = 0; i < matchImages.length; i++) {

				map2 = new HashMap<String, String>();

				String[] imges = matchImages[i].split("#");

				String url = uploadFile(imges[1], token, albumId);

				map2.put(imges[0], url);

				list.add(map2);

			}
		}

		mapsku.put("3216", list);

		product.setSkuPics(mapsku);

		// 主图处理
		List<String> mainpic = Arrays.asList(main.split("\\|"));

		List<String> mainPics = new ArrayList<String>();

		for (int t = 0; t < mainpic.size(); t++) {

			String url = uploadFile(mainpic.get(t), token, albumId);

			mainPics.add(url);

		}

		product.setImageUriList(mainPics);

		// 描述图片处理
		String desc = parserDesc(product.getOfferDetail(), token, albumId);

		product.setOfferDetail(desc);

		// 转json
		JSONObject jsonPro = JSONObject.fromObject(product);

		String json = jsonPro.toString();

		String data = "";

		String msg = "上传成功！";

		Boolean status = true;

		// 保存
		try {

			String id = aliItemService.addAlibabaItem(json, token);

			data = AlibabaConfig.product_url + id + AlibabaConfig.suffix;

		} catch (InterruptedException | ExecutionException | TimeoutException e) {

			msg = "上传到阿里时，网络超时！";

			status = false;

			e.printStackTrace();

		}

		return new com.zhigu.common.taobao.JSONObject(msg, data, status);
	}

	/**
	 * 处理描述
	 * 
	 * @param desc
	 * @param token
	 * @param albumId
	 * @return
	 * @throws MalformedURLException
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 * @throws IOException
	 */
	private String parserDesc(String desc, String token, Long albumId) throws MalformedURLException, InterruptedException, ExecutionException, TimeoutException, IOException {

		Document doc = Jsoup.parse(desc, "UTF-8");

		Elements imgs = doc.select("img"); // 具有href 属性的链接

		for (Element imgTag : imgs) {

			String src = imgTag.attr("src");

			// 上传图片
			String newSrc = uploadFile(src, token, albumId);

			// 替换图片
			imgTag.attr("src", newSrc);

		}

		return doc.getElementsByTag("body").html();

	}

	/**
	 * 图片上传
	 * 
	 * @param url
	 * @param token
	 * @param albumId
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 * @throws MalformedURLException
	 * @throws IOException
	 */
	private String uploadFile(String url, String token, Long albumId) throws InterruptedException, ExecutionException, TimeoutException, MalformedURLException, IOException {

		if (StringUtils.isBlank(url)) {

			return "";

		}

		if (url.contains("http://img.china.alibaba.com")) {

			return url;

		}

		byte[] bytes = FileUtil.downloadToByteArray(url);

		String name = System.currentTimeMillis() + "";

		String newUrl = aliPhotoAlbumService.uploadPhoto(albumId, name, bytes, token);

		return newUrl;

	}

	@RequestMapping("/leaf")
	@ResponseBody
	public ArrayList<Map<String, Object>> getCats(Long cid, String code) throws IOException, InterruptedException, ExecutionException, TimeoutException {

		String token = AlibabaUtil.getTokenFromStore(code);

		ArrayList<Map<String, Object>> leafs = itemCategoryService.getAliCategories(cid, token);

		return leafs;
	}

	@RequestMapping("/cat/spu")
	@ResponseBody
	public JSONArray getCatsSPU(Long cid, String path) throws IOException, InterruptedException, ExecutionException, TimeoutException {

		JSONArray spus = aliItemPropService.getChildrenProps(cid, path);

		return spus;
	}

	@ResponseBody
	@RequestMapping("/file/upload")
	public String uploadToAli(@RequestParam("userfile") MultipartFile file, String code) {

		try {

			if (!file.isEmpty()) {

				String token = AlibabaUtil.getTokenFromStore(code);

				Long albumId = aliPhotoAlbumService.createPhotoAlbum("zhigu", token);

				String name = file.getOriginalFilename();

				byte[] bytes = file.getBytes();

				String url = aliPhotoAlbumService.uploadPhoto(albumId, name, bytes, token);

				return "<script language=\"JavaScript\"> parent.uploadEnd(\'" + url + "\') </script>";
			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		return "<script language=\"JavaScript\"> parent.uploadEnd(\'" + JSONObject.fromObject(new com.zhigu.common.taobao.JSONObject("failed", null, false)).toString() + "\') </script>";

	}

}
