package com.mxk.org.common.util;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Date;

import javax.imageio.ImageIO;

public class ImageUtil {
  
	private static final String SAVE_PATH = ImageUtil.class.getResource("/").getPath();
	private static final String PICTRUE_FORMATE_JPG = "jpg";
	private static final String POINT_JPG = ".jpg";
	
	public int[] getImageWidthAndHeightFromUrl(String imageUrl){
		int[] data = null;
		try{
			URL url = new URL(imageUrl);  
			InputStream is = url.openConnection().getInputStream();  
			BufferedImage buff = ImageIO.read(is); 
			if(buff != null){
				data = new int[2];
				Long witdh =  buff.getWidth() * 1L; 
		        Long height = buff.getHeight() * 1L; 
		        data[0] =  witdh.intValue();
		        data[1] =  height.intValue();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	
	public File pressCertificateText(String userid,int type, String username,String title,
	    int fontStyle, int fontSize, Color color, float alpha) {
		String dateStr = StringUtil.dateToString(new Date(), "yyyy-MM-dd");//日期
		File filecopy = new File(SAVE_PATH+userid+POINT_JPG);
//		File filecopy = new File("D://test3.jpg");
		try {
			File file = new File(getResource(type));
			Image image = ImageIO.read(file);
			int width = image.getWidth(null);
			int height = image.getHeight(null);
			BufferedImage bufferedImage = new BufferedImage(width, height,
					BufferedImage.TYPE_INT_RGB);  //TYPE_INT_ARGB  TYPE_INT_RGB
			Graphics2D g = bufferedImage.createGraphics();
			g.drawImage(image, 0, 0, width, height, null);
			g.setFont(new Font("黑体", fontStyle, fontSize));
			g.setColor(color);
			g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP,
					alpha));
			g.drawString(username, 40, 160);
			g.setFont(new Font("黑体", fontStyle, 30));
			g.drawString(title, 80, 300);
			g.setFont(new Font("黑体", fontStyle, 16));
			g.drawString(dateStr,210,470);
			g.dispose();
			ImageIO.write(bufferedImage, PICTRUE_FORMATE_JPG, filecopy);
		} catch (Exception e) {
			filecopy = null;
		}
		return filecopy;
	}
	
	private String getResource(int i){
		String file = null;
		switch (i) {
		case 1:
			file = ImageUtil.class.getResource("/certificatetemple/share.jpg").getPath();
			break;
		case 2:
			file = ImageUtil.class.getResource("/certificatetemple/comment.jpg").getPath();
			break;
		case 3:
			file = ImageUtil.class.getResource("/certificatetemple/subject.jpg").getPath();
			break;
		}
		return file;
	}
	
	
	public static void main(String[] args) throws IOException {
		//pressImage("C://pic//jpg", "C://pic//test.gif", 5000, 5000, 0f);
		ImageUtil t = new ImageUtil();
		//String tfilePath = t.getClass().getResource("/certificatetemple/share.jpg").getPath();
		t.pressCertificateText("ss",3, "寂寞的4角錢","草根级分享家", Font.BOLD, 15,
				Color.BLACK, 1);
		System.out.println("ok");
	}
	
}
