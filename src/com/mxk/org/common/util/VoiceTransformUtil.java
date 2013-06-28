package com.mxk.org.common.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class VoiceTransformUtil {
 
	public static final String VOICE_TYPE_WAV = ".wav";
	
	public static final String VOICE_TYPE_MP3 = ".mp3";
	
	public static final String TYPE_SOX = "sox";
	
	public static final String TYPE_LAME = "lame";
	
	//保存音频wav
	public boolean saveVoiceStearm(InputStream inputStream,String filePath) throws Exception{
		boolean success = true;
		BufferedOutputStream out = null;
		try{
		    File file = new File(filePath);
			byte[] bit = new byte[1024] ;
			int len = -1;
			out = new BufferedOutputStream(new FileOutputStream(file));
			while((len = inputStream.read(bit)) != -1){
				out.write(bit,0,len);
			}
			out.flush();
			out.close();
		}catch(Exception e){
			e.printStackTrace();
			success = false;
		} finally {
			out.flush();
			out.close();
		}
		return success;
	}
	
	//将wav转换为MP3
	public int voiceTransform(String type,String fileName,String transformName){
		Runtime run = Runtime.getRuntime();//返回与当前 Java 应用程序相关的运行时对象  
		try {  
			String cmd = createCmd(type,fileName,transformName);
			//System.out.println(cmd);
            Process p = run.exec(cmd);// 启动另一个进程来执行命令  
            if (p.waitFor() != 0) {
            	return p.exitValue();
            }
        } catch (Exception e) {  
            e.printStackTrace();
            return -1;
        }  
        return 0;
	}
	
	//
	private String createCmd(String type,String fileName,String transformName){
		StringBuffer sb = new StringBuffer();
		if(TYPE_LAME.equals(type)){
			sb.append("lame -V2 " + fileName + " " + transformName);
		}else{
			sb.append("sox " + fileName + " -r 44100 -c 2 " + transformName);
		}
		return sb.toString();
	}
	
}
