import React, { useState } from "react";
import { useRecoilState, atom } from "recoil";
import { userState } from "state";

export default function UserInfoInputForm() {
  const [memberName, setMemberName] = useRecoilState(userState);
  const [memberPhone, setMemberPhone] = useRecoilState(userState);
  const [memberPassword, setMemberPassword] = useRecoilState(userState);

  const onSubmit = async (e: React.FormEvent<HTMLFormElement>) => {};
  const onChange = async (e: React.ChangeEvent<HTMLFormElement>) => {};

  return (
    <form onSubmit={onSubmit} className="form_signup">
      <div className="form_block">
        <label htmlFor="name">이름</label>
        <input type="name" name="name" id="name" required />
      </div>
      <div className="form_block">
        <label htmlFor="password">비밀번호</label>
        <input type="password" name="password" id="password" required />
      </div>
      <div className="form_block">
        <label htmlFor="password_confirm">비밀번호 확인</label>
        <input
          type="password"
          name="password_confirm"
          id="password_confirm"
          required
        />
      </div>
      <div className="form_block">
        <label htmlFor="phone">전화번호</label>
        <input
          type="tel"
          name="phone"
          id="phone"
          className="phone-input"
          placeholder="010-0000-0000"
          required
        />
        <button className="btn-auth" type="submit" value="인증번호 전송">
          인증번호 전송
        </button>
      </div>
      <div className="form_block">
        <button className="btn-submit" type="submit" value="회원가입">
          회원가입 하기
        </button>
      </div>
    </form>
  );
}
