package com.project.nadaum.culture.show.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.culture.show.model.vo.Culture;

public interface BoardDao {

	int selectTotalContent();

	Culture selectOneBoard(String code);

}
