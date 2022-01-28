package com.project.nadaum.accountbook.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.project.nadaum.accountbook.model.vo.AccountBook;
import com.project.nadaum.accountbook.model.vo.AccountBookChart;

public interface AccountBookService {

	int insertAccount(AccountBook account);

	List<AccountBook> selectAllAccountList(String id);

	int deleteAccount(Map<String, Object> code);

	List<AccountBook> monthlyTotalIncome(String id);

	String monthlyAccount(String id);

	List<AccountBook> incomeExpenseFilter(Map<String, Object> map);

	List<AccountBook> searchList(Map<String, Object> map);

	List<Map<String,Object>> chartValue(Map<String, Object> param);



}
