package com.mxk.org.common.service;

import java.io.File;

public interface MxkFileUploadService {

	public static final String IMAGE_TYPE_PNG = ".png";
	
	public static final String USER_FOLDER = "user";
	
	public static final String PART_FOLDER = "part";
	
	public static final String IMAGE_SIZE_FULL = "_full";
	
	public static final String IMAGE_SIZE_MINI = "_mini";
	
	public boolean removeFileByPath(String path);
	
	public String uploadFile(File file,String id,String folder,String size,int width, int height);
	
	public String uploadFileThumbnailZip(File file, String id, String folder,String size, double ratio);
}
