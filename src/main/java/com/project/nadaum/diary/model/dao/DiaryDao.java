package com.project.nadaum.diary.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.diary.model.vo.Diary;

public interface DiaryDao {

	int insertDiary(Map<String, Object> map);

	int emotionNo(String emotion);

	List<Diary> recentlyDiary(String id);

}
