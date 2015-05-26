package com.zhigu.common.utils.unionpay;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.LinkedList;
import java.util.ListIterator;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.httpclient.methods.PostMethod;

/**
 * 名称：支付工具类 功能：工具类，可以生成付款表单等 类属性：公共类 版本：1.0 日期：2011-03-11 作者：中国银联UPOP团队 版权：中国银联
 * 说明：以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。该代码仅供参考。
 * */
public class QuickPayUtils {

	/**
	 * 生成发送银联报文页面
	 * 
	 * @param map
	 * @param signature
	 * @return
	 */
	public String createPayHtml(String[] valueVo) {
		return createPayHtml(valueVo, null);
	}

	/**
	 * 直接跳转银行支付页面
	 * 
	 * @param map
	 * @param signature
	 * @return
	 */
	public String createPayHtml(String[] valueVo, String bank) {

		Map<String, String> map = new TreeMap<String, String>();
		for (int i = 0; i < QuickPayConf.reqVo.length; i++) {
			map.put(QuickPayConf.reqVo[i], valueVo[i]);
		}
		StringBuffer sb = new StringBuffer();
		sb.append("<script language=\"javascript\">window.onload=function(){document.pay_form.submit();}</script>");
		sb.append("<form id=\"pay_form\" name=\"pay_form\" action=\"").append(QuickPayConf.gateWay).append("\" method=\"post\">");
		for (Map.Entry<String, String> entry : map.entrySet()) {
			sb.append("<input type=\"hidden\" name=\"" + entry.getKey() + "\" id=\"" + entry.getKey() + "\" value=\"" + entry.getValue() + "\" />");
		}
		sb.append("<input type=\"hidden\" name=\"signature\" id=\"signature\" value=\"" + signMap(map, QuickPayConf.signType) + "\">");
		sb.append("<input type=\"hidden\" name=\"signMethod\" id=\"signMethod\" value=\"" + QuickPayConf.signType + "\" />");
		if (bank != null && !"".equals(bank)) {
			sb.append("<input type=\"hidden\" name=\"bank\" id=\"bank\" value=\"" + bank + "\" />");
		}
		sb.append("</form>");

		return sb.toString();
	}

	public String createBackStr(String[] valueVo, String[] keyVo) {

		Map<String, String> map = new TreeMap<String, String>();
		for (int i = 0; i < keyVo.length; i++) {
			map.put(keyVo[i], valueVo[i]);
		}
		map.put("signature", signMap(map, QuickPayConf.signType));
		map.put("signMethod", QuickPayConf.signType);
		return joinMapValue(map, '&');
	}

	/**
	 * 查询验证签名
	 * 
	 * @param valueVo
	 * @return 0:验证失败 1验证成功 2没有签名信息（报文格式不对）
	 */
	public int checkSecurity(String[] valueVo) {
		Map<String, String> map = new TreeMap<String, String>();
		for (int i = 0; i < valueVo.length; i++) {
			String[] keyValue = valueVo[i].split("=");
			map.put(keyValue[0], keyValue.length == 2 ? keyValue[1] : "");
		}
		if ("".equals(map.get("signature"))) {
			return 2;
		}
		if (QuickPayConf.signType.equalsIgnoreCase(map.get("signMethod"))) {
			String signature = map.get("signature");
			map.remove("signature");
			map.remove("signMethod");
			if (signature.equals(md5(joinMapValue(map, '&') + md5(QuickPayConf.securityKey)))) {
				return 1;
			} else {
				return 0;
			}

		} else {
			return 0;
		}

	}

	/**
	 * 生成加密钥
	 * 
	 * @param map
	 * @param secretKey
	 *            商城密钥
	 * @return
	 */
	private String signMap(Map<String, String> map, String signMethod) {
		if (QuickPayConf.signType.equalsIgnoreCase(signMethod)) {
			return md5(joinMapValue(map, '&') + md5(QuickPayConf.securityKey));
		} else {
			return "";
		}

	}

	/**
	 * 验证签名
	 * 
	 * @param map
	 * @param secretKey
	 *            商城密钥
	 * @return
	 */
	public boolean checkSign(String[] valueVo, String signMethod, String signature) {

		Map<String, String> map = new TreeMap<String, String>();
		for (int i = 0; i < QuickPayConf.notifyVo.length; i++) {
			map.put(QuickPayConf.notifyVo[i], valueVo[i]);
		}

		if (signature == null)
			return false;
		if (QuickPayConf.signType.equalsIgnoreCase(signMethod)) {
			System.out.println(">>>" + joinMapValue(map, '&') + md5(QuickPayConf.securityKey));
			return signature.equals(md5(joinMapValue(map, '&') + md5(QuickPayConf.securityKey)));
		} else {
			return false;
		}

	}

	private String joinMapValue(Map<String, String> map, char connector) {
		StringBuffer b = new StringBuffer();
		for (Map.Entry<String, String> entry : map.entrySet()) {
			b.append(entry.getKey());
			b.append('=');
			if (entry.getValue() != null) {
				b.append(entry.getValue());
			}
			b.append(connector);
		}
		return b.toString();
	}

	/**
	 * get the md5 hash of a string
	 * 
	 * @param str
	 * @return
	 */
	private String md5(String str) {

		if (str == null) {
			return null;
		}

		MessageDigest messageDigest = null;

		try {
			messageDigest = MessageDigest.getInstance(QuickPayConf.signType);
			messageDigest.reset();
			messageDigest.update(str.getBytes(QuickPayConf.charset));
		} catch (NoSuchAlgorithmException e) {

			return str;
		} catch (UnsupportedEncodingException e) {
			return str;
		}

		byte[] byteArray = messageDigest.digest();

		StringBuffer md5StrBuff = new StringBuffer();

		for (int i = 0; i < byteArray.length; i++) {
			if (Integer.toHexString(0xFF & byteArray[i]).length() == 1)
				md5StrBuff.append("0").append(Integer.toHexString(0xFF & byteArray[i]));
			else
				md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));
		}

		return md5StrBuff.toString();
	}

	// Clean up resources
	public void destroy() {
	}

	/**
	 * 查询方法
	 * 
	 * @param strURL
	 * @param req
	 * @return
	 */
	/*
	 * public String doPostQueryCmd(String strURL, String[] valueVo, String[]
	 * keyVo) {
	 * 
	 * 
	 * PostMethod post = null; try { post = (PostMethod) new
	 * UTF8PostMethod(strURL); //URL uRL = new URL(strURL);
	 * System.out.println("URL:" + strURL); post.setContentChunked(true);
	 * //post.setPath(uRL.getPath());
	 * 
	 * // Get HTTP client HttpClient httpclient = new HttpClient();
	 * 
	 * NameValuePair[] params = new NameValuePair[keyVo.length]; for (int i = 0;
	 * i < keyVo.length; i++) { params[i] = new NameValuePair(keyVo[i],
	 * valueVo[i]); }
	 * 
	 * //httpclient.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET
	 * ,QuickPayConf.charset);
	 * 
	 * post.setRequestBody(params);
	 * 
	 * // 设置超时时间 httpclient.setTimeout(30000);
	 * //httpclient.getHostConfiguration().setHost(uRL.getHost(),
	 * uRL.getPort());
	 * 
	 * int result = httpclient.executeMethod(post);
	 * 
	 * post.getRequestCharSet(); byte[] resultInputByte; if (result == 200) {
	 * resultInputByte = post.getResponseBody(); return new
	 * String(resultInputByte,QuickPayConf.charset); } else {
	 * System.out.println("返回错误"); } } catch (Exception ex) {
	 * System.out.println(ex); } finally { post.releaseConnection(); } return
	 * null; }
	 */

	/**
	 * 查询方法
	 * 
	 * @param strURL
	 * @param req
	 * @return
	 */
	public String doPostQueryCmd(String strURL, String req) {
		String result = null;
		BufferedInputStream in = null;
		BufferedOutputStream out = null;
		try {
			URL url = new URL(strURL);
			URLConnection con = url.openConnection();
			con.setUseCaches(false);
			con.setDoInput(true);
			con.setDoOutput(true);
			out = new BufferedOutputStream(con.getOutputStream());
			byte outBuf[] = req.getBytes(QuickPayConf.charset);
			out.write(outBuf);
			out.close();
			in = new BufferedInputStream(con.getInputStream());
			result = ReadByteStream(in);
		} catch (Exception ex) {
			return "";
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
				}
			}
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
				}
			}
		}
		if (result == null)
			return "";
		else
			return result;
	}

	private static String ReadByteStream(BufferedInputStream in) throws IOException {
		LinkedList<Mybuf> bufList = new LinkedList<Mybuf>();
		int size = 0;
		byte buf[];
		do {
			buf = new byte[128];
			int num = in.read(buf);
			if (num == -1)
				break;
			size += num;
			bufList.add(new Mybuf(buf, num));
		} while (true);
		buf = new byte[size];
		int pos = 0;
		for (ListIterator<Mybuf> p = bufList.listIterator(); p.hasNext();) {
			Mybuf b = p.next();
			for (int i = 0; i < b.size;) {
				buf[pos] = b.buf[i];
				i++;
				pos++;
			}

		}

		return new String(buf, QuickPayConf.charset);
	}

}

class UTF8PostMethod extends PostMethod {
	public UTF8PostMethod(String url) {
		super(url);
	}

	@Override
	public String getRequestCharSet() {
		return "UTF-8";
	}
}

class GBKPostMethod extends PostMethod {
	public GBKPostMethod(String url) {
		super(url);
	}

	@Override
	public String getRequestCharSet() {
		return "GBK";
	}
}

class Mybuf {

	public byte buf[];
	public int size;

	public Mybuf(byte b[], int s) {
		buf = b;
		size = s;
	}
}
