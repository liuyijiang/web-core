package com.mxk.org.common.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import jxl.SheetSettings;
import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mxk.org.common.service.MxkExcelSupportService;
import com.mxk.org.common.util.StringUtil;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.entity.SubjectMaterialDetailEntity;
import com.mxk.org.web.subject.dao.MxkSubjectDao;
import com.mxk.org.web.subject.dao.MxkSubjectMaterialDao;

@Service
public class MxkExcelSupportServiceImpl implements MxkExcelSupportService {

	private static final Log log = LogFactory.getLog(MxkExcelSupportServiceImpl.class);
	
	private static final String SAVE_PATH = MxkExcelSupportServiceImpl.class.getResource("/").getPath();
	
	@Autowired
	private MxkSubjectMaterialDao subjectMaterialDao;
	
	@Autowired
	private MxkSubjectDao subjectDao;
	
	@Override
	public File createSubjectMaterialExcel(String subjectid) {
		SubjectEntity sub = subjectDao.findSubjectEntityById(subjectid);
		List<SubjectMaterialDetailEntity> list = subjectMaterialDao.findSubjectMaterialDetailEntityBySubjectId(subjectid);
		WritableWorkbook wwb = null;
		String execl = SAVE_PATH + subjectid +".xls";
		File file = new File(execl);
		try{
			if(list != null && !list.isEmpty()){
				WritableCellFormat style = new WritableCellFormat(); // ��Ԫ����   ��ʽ
				style.setAlignment(jxl.format.Alignment.RIGHT);
				WritableFont headerFont = new WritableFont(WritableFont.ARIAL, 16,
				WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,
				jxl.format.Colour.BLACK);
				WritableCellFormat headerStyle = new WritableCellFormat(headerFont); // ��Ԫ���� ��ʽ
				headerStyle.setAlignment(jxl.format.Alignment.CENTRE);
	
				wwb = Workbook.createWorkbook(file);
				WritableSheet ws = wwb.createSheet(sub.getName(), 0);  
		        SheetSettings sheetSettings = ws.getSettings();
		        sheetSettings.setPrintGridLines(true);//��ӡ����ʾ����
		        Label header = new Label(0, 0, sub.getName(),headerStyle);
		        ws.addCell(header);
		        ws.setRowView(0, 500);// �����еĸ߶�
		        ws.setColumnView(0, 27); // �����еĿ��
		        ws.mergeCells(0, 0, 4, 0); // �ϲ���Ԫ��
		        BigDecimal allmoney = new BigDecimal(0.0);//�ܼ�
		        Label th1 = new Label(0, 2, "��������");
		        Label th2 = new Label(1, 2, "����");
		        Label th3 = new Label(2, 2, "Ʒ��");
		        Label th4 = new Label(3, 2, "����");
		        Label th5 = new Label(4, 2, "����");
		        ws.setColumnView(2, 27); // �����еĿ��
		        ws.addCell(th1);
		        ws.addCell(th2);
		        ws.addCell(th3);
		        ws.addCell(th4);
		        ws.addCell(th5);
		        int cell = 3;
		        for(SubjectMaterialDetailEntity vo : list){
		        	Label tb1 = new Label(0, cell, vo.getName());
		 	        Label tb2 = new Label(1, cell, vo.getType());
		 	        Label tb3 = new Label(2, cell, vo.getBrand());
		 	        Label tb4 = new Label(3, cell, String.valueOf(vo.getNum()));
		 	        Label tb5 = new Label(4, cell,  String.valueOf(vo.getMoney()));
		 	        ws.addCell(tb1);
			        ws.addCell(tb2);
			        ws.addCell(tb3);
			        ws.addCell(tb4);
			        ws.addCell(tb5);
			        BigDecimal money = vo.getMoney().multiply(new BigDecimal(vo.getNum()));
					allmoney = allmoney.add(money);
					cell = cell + 1;
		        }
		        String dateStr = StringUtil.dateToString(new Date(), "yyyy-MM-dd");
		        Label seh1 = new Label(0, 1, "����ʱ�䣺"+dateStr);
		        Label seh2 = new Label(1, 1, "�ܽ�"+allmoney,style);
		        ws.addCell(seh1);
		        ws.addCell(seh2);
		        ws.mergeCells(1, 1, 4, 1); // �ϲ���Ԫ��
		        wwb.write();
	        	wwb.close();
	        }
		}catch(Exception e){
			log.error(e.getMessage(),e);
			file = null;
		}
		return file;
	}
}
