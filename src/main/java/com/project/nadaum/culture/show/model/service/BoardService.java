package com.project.nadaum.culture.show.model.service;

import com.project.nadaum.culture.show.model.vo.Culture;

public interface BoardService {

	int selectTotalContent();

	Culture selectOneBoard(String code);

}
