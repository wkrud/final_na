package com.project.nadaum.diary.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.diary.model.vo.Diary;

public interface DiaryService {

	int insertDiary(Map<String, Object> map);

	int emotionNo(String emotion);

	List<Diary> recentlyDiary(String id);

}
