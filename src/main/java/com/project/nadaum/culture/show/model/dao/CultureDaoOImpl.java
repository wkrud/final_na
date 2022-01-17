package com.project.nadaum.culture.show.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.culture.show.model.vo.Culture;
import com.project.nadaum.memo.model.dao.MemoDaoImpl;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class CultureDaoOImpl implements CultureDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Culture> selectMemoList() {
		return session.selectList("culture.selectCultureList");
	}

}
