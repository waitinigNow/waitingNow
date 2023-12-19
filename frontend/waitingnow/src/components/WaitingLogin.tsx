import React from 'react';
import 'styles/WaitingStyles.css';
import { login } from 'api/waitingApi';
import { useRecoilState } from 'recoil';
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
      <div id="background_color">
        <div className="background">
          <div className='box marginLeft15'>
            <p className="font48" id='title'>LOGIN</p>
            <form onSubmit={loginSubmit}>
              <div id='inputLogin'>
                <div className='label'>
                  <label className='labelFont'>phoneNumber</label>
                </div>
                <input type="text" onChange={handleChange} name='memberPhone' value={formData.memberPhone} id='inputNumber'>
                </input>
                <span className="spin"></span>
              </div>
              <div id='inputLogin'>
                <div className='label'>
                  <label className='labelFont'>password</label>
                </div>
                <input type='password' onChange={handleChange} name='memberPassword' value={formData.memberPassword} id='inputPassword'>
                </input>
                <span className="spin"></span>
                <div className='label alignRight'>
                  <button type='submit' className='loginBtn marginTop20' id='loginBtn'>Login</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </>
  );
}