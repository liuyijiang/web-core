package com.mxk.org.common.util;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

import com.swetake.util.Qrcode;

public class QrCodeUtil {

	private static final String SAVE_PATH = QrCodeUtil.class.getResource("/")
			.getPath();
	private static final String PNG = ".png";
	public static final String QRCODE = "_qrcode";

	public File createQrCodeImage(String content, String subid) {
		File file = new File(SAVE_PATH + subid + QRCODE + PNG);
		try {
			Qrcode qrcodeHandler = new Qrcode();
			qrcodeHandler.setQrcodeErrorCorrect('M');
			qrcodeHandler.setQrcodeEncodeMode('B');
			qrcodeHandler.setQrcodeVersion(7);
			byte[] contentBytes = content.getBytes("UTF-8");
			BufferedImage bufImg = new BufferedImage(140, 140,
					BufferedImage.TYPE_INT_RGB);
			Graphics2D gs = bufImg.createGraphics();
			gs.setBackground(Color.WHITE);
			gs.clearRect(0, 0, 140, 140);
			// 设定图像颜色 > BLACK
			gs.setColor(Color.BLACK);
			// 设置偏移量 不设置可能导致解析出错
			int pixoff = 2;
			// 输出内容 > 二维码
			if (contentBytes.length > 0 && contentBytes.length < 120) {
				boolean[][] codeOut = qrcodeHandler.calQrcode(contentBytes);
				for (int i = 0; i < codeOut.length; i++) {
					for (int j = 0; j < codeOut.length; j++) {
						if (codeOut[j][i]) {
							gs.fillRect(j * 3 + pixoff, i * 3 + pixoff, 3, 3);
						}
					}
				}
				gs.dispose();
				bufImg.flush();
				// 生成二维码QRCode图片
				ImageIO.write(bufImg, "png", file);
			} else {
				file = null;
			}
		} catch (Exception e) {
			file = null;
		}
		return file;
	}

}
