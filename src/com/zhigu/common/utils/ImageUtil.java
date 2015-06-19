package com.zhigu.common.utils;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.GraphicsConfiguration;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.HeadlessException;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.Toolkit;
import java.awt.Transparency;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.awt.image.ConvolveOp;
import java.awt.image.Kernel;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import org.apache.log4j.Logger;
import org.apache.sanselan.ImageReadException;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.zhigu.common.utils.image.CmykImageUtil;

/**
 * 图片工具类
 * 
 * @author
 */
public final class ImageUtil {

	private static final Logger LOGGER = Logger.getLogger(ImageUtil.class);

	private ImageUtil() {
	}

	/**
	 * 给图片添加水印、可设置水印的旋转角度，文字位置居中
	 * 
	 * @param logoText
	 * @param srcImgPath
	 *            全路径
	 * @param targerPath
	 * @throws IOException
	 */
	public static void pressText(String srcImgPath, String logoText) throws IOException {
		File _file = new File(srcImgPath);

		BufferedImage srcImg = null;

		// 主图片的路径
		InputStream is = null;
		OutputStream os = null;
		try {
			srcImg = CmykImageUtil.readImage(_file);
			// InputStream _is = new FileInputStream(srcImgPath);
			//
			// ByteArraySeekableStreamWrap wrap =
			// ByteArraySeekableStreamWrap.wrapInputStream(_is);
			//
			// /**
			// * 利用JAI读取源图片
			// */
			// ParameterBlock pb = new ParameterBlock();
			// pb.add(wrap);
			// PlanarImage srcImg = JAI.create("Stream", pb);
			// srcImg = ImageColorConvertHelper.convertCMYK2RGB(srcImg);

			int fontSize = srcImg.getWidth() / 15;
			BufferedImage buffImg = new BufferedImage(srcImg.getWidth(), srcImg.getHeight(), BufferedImage.TYPE_INT_RGB);
			// 得到画笔对象
			Graphics2D g = buffImg.createGraphics();
			// 设置对线段的锯齿状边缘处理
			g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
			g.drawImage(srcImg, 0, 0, null);
			// 设置水印旋转
			g.rotate(Math.toRadians(325), (double) buffImg.getWidth() / 2, (double) buffImg.getHeight() / 2);
			// 设置颜色
			g.setColor(Color.DARK_GRAY);
			Font font = new Font("隶书", Font.BOLD, fontSize);
			// 设置 Font
			g.setFont(font);
			float alpha = 0.5f;
			g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));
			int width = srcImg.getWidth();
			int height = srcImg.getHeight();

			/** 设置字体在图片中的位置 在这里是居中* */
			FontRenderContext context = g.getFontRenderContext();
			Rectangle2D bounds = font.getStringBounds(logoText, context);
			double x = (width - bounds.getWidth()) / 2;
			double y = (height - bounds.getHeight()) / 2;
			double ascent = -bounds.getY();
			double baseY = y + ascent;

			// 第一参数->设置的内容，后面两个参数->文字在图片上的坐标位置(x,y) .
			g.drawString(logoText, (int) x, (int) baseY);
			g.dispose();
			os = new FileOutputStream(srcImgPath);
			// 生成图片
			ImageIO.write(buffImg, "jpg", os);
		} catch (ImageReadException e) {
			LOGGER.error("读取图片出错：" + e.getMessage());
		} finally {
			try {
				if (null != is)
					is.close();
			} catch (Exception e) {
				LOGGER.error("关闭图片输入流出错：" + e.getMessage());
			}
			try {
				if (null != os)
					os.close();
			} catch (Exception e) {
				LOGGER.error("关闭图片输出流出错：" + e.getMessage());
			}
		}
	}

	// public static void main(String[] args) throws IOException {
	// String srcImgPath = "F:/static/081/a.jpg";
	// String log = "ffafasdfwertewtfffffff";
	// pressText(srcImgPath, log);
	// }

	/**
	 * 创建小图片 V1.3使用，改写算法，图片清晰度更好
	 * 
	 * @param source
	 *            原图片
	 * @param target
	 *            目标图片
	 * @param width
	 *            图片宽度，高度自动根据比例计算
	 * @return 创建图片是否成功
	 */
	public static void ImageScale(String sourceImg, String targetImg, int width, int height) {
		Image image = Toolkit.getDefaultToolkit().getImage(sourceImg);
		ImageScale(image, targetImg, width, height);
	}

	public static void ImageScale(Image image, String targetImg, int width, int height) {
		try {

			BufferedImage bis = toBufferedImage(image);
			int imageWidth = bis.getWidth(null);
			int imageHeight = bis.getHeight(null);
			float scale = getRatio(imageWidth, imageHeight, width, height);
			imageWidth = (int) (scale * imageWidth);
			imageHeight = (int) (scale * imageHeight);
			image = bis.getScaledInstance(imageWidth, imageHeight, Image.SCALE_AREA_AVERAGING);
			// Make a BufferedImage from the Image.
			BufferedImage mBufferedImage = new BufferedImage(imageWidth, imageHeight, BufferedImage.TYPE_INT_RGB);
			Graphics2D g2 = mBufferedImage.createGraphics();

			// Map readeringHint = new HashMap();
			// readeringHint.put(RenderingHints.KEY_ALPHA_INTERPOLATION,
			// RenderingHints.VALUE_ALPHA_INTERPOLATION_QUALITY);
			// readeringHint.put(RenderingHints.KEY_ANTIALIASING,
			// RenderingHints.VALUE_ANTIALIAS_ON);
			// readeringHint.put(RenderingHints.KEY_COLOR_RENDERING,RenderingHints.VALUE_RENDER_QUALITY);
			// readeringHint.put(RenderingHints.KEY_DITHERING,
			// RenderingHints.VALUE_DITHER_ENABLE);
			// readeringHint.put(RenderingHints.KEY_INTERPOLATION,
			// RenderingHints.VALUE_INTERPOLATION_BILINEAR);//VALUE_INTERPOLATION_BICUBIC
			// readeringHint.put(RenderingHints.KEY_RENDERING,
			// RenderingHints.VALUE_RENDER_QUALITY);
			// g.setRenderingHints(readeringHint);

			g2.drawImage(image, 0, 0, imageWidth, imageHeight, Color.white, null);
			g2.dispose();

			float[] kernelData2 = { -0.125f, -0.125f, -0.125f, -0.125f, 2, -0.125f, -0.125f, -0.125f, -0.125f };
			Kernel kernel = new Kernel(3, 3, kernelData2);
			ConvolveOp cOp = new ConvolveOp(kernel, ConvolveOp.EDGE_NO_OP, null);
			mBufferedImage = cOp.filter(mBufferedImage, null);
			FileOutputStream out = new FileOutputStream(targetImg);
			// JPEGEncodeParam param =
			// encoder.getDefaultJPEGEncodeParam(bufferedImage);
			// param.setQuality(0.9f, true);
			// encoder.setJPEGEncodeParam(param);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			encoder.encode(mBufferedImage);
			out.close();
		} catch (FileNotFoundException fnf) {
		} catch (IOException ioe) {
		} finally {

		}
	}

	/**
	 * 读取图片为bufferedimage,修正图片读取ICC信息丢失而导致出现红色遮罩
	 * 
	 * @param image
	 * @return
	 */
	public static BufferedImage toBufferedImage(Image image) {
		if (image instanceof BufferedImage) {
			return (BufferedImage) image;
		}

		// This code ensures that all the pixels in the image are loaded
		image = new ImageIcon(image).getImage();

		// Determine if the image has transparent pixels; for this method's
		// implementation, see e661 Determining If an Image Has Transparent
		// Pixels
		// boolean hasAlpha = hasAlpha(image);

		// Create a buffered image with a format that's compatible with the
		// screen
		BufferedImage bimage = null;
		GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
		try {
			// Determine the type of transparency of the new buffered image
			int transparency = Transparency.OPAQUE;
			/*
			 * if (hasAlpha) { transparency = Transparency.BITMASK; }
			 */

			// Create the buffered image
			GraphicsDevice gs = ge.getDefaultScreenDevice();
			GraphicsConfiguration gc = gs.getDefaultConfiguration();
			bimage = gc.createCompatibleImage(image.getWidth(null), image.getHeight(null), transparency);
		} catch (HeadlessException e) {
			// The system does not have a screen
		}

		if (bimage == null) {
			// Create a buffered image using the default color model
			int type = BufferedImage.TYPE_INT_RGB;
			// int type = BufferedImage.TYPE_3BYTE_BGR;//by wang
			/*
			 * if (hasAlpha) { type = BufferedImage.TYPE_INT_ARGB; }
			 */
			bimage = new BufferedImage(image.getWidth(null), image.getHeight(null), type);
		}

		// Copy image to buffered image
		Graphics g = bimage.createGraphics();

		// Paint the image onto the buffered image
		g.drawImage(image, 0, 0, null);
		g.dispose();

		return bimage;
	}

	private static float getRatio(int width, int height, int maxWidth, int maxHeight) {
		float Ratio = 1.0f;
		float widthRatio;
		float heightRatio;
		widthRatio = (float) maxWidth / width;
		heightRatio = (float) maxHeight / height;
		if (widthRatio < 1.0 || heightRatio < 1.0) {
			Ratio = widthRatio <= heightRatio ? widthRatio : heightRatio;
		}
		return Ratio;
	}
}