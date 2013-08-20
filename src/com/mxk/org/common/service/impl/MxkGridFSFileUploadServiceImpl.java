package com.mxk.org.common.service.impl;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;

import javax.imageio.ImageIO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.stereotype.Service;

import com.mongodb.DB;
import com.mongodb.gridfs.GridFS;
import com.mongodb.gridfs.GridFSInputFile;
import com.mxk.org.common.service.MxkGridFSFileUploadService;
import com.mxk.org.entity.UserEntity;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

@Service
public class MxkGridFSFileUploadServiceImpl implements MxkGridFSFileUploadService {

	private static final Log log = LogFactory.getLog(MxkGridFSFileUploadServiceImpl.class);
	
	@Autowired
	private MongoOperations mog; 
	
	@Value("${gridfs.image.colloction}")
	private String imageCollection;
	
	@Value("${gridfs.voice.colloction}")
	private String voiceCollection;
	
	@Value("${gridfs.pdf.colloction}")
	private String pdfCollection;
	
	@Value("${gridfs.excel.colloction}")
	private String excelCollection;
	
	/**
	 *  size ͼƬ�Ǵ�ͼ����Сͼ
	 */
	@Override
	public String uploadImage(File file, String id, String type, String size,double max) {
		String successName = null;
		GridFSInputFile gfsInput = null;
		DB db = mog.getCollection(mog.getCollectionName(UserEntity.class)).getDB();
		db.requestStart(); 
		try{
			 //ѹ��ͼƬ
			 weakZipImage(file,max);
			 gfsInput = new GridFS(db, getGridFsCollectionName(type)).createFile(file);//�趨gridfs��ݿ�λ��
			 gfsInput.setFilename(id + size + type);//�趨�ļ���
			 gfsInput.setContentType("png");//�趨�ļ�����
			 gfsInput.save(); //save
			 successName = id + size + type;
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}
		return successName;
	}

	@Override
	public String uploadFile(File file, String id, String type) {
		String successName = null;
		GridFSInputFile gfsInput = null;
		DB db = mog.getCollection(mog.getCollectionName(UserEntity.class)).getDB();
		db.requestStart(); 
		try{
			 gfsInput = new GridFS(db, getGridFsCollectionName(type)).createFile(file);//�趨gridfs��ݿ�λ��
			 gfsInput.setFilename(id  + type);//�趨�ļ���
			 gfsInput.save(); //save
			 gfsInput.setContentType(getContentTypeName(type));
			 successName = id + type;
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}
		return successName;
	}
	
	private String getGridFsCollectionName(String type){
		if(MxkGridFSFileUploadService.FILE_TYPE_IMAGE.equals(type)){
			return imageCollection;
		}else if(MxkGridFSFileUploadService.FILE_TYPE_VOICE.equals(type)){
			return voiceCollection;
		}else if(MxkGridFSFileUploadService.FILE_TYPE_PDF.equals(type)){
			return pdfCollection;
		}else if(MxkGridFSFileUploadService.FILE_TYPE_XLS.equals(type)){
			return excelCollection;
		}else if(MxkGridFSFileUploadService.FILE_TYPE_GIF.equals(type)){
			return imageCollection;
		}else if(MxkGridFSFileUploadService.FILE_TYPE_JPG.equals(type)){
			return imageCollection;
		}else{
			return null;
		}
	}
	
	private String getContentTypeName(String type){
		if(MxkGridFSFileUploadService.FILE_TYPE_IMAGE.equals(type)){
			return imageCollection;
		}else if(MxkGridFSFileUploadService.FILE_TYPE_VOICE.equals(type)){
			return "audio/mpeg";
		}else if(MxkGridFSFileUploadService.FILE_TYPE_PDF.equals(type)){
			return pdfCollection;
		}else if(MxkGridFSFileUploadService.FILE_TYPE_XLS.equals(type)){
			return "xls";
		}else if(MxkGridFSFileUploadService.FILE_TYPE_GIF.equals(type)){
			return imageCollection;
		}else{
			return null;
		}
	}
	
	//ǿ��ѹ�� ͼƬ��״�ı�
	private void strongZipImage(File file, int width, int height) throws Exception{
		 BufferedImage image = ImageIO.read(file);
		 BufferedImage bfImage = new BufferedImage(width, height,
                 BufferedImage.TYPE_INT_RGB);
         bfImage.getGraphics().drawImage(image.getScaledInstance(width, height,
                         Image.SCALE_SMOOTH), 0, 0, null);
         FileOutputStream os = new FileOutputStream(file);
         JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);
         encoder.encode(bfImage);
         os.close();
	}
	
	//��ѹ�� ͼƬ��״���ı�
	private void weakZipImage(File file,double max){
		try{
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
            FileOutputStream os = new FileOutputStream(file);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);
            encoder.encode(bfImage);
            os.close();
		} catch (Exception e) {
			e.printStackTrace();
            log.error(e.getMessage(), e);
        }
	}

	@Override
	public boolean removeFile(String fileName, String type) {
		 boolean success = true;
		 DB db = mog.getCollection(mog.getCollectionName(UserEntity.class)).getDB();
		 GridFS gridfs = new GridFS(db, getGridFsCollectionName(type));
		 try{
			 gridfs.remove(fileName);
		 }catch(Exception e){
			 success = false;
			 log.error(e.getMessage(), e);
		 }
		 return success;
	}

	@Override
	public String uploadImageWithSize(File file, String id, String type,
			String size, int witdh, int height) {
		String successName = null;
		GridFSInputFile gfsInput = null;
		DB db = mog.getCollection(mog.getCollectionName(UserEntity.class)).getDB();
		db.requestStart(); 
		try{
			 //ѹ��ͼƬ
			 strongZipImage(file,witdh,height);
			 gfsInput = new GridFS(db, getGridFsCollectionName(type)).createFile(file);//�趨gridfs��ݿ�λ��
			 gfsInput.setFilename(id + size + type);//�趨�ļ���
			 gfsInput.setContentType("png");//�趨�ļ�����
			 gfsInput.save(); //save
			 successName = id + size + type;
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}
		return successName;
	}

}
