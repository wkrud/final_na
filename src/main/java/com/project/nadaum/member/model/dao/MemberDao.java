package com.project.nadaum.member.model.dao;

import java.util.Map;

import com.project.nadaum.member.model.vo.Member;

public interface MemberDao {

	Member selectOneMember(String id);

	int insertMember(Member member);

	int confirmMember(Map<String, String> map);

	int insertRole(Member member);


}
