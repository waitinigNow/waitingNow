import React from 'react';
import 'styles/WaitingStyles.css';
import cancel from 'assets/cancel.png';
import { useNavigate } from 'react-router-dom';

export default function MenuModal() {
  const navigate = useNavigate();

  const handleGoBack = () => {
    navigate('/MenuMain');
  };

  return (
    <>
      <div className='back'>
        <div className='background alignCenter justifyContentSpace backgroundColor'>
          <div id='MenuModal'>
            <div className='justifyContentCenter overflowAuto'>
              <p className='text30'>
                시즈닝 선택
              </p>
              <div className='flexColumn justifyContentStart'>
                <button>
                  <p>치즈 시즈닝 추가</p>
                  <p>500원</p>
                </button>
                <button>
                  <p>어니언 시즈닝 추가</p>
                  <p>500원</p>
                </button>
                <button>
                  <p>부추 시즈닝 추가</p>
                  <p>500원</p>
                </button>
                <button>
                  <p>고추가루 추가</p>
                  <p>1,000원</p>
                </button>
              </div>
            </div>
            <div className='alignRight marginRight15 marginTop10'>
              <button id='modalCancelBtn' onClick={handleGoBack}>
                <img src={cancel} width="40px" height="40px"></img>
              </button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}