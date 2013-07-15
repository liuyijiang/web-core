package com.mxk.org.common.util;

import java.awt.image.BufferedImage;
import java.io.InputStream;
import java.net.URL;

import javax.imageio.ImageIO;

public class ImageUtil {
  
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
	
}
