package com.mxk.org;

import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.awt.*;
import com.sun.image.codec.jpeg.*;
import java.awt.image.BufferedImage;

import javax.imageio.ImageIO;

public class TestImage {
	
	public static void main(String[] args) throws Exception{
		TestImage t = new TestImage();
		t.img_change("E:\\", "2.png");
	}
	
	 public void img_change(String url,String name) throws Exception
	    {
		    File file = new File(url+name);
		    BufferedImage buff;
			buff = ImageIO.read(file);
			long witdh =  buff.getWidth() * 1L; 
		    long height = buff.getHeight() * 1L; 
		    
	            //���ֲ�ͬ��ѹ��ͼƬ 
	            Tosmallerpic(url,new File(url+name),"_middle",name,(int)(witdh*0.75),(int)(height*0.75),(float)0.9);
	            Tosmallerpic(url,new File(url+name),"_small",name,(int)(witdh*0.3),(int)(height*0.3),(float)0.9);
	            //Tosmallerpic(url,new File(url+name),"_smaller",name,116,100,(float)0.9);
	    }

	    private static void  Tosmallerpic(String f,File filelist,String ext,String n,int w,int h,float per){
	            Image src;
	            try {
	                src = javax.imageio.ImageIO.read(filelist); //����Image����

	               String img_midname=f+n.substring(0,n.indexOf("."))+ext+n.substring(n.indexOf("."));
	               int old_w=src.getWidth(null); //�õ�Դͼ��
	               int old_h=src.getHeight(null);
	               int new_w=0;
	               int new_h=0; //�õ�Դͼ��

	               double w2=(old_w*1.00)/(w*1.00);
	               double h2=(old_h*1.00)/(h*1.00);

	               //ͼƬ���ݳ������ף���һ��������ͼ��
	               BufferedImage oldpic;
	               if(old_w>old_h)
	               {
	                   oldpic=new BufferedImage(old_w,old_w,BufferedImage.TYPE_INT_RGB);
	               }else{if(old_w<old_h){
	                   oldpic=new BufferedImage(old_h,old_h,BufferedImage.TYPE_INT_RGB);
	               }else{
	                    oldpic=new BufferedImage(old_w,old_h,BufferedImage.TYPE_INT_RGB);
	               }
	               }
	                Graphics2D g = oldpic.createGraphics();
	                g.setColor(Color.white);
	                if(old_w>old_h)
	                {
	                    g.fillRect(0, 0, old_w, old_w);
	                    g.drawImage(src, 0, (old_w - old_h) / 2, old_w, old_h, Color.white, null);
	                }else{
	                    if(old_w<old_h){
	                    g.fillRect(0,0,old_h,old_h);
	                    g.drawImage(src, (old_h - old_w) / 2, 0, old_w, old_h, Color.white, null);
	                    }else{
	                        //g.fillRect(0,0,old_h,old_h);
	                        g.drawImage(src.getScaledInstance(old_w, old_h,  Image.SCALE_SMOOTH), 0,0,null);
	                    }
	                }             
	                g.dispose();
	                src = oldpic;
	                //ͼƬ����Ϊ���ν���
	               if(old_w>w)
	               new_w=(int)Math.round(old_w/w2);
	               else
	                   new_w=old_w;
	               if(old_h>h)
	               new_h=(int)Math.round(old_h/h2);//������ͼ����
	               else
	                   new_h=old_h;
	               BufferedImage tag = new BufferedImage(new_w,new_h,BufferedImage.TYPE_INT_RGB);       
	               //tag.getGraphics().drawImage(src,0,0,new_w,new_h,null); //������С���ͼ
	               tag.getGraphics().drawImage(src.getScaledInstance(new_w, new_h,  Image.SCALE_SMOOTH), 0,0,null);
	               FileOutputStream newimage=new FileOutputStream(img_midname); //������ļ���
	               JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(newimage);
	               JPEGEncodeParam jep=JPEGCodec.getDefaultJPEGEncodeParam(tag);
	               
	               jep.setQuality(per, true);
	               encoder.encode(tag, jep);
	               //encoder.encode(tag); //��JPEG����
	               newimage.close();
	               } catch (IOException ex) {
	                Logger.getLogger(TestImage.class.getName()).log(Level.SEVERE, null, ex);
	            }
	    }
  
}
