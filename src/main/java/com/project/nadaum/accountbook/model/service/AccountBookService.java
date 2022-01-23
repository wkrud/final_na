package com.project.nadaum.accountbook.model.service;

import java.util.List;

import com.project.nadaum.accountbook.model.vo.AccountBook;

public interface AccountBookService {

	int insertAccount(AccountBook account);

	List<AccountBook> selectAllAccountList();

	int deleteAccount(String code);

}
