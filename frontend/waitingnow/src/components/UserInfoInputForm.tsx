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
    <form onSubmit={onSubmit} className="form form-login">
      <form onSubmit={onSubmit} className="">
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
            placeholder="010-0000-0000"
            required
          />
        </div>
        <div className="form__block">
          <input type="submit" value="회원가입" className="form__btn-submit" />
        </div>
      </form>
    </form>
  );
}
