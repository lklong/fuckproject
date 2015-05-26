package test.junit;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.zhigu.service.open.IOpenAuthService;

@RunWith(SpringJUnit4ClassRunner.class)
// 指定测试用例的运行器 这里是指定了Junit4
@ContextConfiguration({ "/spring-service.xml" })
// 指定Spring的配置文件 /为classpath下
// @Transactional //对所有的测试方法都使用事务，并在测试完成后回滚事务
public class Testj {
	// @Autowired
	// private ApplicationContext appplicationContext;
	// 自动注入applicationContext，这样就可以使用appli*.getBean("beanName")
	// @Resource
	// 会自动注入 default by type
	// private ICommodityService commodityService;
	@Autowired
	private IOpenAuthService openAuthService;

	@Test
	@Transactional
	// 使用该注释会使用事务，而且在测试完成之后会回滚事务
	@Rollback(false)
	// 这里设置为false，就让事务不回滚
	public void testAdd() {
		System.out.println(openAuthService.saveOpenAuth("450453494@qq.com", "123", "123456"));
	}

	@Test
	@Rollback(false)
	public void testTest() {
		// SystemAccount acc = new SystemAccount();
		// acc.setCreateTime(new Date());
		// acc.setMatter("test");
		// acc.setMoney(new BigDecimal("5.00"));
		// acc.setSno("123");
		// acc.setType(true);
		// acc.setUserId(1);
		// System.out.println(systemAccMapper.insert(acc));
		// PageBean page = new PageBean();
		// page.setPageSize(5);
		// System.out.println("-->" + JSON.toJSON(page));
		// System.out.println(JSON.toJSON(accountDetailMapper.queryAccountDetailListByPage(page,
		// null, null, new Date())));
		// System.out.println(JSON.toJSON(page));
	}

	@Before
	// 在每个测试用例方法之前都会执行
	public void init() {
	}

	@After
	// 在每个测试用例执行完之后执行
	public void destory() {
	}

	private String process(String desc) {
		Document doc = Jsoup.parse(desc);
		Elements imgs = doc.select("img[src]");
		for (Element img : imgs) {
			String src = img.attr("src");
			img.attr("data-original", src).addClass("lazy").removeAttr("src");
		}
		return doc.getElementsByTag("body").html();
	}

	@Test
	public void test() {
		String desc = "dfafadsf<img src=\"jjj.jpg\">asdfasdf<img src=\"uuu.jpg\"><input/>";
		String dec = process(desc);
		System.out.println(dec);
	}
}
