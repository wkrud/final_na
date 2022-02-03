package com.project.nadaum.diary.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.diary.model.dao.DiaryDao;
import com.project.nadaum.diary.model.vo.Diary;

@Service
public class DiaryServiceImpl implements DiaryService {
	
	@Autowired
	private DiaryDao diaryDao;

	@Override
	public int insertDiary(Map<String, Object> map) {
		return diaryDao.insertDiary(map);
	}

	@Override
	public int emotionNo(String emotion) {
		return diaryDao.emotionNo(emotion);
	}

	@Override
	public List<Diary> recentlyDiary(String id) {
		return diaryDao.recentlyDiary(id);
	}

}
