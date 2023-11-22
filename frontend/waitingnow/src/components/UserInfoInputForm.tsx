import React, { useState } from "react";
import axios, { Axios, AxiosRequestConfig } from "axios";
import { useRecoilState, useRecoilValue, atom } from "recoil";
import { userState } from "state";
import { phoneAuth } from "api/api";
import { toast } from "react-toastify";

export interface UserTypes {
  memberName: string;
  memberPhone: string;
  memberPassword: string;
}

export interface StoreTypes {
  memberStoreName: string;
  memberStorePhone: string; //null 가능
  memberStoreCategory: string;
  memberPreorder: boolean;
}

export default function UserInfoInputForm() {
  const [memberName, setMemberName] = useRecoilState(userState);
  const [memberPhone, setMemberPhone] = useRecoilState(userState);
  const [memberPassword, setMemberPassword] = useRecoilState(userState);
  const [memberPasswordConfirm, setMemberPasswordConfirm] =
    useState<string>("");
  const [memberAuthCode, setMemberAuthCode] = useState<string>("");

  const [authCode, setAuthCode] = useState<string>("");
  const [isCheck, setIsCheck] = useState(false);
  const [error, setError] = useState<string>("");
  const memberPhoneValue = useRecoilValue(userState).memberPhone;

  const onChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const {
      target: { name, value },
    } = e;

    if (name === "name") {
      setMemberName((prevUser) => ({
        ...prevUser,
        memberName: value,
      }));
    }

    if (name === "password") {
      setMemberPassword((prevUser) => ({
        ...prevUser,
        memberPassword: value,
      }));
    }

    if (name === "password_confirm") {
      setMemberPasswordConfirm(value);

      if (value?.length < 4) {
        setError("비밀번호는 4자리 이상으로 입력해주세요.");
      } else if (value !== memberPassword.memberPassword) {
        setError("비밀번호가 일치하지 않습니다.");
      } else {
        setError("");
      }
    }

    if (name === "phone") {
      setMemberPhone((prevUser) => ({
        ...prevUser,
        memberPhone: value,
      }));
    }

    if (name === "auth") {
      setMemberAuthCode(value);
    }
  };

  const onAuthSend = async () => {
    console.log("인증번호 전송");
    try {
      const verificationCode = await phoneAuth(memberPhoneValue);
      setAuthCode(verificationCode);
    } catch (error) {
      console.error(error);
    }
  };

  const onAuthCheck = () => {
    if (memberAuthCode == authCode) {
      setIsCheck(true);
      toast.success("인증되었습니다.");
    } else {
      toast.error("인증번호가 일치하지않습니다.");
      console.log("error");
    }
  };

  return (
    <form className="form_signup">
      <div className="form_block" style={{ marginTop: "30px" }}>
        <label htmlFor="name">이름</label>
        <input
          type="text"
          name="name"
          id="name"
          value={memberName.memberName}
          required
          onChange={onChange}
        />
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
      <div className="form_block" style={{ marginBottom: "30px" }}>
        <label htmlFor="phone">전화번호</label>
        <input
          type="tel"
          name="phone"
          id="phone"
          className="phone_input"
          placeholder="010-0000-0000"
          value={memberPhone.memberPhone}
          required
          onChange={onChange}
        />
        <button
          className="btn-auth"
          type="button"
          value="인증번호 전송"
          onClick={onAuthSend}
        >
          인증번호 전송
        </button>
      </div>
      <div className="form_block">
        <label htmlFor="phone">인증번호</label>
        <input
          type="text"
          name="auth"
          id="auth"
          className="phone_check"
          required
          onChange={onChange}
        />
        <button
          className="btn-auth"
          type="button"
          value="인증번호 확인"
          onClick={onAuthCheck}
        >
          인증번호 확인
        </button>
      </div>
      {/* <div className="form_block">
        <button className="btn-submit" type="submit" value="회원가입">
          다음
        </button>
      </div> */}
    </form>
  );
}
