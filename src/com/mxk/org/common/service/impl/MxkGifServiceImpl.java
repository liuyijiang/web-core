package com.mxk.org.common.service.impl;

import java.io.File;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.mxk.org.common.service.MxkGifService;
import com.mxk.org.common.util.gif.MxkGifUtil;
import com.mxk.org.entity.PartEntity;
import com.mxk.org.web.part.dao.MxkPartDao;

@Service
public class MxkGifServiceImpl implements MxkGifService {

    private static final Log log = LogFactory.getLog(MxkGifServiceImpl.class);
	
	@Value("${gridfs.pdf.iamge.url}")
	private String imageurl;
	
	@Autowired
	private MxkPartDao partDao;
	
	@Override
	public File createSubjectGifByParts(List<String> ids, String subjectid) {
		List<PartEntity> list = partDao.findPartEntityByIds(ids);
		String url[] = new String[ids.size()];
		File file = null;
		try{
			if(list != null && !list.isEmpty()){
				for (int i=0 ; i<list.size() ; i++) {
					PartEntity p = list.get(i);
					url[i] = imageurl + p.getMinimage();
				}
				MxkGifUtil util = new MxkGifUtil();
				String location = util.createGif(url, subjectid);
				if(location != null){
					file = new File(location);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage(),e);
			file = null;
		}
		return file;
	}
	
	

}
