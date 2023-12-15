import React from 'react';
import 'styles/WaitingLogin.css';
import { login } from 'api/waitingApi';
import { useRecoilState, useRecoilValue } from 'recoil';
import { memberNumberState, loginInformation } from 'waitingState';
import { useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';

export interface UserTypes {
  memberPhone: string,
  memberPassword: string
}

export default function WaitingLogin() {
  const navigate = useNavigate();
  const [formData, setFormData] = useRecoilState(loginInformation);

  const [memberNumber, setMemberNumber] = useRecoilState<number>(memberNumberState);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prevFormData) => ({ ...formData, [name]: value }));
  }

  const loginSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    try {
      const loggedInUser = await login(formData);
      if (loggedInUser && loggedInUser.status === 200) {
        setMemberNumber(loggedInUser.data.data.memberNumber);
        toast.success("로그인에 성공하였습니다.");
        navigate("/Main");
      } else {
        // 로그인 실패
      }
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <>
      <div id="back">
        <div id="background">
          <form onSubmit={loginSubmit} className="loginForm">
            <p>PhoneNumber</p>
            <input className='inputForm' type="text" onChange={handleChange} name='memberPhone' value={formData.memberPhone}>
            </input>
            <p>Password</p>
            <input className='inputForm' type='password' onChange={handleChange} name='memberPassword' value={formData.memberPassword}>
            </input>
            <button type='submit'>Login</button>
          </form>
        </div>
      </div>
    </>
  );
}