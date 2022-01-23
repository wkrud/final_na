package com.project.nadaum.accountbook.model.dao;

import java.util.List;

import com.project.nadaum.accountbook.model.vo.AccountBook;

public interface AccountBookDao {

	int insertAccount(AccountBook account);

	List<AccountBook> selectAllAccountList(String id);

	int deleteAccount(String code);

}
