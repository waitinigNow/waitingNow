import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useRecoilState, useRecoilValue } from "recoil";
import { memberNumberState } from "Storestate";
import { login } from "api/api";
import { toast } from "react-toastify";

export default function LoginForm() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({ phone: "", password: "" });
  const [memberNumber, setMemberNumber] =
    useRecoilState<number>(memberNumberState);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
    console.log(formData);
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    try {
      const loggedInUser = await login(formData);
      if (loggedInUser && loggedInUser.status === 200) {
        // 로그인 성공
        setMemberNumber(loggedInUser?.data.memberNumber);
        toast("로그인에 성공하였습니다.");
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
      <form className="form_login" onSubmit={handleSubmit}>
        <div className="form_block" style={{ marginTop: "30px" }}>
          <label htmlFor="name">전화번호</label>
          <input
            type="text"
            name="phone"
            id="phone"
            required
            onChange={handleChange}
          />
        </div>
        <div className="form_block">
          <label htmlFor="password">비밀번호</label>
          <input
            type="password"
            name="password"
            id="password"
            required
            onChange={handleChange}
          />
        </div>
        <div className="form_block">
          <button className="btn-submit" type="button" value="login">
            로그인하기
          </button>
        </div>
      </form>
    </>
  );
}
