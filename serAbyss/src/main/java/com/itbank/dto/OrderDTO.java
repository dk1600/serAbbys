package com.itbank.dto;

import org.springframework.web.multipart.MultipartFile;

/*
 service

service_idx(PK)      sequence
service_custId      session 유저 id값 받아와서 저장
service_title      not null
service_content      not null
service_status      (R(접수)/A(배정)/P(지불)/C(완료))
service_address      session 유저 address 받아와서 저장
service_reg      default to_string('sysdate', 'yyyy-mm-dd')
service_engineer   글 작성시 '없음', 이후 기사가 배정 버튼 눌렀을때 바뀌도록
service_viewcount   default 0

*/
public class OrderDTO {
	private int service_idx, service_viewCount, service_price;
	private String service_custId, service_title, service_content, service_status, service_address, service_reg, service_engiId, 
			service_compBelong , service_name, service_phone;
	private String service_uploadFile1;
	private MultipartFile file;
	
//	public boolean ready() {
//		// uploadFile을 이용하여, originalFileName과 storedFileName 값을 만든다
//		System.out.println("file is not null? : " + (file != null));
//		if(file != null) 
//			file.getOriginalFilename();
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-hh-mm-ss");
//			String now = sdf.format(new Date());
//			service_uploadFile = now + file.getOriginalFilename();
//			return true;
//		}
//		return false;
//	}
	
	public int getService_idx() {
		return service_idx;
	}
	public void setService_idx(int service_idx) {
		this.service_idx = service_idx;
	}
	public String getService_name() {
		return service_name;
	}
	public void setService_name(String service_name) {
		this.service_name = service_name;
	}
	public String getService_phone() {
		return service_phone;
	}
	public void setService_phone(String service_phone) {
		this.service_phone = service_phone;
	}
	public int getService_viewCount() {
		return service_viewCount;
	}
	public void setService_viewCount(int service_viewCount) {
		this.service_viewCount = service_viewCount;
	}
	public String getService_custId() {
		return service_custId;
	}
	public void setService_custId(String service_custId) {
		this.service_custId = service_custId;
	}
	public String getService_title() {
		return service_title;
	}
	public void setService_title(String service_title) {
		this.service_title = service_title;
	}
	public String getService_content() {
		return service_content;
	}
	public void setService_content(String service_content) {
		this.service_content = service_content;
	}
	public String getService_status() {
		return service_status;
	}
	public void setService_status(String service_status) {
		this.service_status = service_status;
	}
	public String getService_address() {
		return service_address;
	}
	public void setService_address(String service_address) {
		this.service_address = service_address;
	}
	public String getService_reg() {
		return service_reg;
	}
	public void setService_reg(String service_reg) {
		this.service_reg = service_reg;
	}
	public String getService_engiId() {
		return service_engiId;
	}
	public void setService_engiId(String service_engiId) {
		this.service_engiId = service_engiId;
	}
	public String getService_uploadFile1() {
		return service_uploadFile1;
	}
	public void setService_uploadFile1(String service_uploadFile) {
		this.service_uploadFile1 = service_uploadFile;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public int getService_price() {
		return service_price;
	}
	public void setService_price(int service_price) {
		this.service_price = service_price;
	}
	public String getService_compBelong() {
		return service_compBelong;
	}
	public void setService_compBelong(String service_compBelong) {
		this.service_compBelong = service_compBelong;
	}
	
	
}
