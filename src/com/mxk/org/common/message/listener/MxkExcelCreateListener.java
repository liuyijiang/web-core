package com.mxk.org.common.message.listener;

import java.io.File;

import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.mxk.org.common.service.MxkExcelSupportService;
import com.mxk.org.common.service.MxkGridFSFileUploadService;
import com.mxk.org.entity.SubjectMaterialSummaryEntity;
import com.mxk.org.web.subject.service.MxkSubjectMaterialService;
/**
 * Éú³É subject excel
 * @author Administrator
 *
 */
public class MxkExcelCreateListener implements MessageListener{

	private static final Log log = LogFactory.getLog(MxkExcelCreateListener.class);
	
	@Autowired
	private MxkExcelSupportService excelSupportService;
	
	@Autowired
	private MxkGridFSFileUploadService gridFSFileUploadService;
	
	@Autowired
	private MxkSubjectMaterialService subjectMaterialService;
	
	@Override
	public void onMessage(Message message) {
		MapMessage m = (MapMessage) message;
		String summaryId;
		try {
			summaryId = m.getString("summaryId");
			SubjectMaterialSummaryEntity summary  = subjectMaterialService.findSubjectMaterialSummaryEntityById(summaryId);
			if(summary != null){
				File file = excelSupportService.createSubjectMaterialExcel(summary.getSubjectId());
			    if(file != null){
			    	if(summary.getDowmloadExl() != null){
			    		gridFSFileUploadService.removeFile(summary.getDowmloadExl(), MxkGridFSFileUploadService.FILE_TYPE_XLS);
			    	}
			    	String url = gridFSFileUploadService.uploadFile(file, summary.getId(), MxkGridFSFileUploadService.FILE_TYPE_XLS);
			    	subjectMaterialService.updateSubejcyMaterialExcelUrl(summary.getId(),url);
			    }
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}

}
