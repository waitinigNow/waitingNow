import React, { useState } from "react";
import { useRecoilState, useRecoilValue } from "recoil";
import { userState, authState } from "Storestate";
import { phoneAuth } from "api/storeApi";
import { toast } from "react-toastify";
import { UserTypes, StoreTypes } from "Storestate";
import "styles/StoreStyle.css";

export default function UserInfoInputForm() {
  const [memberName, setMemberName] = useRecoilState(userState);
  const [memberPhone, setMemberPhone] = useRecoilState(userState);
  const [memberPassword, setMemberPassword] = useRecoilState(userState);
  const [memberPasswordConfirm, setMemberPasswordConfirm] =
    useState<string>("");
  const [memberAuthCode, setMemberAuthCode] = useState<string>("");

  const [authCode, setAuthCode] = useState<string>("");
  const [isCorrect, setIsCorrect] = useRecoilState(authState);
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
      const passwordRegex = /^[a-zA-Z0-9?!\@]+$/;

      setMemberPassword((prevUser) => ({
        ...prevUser,
        memberPassword: value,
      }));
      if (value?.length < 4) {
        setError("비밀번호는 4자리 이상으로 입력해주세요.");
      } else if (!value?.match(passwordRegex)) {
        setError(
          "비밀번호 형식이 올바르지 않습니다. 영문 대소문자, 숫자와 특수기호(?,!,@)만 사용이 가능합니다."
        );
      }
    }

    if (name === "password_confirm") {
      setMemberPasswordConfirm(value);
      const passwordRegex = /^[a-zA-Z0-9?!\@]+$/;

      if (value !== memberPassword.memberPassword) {
        setError("비밀번호가 일치하지 않습니다.");
      } else if (!value?.match(passwordRegex)) {
        setError(
          "비밀번호 형식이 올바르지 않습니다. 영문 대소문자, 숫자와 특수기호(?,!,@)만 사용이 가능합니다."
        );
      }
    }

    if (name === "phone") {
      const phoneRegex = /^\d{11}$/;
      setMemberPhone((prevUser) => ({
        ...prevUser,
        memberPhone: value,
      }));

      if (!value?.match(phoneRegex)) {
        setError("전화번호 형식에 옳지않습니다. 번호 11자리를 입력해주세요.");
      }
    }

    if (name === "auth") {
      setMemberAuthCode(value);
    }
  };

  const onAuthSend = async () => {
    console.log("인증번호 전송");
    console.log(memberPhone);
    try {
      const verificationCode = await phoneAuth(memberPhoneValue);
      setAuthCode(verificationCode);
    } catch (error) {
      console.error(error);
    }
  };

  const onAuthCheck = () => {
    if (memberAuthCode == authCode) {
      setIsCorrect(true);
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
      <div className="form_block">
        {error && error?.length > 0 && (
          <div className="form__block">
            <div className="form__error">{error}</div>
          </div>
        )}
      </div>
    </form>
  );
}
