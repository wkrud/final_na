package com.project.nadaum.member.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.member.model.dao.MemberDao;
import com.project.nadaum.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Override
	public Member selectOneMember(String id) {
		return memberDao.selectOneMember(id);
	}

	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	public int confirmMember(Map<String, String> map) {
		return memberDao.confirmMember(map);
	}

	@Override
	public int insertRole(Member member) {
		return memberDao.insertRole(member);
	}

	
}
