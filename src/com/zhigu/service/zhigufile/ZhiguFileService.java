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
	 * 文件处理，保存
	 * 
	 * @param file
	 * @param specs
	 * @param specType
	 * @return
	 * @throws IOException
	 */
	MsgBean saveImage2(MultipartFile file, String[] specs, String specType, Integer minWidth, Integer maxWidth, String fileNamePrefix) throws IOException;

	/**
	 * 保存数据包
	 * 
	 * @param file
	 * @return
	 * @throws IOException
	 */
	MsgBean saveData(MultipartFile file) throws IOException;

//	MsgBean saveImage(MultipartFile file, String[] specs, String specType, Integer minWidth, Integer maxWidth, String fileNamePrefix) throws IOException;

}
