package com.project.nadaum.culture.show.model.dao;

import java.util.List;

import com.project.nadaum.culture.show.model.vo.Culture;

public interface CultureDao {

	int insertCultureLike(String apiCode);

	int deleteCultureLike(String apiCode);

}
