/**
 * @ClassName: ZhiguFileService.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月28日
 * 
 */
package com.zhigu.service.zhigufile;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.zhigu.model.dto.MsgBean;

/**
 * @author Administrator
 *
 */
public interface ZhiguFileService {

	/**
	 * 保存数据包
	 * 
	 * @param file
	 * @return
	 * @throws IOException
	 */
	MsgBean saveData(MultipartFile file) throws IOException;

	/**
	 * 保存图片
	 * 
	 * @param file
	 * @param type
	 * @param fileNamePrefix
	 * @return
	 * @throws IOException
	 */
	MsgBean saveImage(MultipartFile file, Integer type) throws IOException;

}
