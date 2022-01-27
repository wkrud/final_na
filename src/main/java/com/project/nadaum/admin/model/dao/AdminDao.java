package com.project.nadaum.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.project.nadaum.admin.model.vo.Help;
import com.project.nadaum.member.model.vo.Member;

public interface AdminDao {

	List<Help> selectAllHelp(Map<String, Object> param);

	String selectHelpLikes(Map<String, Object> codeMap);

	Help selectOneHelp(Map<String, Object> map);

	int updateHelpAnswer(Help help);

	int countAllHelp();

	List<Member> selectAllMember(Member member);

	int insertAnnouncement(Map<String, Object> map);

	int updateAnnouncement(Map<String, Object> map);

	int deleteHelp(Map<String, Object> map);

	int deleteLikes(Map<String, Object> map);

	int deleteAnnouncement(Map<String, Object> map);

	int updateEnabled(Map<String, Object> map);

	List<SimpleGrantedAuthority> selectAllRole(Member member);

	int insertRole(Map<String, Object> map);

	int deleteRole(Map<String, Object> map);

}
