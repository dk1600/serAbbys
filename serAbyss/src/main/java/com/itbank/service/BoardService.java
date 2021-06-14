package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.dao.BoardDAO;
import com.itbank.dto.BoardDTO;
import com.itbank.dto.SerCenDTO;
import com.itbank.dto.ServiceBoardDTO;

@Service
public class BoardService {
	
	@Autowired private BoardDAO dao;

	public BoardDTO boardListAll() {
		return dao.boardListAll();
	}

	public List<ServiceBoardDTO> myCompList(String person_belong) {
		return dao.myCompList(person_belong);
	}

	public List<ServiceBoardDTO> myList(String person_id) {
		return dao.myList(person_id);
	}

	public List<SerCenDTO> faqList() {
		return dao.faqList();
	}

	public List<SerCenDTO> noticeList() {
		return dao.noticeList();
	}

	public SerCenDTO selectOneNotice(int serCen_idx) {
		return dao.selectOneNotice(serCen_idx);
	}
	
}
