package com.mxk.org;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public  class ImageUtils {
	
	private Image	srcImage	= null;
	private File	srcFile  = null;
	private File	destFile	= null;
	private String	fileSuffix	= null;
    
	private int imageWidth = 0;
	private int imageHeight = 0;

	public ImageUtils(String fileName) throws IOException {
		this(new File(fileName));
	}

	public ImageUtils(File fileName) throws IOException {
		File _file = fileName;
		_file.setReadOnly();
		this.srcFile = _file;
		this.fileSuffix = _file.getName().substring(
				(_file.getName().indexOf(".") + 1),
				(_file.getName().length()));
		this.destFile = new File(this.srcFile.getPath().substring(0,
				(this.srcFile.getPath().lastIndexOf("."))) + "//" + "." + this.fileSuffix);
		srcImage = javax.imageio.ImageIO.read(_file);
		//�õ�ͼƬ��ԭʼ��С�� �Ա㰴����ѹ����
		imageWidth = srcImage.getWidth(null);
		imageHeight = srcImage.getHeight(null);
		System.out.println("width: " + imageWidth);
		System.out.println("height: " + imageHeight);		
	}

	/**
	 * ǿ��ѹ��/�Ŵ�ͼƬ���̶��Ĵ�С
	 * @param w int �¿��
	 * @param h int �¸߶�
	 * @throws IOException
	 */
	public void resize(int w, int h) throws IOException {
		//�õ����ʵ�ѹ����С����������
		if ( imageWidth >= imageHeight)
		{
			w = w;
			h = (int)Math.round((imageHeight * w * 1.0 / imageWidth));
		}
		else 
		{
			h = h;
			w = (int)Math.round((imageWidth * h * 1.0 / imageHeight));
		}

		//����ͼƬ����
		BufferedImage _image = new BufferedImage(w, h,
				BufferedImage.TYPE_INT_RGB);
		//������С���ͼ
		_image.getGraphics().drawImage(srcImage, 0, 0, w, h, null);
		//������ļ���
		FileOutputStream out = new FileOutputStream(destFile);
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		encoder.encode(_image);
		out.flush();
		out.close();
		
	}
}