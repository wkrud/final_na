package com.project.nadaum.admin.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.admin.model.vo.Help;

public interface AdminService {

	List<Help> selectAllHelp();

	Help selectOneHelp(Map<String, Object> map);

	int updateHelpAnswer(Help help);

	int insertHelpAnswer(Help help);

}
