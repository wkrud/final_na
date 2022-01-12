package com.project.nadaum.member.model.vo;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Member extends MemberEntity implements Serializable, UserDetails {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private List<SimpleGrantedAuthority> authorities;
	
	public Member(String id, String password, String name, String email, String address, Date regDate, String phone,
			String nickname, Search search, String introduce, Date birthday, boolean enabled,
			List<SimpleGrantedAuthority> authorities) {
		super(id, password, name, email, address, regDate, phone, nickname, search, introduce, birthday, enabled);
		this.authorities = authorities;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getUsername() {
		return getId();
	}

	@Override
	public boolean isAccountNonExpired() {return true;}

	@Override
	public boolean isAccountNonLocked() {return true;}

	@Override
	public boolean isCredentialsNonExpired() {return true;}


	

}
