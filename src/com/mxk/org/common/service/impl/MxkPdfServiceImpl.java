package com.mxk.org.common.service.impl;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.lowagie.text.Anchor;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;
import com.mxk.org.common.service.MxkPdfService;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.entity.SubjectEntity;
import com.mxk.org.web.part.dao.MxkPartDao;

@Service
public class MxkPdfServiceImpl implements MxkPdfService {

	@Value("${moosefs.file.image.rootpath}")
	private String rootPath;
	
	@Value("${moosefs.file.image.url}")
	private String imageurl;
	
	@Value("${mxk.web.domain}")
	private String domain;
	
	@Autowired
	private MxkPartDao partDao;
	
	@Override
	public String createSubjectPdfByParts(List<String> ids,SubjectEntity subjectEntity,String username) {
		List<PartEntity> list = partDao.findPartEntityByIds(ids);
		String filePath = null;
		 if(list != null && !list.isEmpty()){
			 filePath = File.separator + "subjectpdf" + File.separator + subjectEntity.getId()  + ".pdf"; 
			 String realPath = rootPath + filePath;
			  try{
				 File pdf = new File(realPath);
					 //中文字体
				 BaseFont bfCN = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);   
				 Font chFontBig = new Font(bfCN, 20, Font.NORMAL,Color.green);//文字大小设置
				 Font chFontSmall = new Font(bfCN, 14, Font.NORMAL,Color.blue);
				 Font chFontSmallWithColor = new Font(bfCN, 12, Font.NORMAL);
				 Font chFontMini = new Font(bfCN, 8, Font.NORMAL);
				 
				 Document document = new Document();//
				 PdfWriter pdfwriter = PdfWriter.getInstance(document,new FileOutputStream(pdf));
				 pdfwriter.setViewerPreferences(PdfWriter.HideToolbar);
				 document.open();
				  
				 Anchor anchor = new Anchor("米兔模型",chFontSmall);
				 anchor.setReference(domain);
				 document.add(anchor);
				 
				 document.add(new Paragraph(subjectEntity.getName(),chFontBig));
				 document.add(new Paragraph("专题Owner："+ username,chFontSmallWithColor));
				 document.add(new Paragraph("类型："+ subjectEntity.getTags() +"  创建时间："+ subjectEntity.getCreateTime(),chFontSmallWithColor));
			     document.add(new Paragraph(" ",chFontMini));
				 for(PartEntity partEntity : list){
					 String url = imageurl+ partEntity.getMinimage();
					 Image image = Image.getInstance(url);
					 image.scalePercent(90);
				     image.setAlignment(Image.BY);
					 document.add(image);
					 document.add(new Paragraph(partEntity.getDesc(),chFontMini));
				 }
				 document.close();
			  }catch(Exception e){
				  e.printStackTrace();
				  return null;
			  }
		  }
		return filePath;
	}

}
