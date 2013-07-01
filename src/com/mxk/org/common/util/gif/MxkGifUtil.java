package com.mxk.org.common.util.gif;

import java.awt.image.BufferedImage;
import java.io.InputStream;
import java.net.URL;

import javax.imageio.ImageIO;


public class MxkGifUtil {

	private static final String SAVE_PATH = MxkGifUtil.class.getResource("/").getPath();
	private static final String GIF = ".gif";
	
	public String createGif(String[] url,String id){
		String giflocation = SAVE_PATH + id + GIF;
		AnimatedGifEncoder e = new AnimatedGifEncoder();  
		try{
			e.setRepeat(0);  
			e.start(giflocation);  
			createGifByUrl(url,e);//createGifByFile();
			e.finish(); 
		}catch(Exception ex){
			giflocation = null;
		}
		return giflocation;
	}
	
//	private void createGifByFile(String[] files,AnimatedGifEncoder e) throws Exception {
//		for(String file : files){
//			BufferedImage src = ImageIO.read(new File(file));
//			e.setDelay(1000); // 1 frame per sec  
//			e.addFrame(src);  
//		}
//	}
	
	private void createGifByUrl(String[] urls,AnimatedGifEncoder e) throws Exception {
		for(String urliamge : urls){
			URL url = new URL(urliamge);  
			InputStream is = url.openConnection().getInputStream();  
			BufferedImage src = ImageIO.read(is); 
			e.setDelay(1000); // 1 frame per sec  
			e.addFrame(src);  
		}
	}
	
}
