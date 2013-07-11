package com.mxk.org.common.message.listener;

import java.io.File;

import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.mxk.org.common.service.MxkGridFSFileUploadService;
import com.mxk.org.common.util.VoiceTransformUtil;
import com.mxk.org.web.comments.dao.MxkCommentsDao;
/**
 * 语音转换lame from wav -> mp3 压缩
 * @author liuyijiang
 *
 */
public class MxkVioceTransformMessageListener implements MessageListener{

	private static final Log log = LogFactory.getLog(MxkVioceTransformMessageListener.class);
	
	@Value("${moosefs.file.voice.comments}")
	private String voicepath;
	
	@Autowired
	private MxkCommentsDao commentsDao;
	
	@Autowired
	private MxkGridFSFileUploadService gridFSFileUploadService;
	
	@Override
	public void onMessage(Message message) {
		MapMessage m = (MapMessage) message;
		try {
			String trageId = m.getString("trageId");
			String wavUrl = m.getString("wavUrl");
			VoiceTransformUtil util = new VoiceTransformUtil();
			String mp3Url = wavUrl.substring(0,wavUrl.lastIndexOf(".")) + VoiceTransformUtil.VOICE_TYPE_MP3;
			if(util.voiceTransform(VoiceTransformUtil.TYPE_LAME, wavUrl, mp3Url) == 0){
				File wavfile = new File(wavUrl);
				File mp3file = new File(mp3Url);
				String url = gridFSFileUploadService.uploadFile(mp3file, trageId, MxkGridFSFileUploadService.FILE_TYPE_VOICE);
				commentsDao.updateCommentInfo(trageId,url);
				wavfile.delete();
				mp3file.delete();
			}else{
				File file = new File(wavUrl);
            	file.delete();
				commentsDao.removeComments(trageId);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage(), e);
		}
	}

}
