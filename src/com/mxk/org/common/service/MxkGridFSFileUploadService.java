package com.mxk.org.common.service;

import java.io.File;

public interface MxkGridFSFileUploadService {

	public final static String FILE_TYPE_VOICE = ".mp3";
	
	public final static String FILE_TYPE_IMAGE = ".png";
	
	public final static String FILE_TYPE_PDF = ".pdf";
	
	public final static String FILE_TYPE_GIF = ".gif";
	
	public final static String FILE_TYPE_JPG = ".jpg";
	
	public final static String FILE_TYPE_XLS = ".xls";
	
    public static final String IMAGE_SIZE_FULL = "_full";
	
	public static final String IMAGE_SIZE_MINI = "_mini";
	
	public String uploadImage(File file,String id,String type,String size,double max);
	
	public String uploadImageWithSize(File file,String id,String type,String size,int witdh,int height);
	
	public String uploadFile(File file,String id,String type);
	
	public boolean removeFile(String fileName,String type);
	
}
