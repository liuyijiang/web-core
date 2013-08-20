package com.mxk.org.web.user.domain;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
/**
 * userentity ��ֵ���� �[��password
 * @author liuyijiang
 *
 */
public class UserVO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4072865054588251284L;
	
	@Id
	private String id;
	private String name;
	private String email;
	private String createTime;
	private String info;//��������
	private String interest;//����
	private String image;
	private String minimage;//��ͼ
	private int sex;//1nman  0woman
	private int level;//�ȼ�
	private int followors;//��˿����
	private int focus;//��ע����
	private int subject;//ר������
	
	private long message;//����
	private long joinsubject;
	private long rsssubject;
	private int parts;
	
	private long sharePoint;
	private String shareTitle;
	private String shareTileImage;
	private long commentPoint;
	private String commentTitle;
	private String commentTileImage;
	private long subjectPoint;
	private String subjectTitle;
	private String subjectTileImage;
	private int eCret;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getMinimage() {
		return minimage;
	}
	public void setMinimage(String minimage) {
		this.minimage = minimage;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getFollowors() {
		return followors;
	}
	public void setFollowors(int followors) {
		this.followors = followors;
	}
	public int getFocus() {
		return focus;
	}
	public void setFocus(int focus) {
		this.focus = focus;
	}
	public int getSubject() {
		return subject;
	}
	public void setSubject(int subject) {
		this.subject = subject;
	}
	public long getMessage() {
		return message;
	}
	public void setMessage(long message) {
		this.message = message;
	}
	public long getJoinsubject() {
		return joinsubject;
	}
	public void setJoinsubject(long joinsubject) {
		this.joinsubject = joinsubject;
	}
	public long getRsssubject() {
		return rsssubject;
	}
	public void setRsssubject(long rsssubject) {
		this.rsssubject = rsssubject;
	}
	public int getParts() {
		return parts;
	}
	public void setParts(int parts) {
		this.parts = parts;
	}
	public long getSharePoint() {
		return sharePoint;
	}
	public void setSharePoint(long sharePoint) {
		this.sharePoint = sharePoint;
	}
	public String getShareTitle() {
		return shareTitle;
	}
	public void setShareTitle(String shareTitle) {
		this.shareTitle = shareTitle;
	}
	public String getShareTileImage() {
		return shareTileImage;
	}
	public void setShareTileImage(String shareTileImage) {
		this.shareTileImage = shareTileImage;
	}
	public long getCommentPoint() {
		return commentPoint;
	}
	public void setCommentPoint(long commentPoint) {
		this.commentPoint = commentPoint;
	}
	public String getCommentTitle() {
		return commentTitle;
	}
	public void setCommentTitle(String commentTitle) {
		this.commentTitle = commentTitle;
	}
	public String getCommentTileImage() {
		return commentTileImage;
	}
	public void setCommentTileImage(String commentTileImage) {
		this.commentTileImage = commentTileImage;
	}
	public long getSubjectPoint() {
		return subjectPoint;
	}
	public void setSubjectPoint(long subjectPoint) {
		this.subjectPoint = subjectPoint;
	}
	public String getSubjectTitle() {
		return subjectTitle;
	}
	public void setSubjectTitle(String subjectTitle) {
		this.subjectTitle = subjectTitle;
	}
	public String getSubjectTileImage() {
		return subjectTileImage;
	}
	public void setSubjectTileImage(String subjectTileImage) {
		this.subjectTileImage = subjectTileImage;
	}
	public int geteCret() {
		return eCret;
	}
	public void seteCret(int eCret) {
		this.eCret = eCret;
	}
	
	
}
