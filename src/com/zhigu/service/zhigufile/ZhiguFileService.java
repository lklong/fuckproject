/**
 * @ClassName: ZhiguFileService.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月28日
 * 
 */
package com.zhigu.service.zhigufile;

import java.io.File;
import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.zhigu.model.ZhiguFile;
import com.zhigu.model.dto.MsgBean;

/**
 * @author Administrator
 *
 */
public interface ZhiguFileService {

	/**
	 * 保存文件
	 * 
	 * @param zhiguFile
	 */
	int insert(ZhiguFile zhiguFile);

	/**
	 * 文件处理，保存
	 * 
	 * @param file
	 * @param specs
	 * @param specType
	 * @return
	 * @throws IOException
	 */
	MsgBean saveImage(MultipartFile file, String[] specs, String specType, Integer minWidth, Integer maxWidth, String fileNamePrefix) throws IOException;

	/**
	 * 保存数据包
	 * 
	 * @param file
	 * @return
	 * @throws IOException
	 */
	MsgBean saveData(MultipartFile file) throws IOException;

	/**
	 * 生成保存的目标文件
	 * 
	 * @param file
	 * @param fileNamePrefix
	 * @return
	 */
	public File generatDesFile(MultipartFile file, String fileNamePrefix);

}
