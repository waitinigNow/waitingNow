import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useRecoilState, useRecoilValue } from "recoil";
import { memberNumberState } from "Storestate";
import { login } from "api/storeApi";
import { toast } from "react-toastify";
import "styles/StoreStyle.css";

export default function LoginForm() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    memberPhone: "",
    memberPassword: "",
  });
  const [memberNumber, setMemberNumber] =
    useRecoilState<number>(memberNumberState);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prevFromData) => ({ ...formData, [name]: value }));
  };

  const handleLogin = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    try {
      const loggedInUser = await login(formData);
      if (loggedInUser && loggedInUser.data.code === 200) {
        // 토큰을 로컬 스토리지에 저장
        localStorage.setItem("token", loggedInUser.data.message);
        setMemberNumber(loggedInUser.data.data.memberNumber);
        toast.success("로그인에 성공하였습니다.");
        navigate("/");
      } else {
        // 로그인 실패
      }
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <>
      <form className="form_login" onSubmit={handleLogin}>
        <div className="form_block" style={{ marginTop: "30px" }}>
          <label htmlFor="name">전화번호</label>
          <input
            type="text"
            name="memberPhone"
            id="phone"
            required
            onChange={handleChange}
          />
        </div>
        <div className="form_block">
          <label htmlFor="password">비밀번호</label>
          <input
            type="password"
            name="memberPassword"
            id="password"
            required
            onChange={handleChange}
          />
        </div>
        <div className="form_block">
          <button className="btn-submit" type="submit" value="login">
            로그인하기
          </button>
        </div>
      </form>
    </>
  );
}
