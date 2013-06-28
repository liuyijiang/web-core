package com.mxk.org.common.service.impl;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.mxk.org.common.service.MxkFileUploadService;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * 文件上传service
 * @author liuyijiang
 *
 */
@Service
public class MxkSimpleFileUploadServiceImpl implements MxkFileUploadService {
   
	@Value("${moosefs.file.image.rootpath}")
	private String rootPath;
	
	private static final Log log = LogFactory.getLog(MxkSimpleFileUploadServiceImpl.class);
	
	@Override
	public String uploadFile(File file,String id,String folder,String size,int width, int height){
		String filePath = null;
		BufferedOutputStream out = null;
		InputStream inputStream = null;
		try{
			filePath = File.separator + folder + File.separator + id + size + MxkFileUploadServiceImpl.IMAGE_TYPE_PNG; 
			String realPath = rootPath + filePath;
			zipImage(file,width,height);//强制压缩
			File uploadFile = new File(realPath);
			inputStream = new FileInputStream(file);
			byte[] bit = new byte[1024] ;
			int len = -1;
			out = new BufferedOutputStream(new FileOutputStream(uploadFile));
			while((len = inputStream.read(bit)) != -1){
				out.write(bit,0,len);
			}
			out.flush();
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			filePath = null;
		} finally {
			try {
				out.close();
				inputStream.close();
			} catch (IOException e) {
				log.error(e.getMessage(),e);
				filePath = null;
			}
		}
		return filePath;
	}
	
	//强制压缩
	private void zipImage(File file, int width, int height)throws Exception{
		 Image srcFile = ImageIO.read(file);
		 BufferedImage tag = new BufferedImage(width, height,
               BufferedImage.TYPE_INT_RGB);
		 Graphics g = tag.getGraphics(); 
		 g.drawImage(srcFile, 0, 0, width, height, null);   
		 g.dispose();  
		 ImageIO.write(tag, "png", file);
	}
	
	@Override
	public String uploadFileThumbnailZip(File file, String id, String folder,
			String size, double max) {
		String filePath = null;
		try{
			filePath = File.separator + folder + File.separator + id + size + MxkFileUploadServiceImpl.IMAGE_TYPE_PNG; 
			String realPath = rootPath + filePath;
			BufferedImage image = ImageIO.read(file);
		    int newWidth = 0;
		    int newHeight = 0;
		    double ratio = 0.0; 
		    if(image.getHeight() > max || image.getWidth() > max){
	    	   if (image.getHeight() > image.getWidth()) {
	                ratio = max / image.getHeight();
	              } else {
	                ratio = max / image.getWidth();
	            }
	    	    newWidth = (int) (image.getWidth() * ratio);
	            newHeight = (int) (image.getHeight() * ratio);
		    }else{
		    	newWidth = image.getWidth();
	            newHeight = image.getHeight();
		    }
		    BufferedImage bfImage = new BufferedImage(newWidth, newHeight,
                    BufferedImage.TYPE_INT_RGB);
            bfImage.getGraphics().drawImage(image.getScaledInstance(newWidth, newHeight,
                            Image.SCALE_SMOOTH), 0, 0, null);
            FileOutputStream os = new FileOutputStream(realPath);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);
            encoder.encode(bfImage);
            os.close();
		} catch (Exception e) {
			e.printStackTrace();
            log.error(e.getMessage(), e);
            filePath = null;
        }
		return filePath;
	}

	@Override
	public boolean removeFileByPath(String path) {
		String realPath = rootPath + path;
		File file = new File(realPath);
		if(file.exists()){
			file.delete();
		}
		return true;
	}
	
}
