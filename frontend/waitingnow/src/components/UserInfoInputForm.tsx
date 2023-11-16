import React, { useState } from "react";
import { useRecoilState, atom } from "recoil";
import { userState } from "state";

export interface UserTypes {
  memberName: string;
  memberPhone: string;
  memberPassword: string;
  memberStoreName: string;
  memberStorePhone: string; //null 가능
  memberStoreCategory: string;
  memberPreorder: boolean;
}

interface InputChange {
  name: string;
  value: string;
}

export default function UserInfoInputForm() {
  const [memberName, setMemberName] = useRecoilState(userState);
  const [memberPhone, setMemberPhone] = useRecoilState(userState);
  const [memberPassword, setMemberPassword] = useRecoilState(userState);
  const [memberPasswordConfirm, setMemberPasswordConfirm] =
    useState<string>("");
  const [user, setUser] = useRecoilState(userState);

  const [error, setError] = useState<string>("");

  const onSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    // setUser({
    //   memberName: name,
    //   memberPassword: password,
    //   memberPhone: phone,
    // });
  };

  const onChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target as InputChange;

    if (name === "name") {
      setMemberName(value);
    }

    if (name === "password") {
      setMemberPassword(value);
    }

    if (name === "password_confirm") {
      setMemberPasswordConfirm(value);

      if (value?.length < 8) {
        setError("비밀번호는 8자리 이상으로 입력해주세요.");
      } else if (value !== memberPassword) {
        setError("비밀번호가 일치하지 않습니다.");
      } else {
        setError("");
      }
    }
    if (name === "phone") {
      setMemberPhone(value);
    }
  };

  return (
    <form onSubmit={onSubmit} className="form_signup">
      <div className="form_block">
        <label htmlFor="name">이름</label>
        <input type="name" name="name" id="name" required onChange={onChange} />
      </div>
      <div className="form_block">
        <label htmlFor="password">비밀번호</label>
        <input
          type="password"
          name="password"
          id="password"
          required
          onChange={onChange}
        />
      </div>
      <div className="form_block">
        <label htmlFor="password_confirm">비밀번호 확인</label>
        <input
          type="password"
          name="password_confirm"
          id="password_confirm"
          required
          onChange={onChange}
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
          onChange={onChange}
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
