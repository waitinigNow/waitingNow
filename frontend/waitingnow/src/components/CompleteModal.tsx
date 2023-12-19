import React, { useEffect, useState } from 'react';
import 'styles/WaitingStyle.css';
import { telNumber, waitingPeople, waitingNumberState } from 'waitingState';
import { useRecoilValue, useRecoilState } from 'recoil';
import { useNavigate } from 'react-router-dom';
import { waiting } from 'api/waitingApi';

export default function CompleteModal() {
  const [seconds, setSeconds] = useState(10);
  const telNumberValue = useRecoilValue(telNumber);
  const waitingPeopleValue = useRecoilValue(waitingPeople);
  const [waitingNumber, setWaitingNumber] = useRecoilState(waitingNumberState);

  const waitingParams = {
    waitingPhone: telNumberValue,
    waitingPeople: waitingPeopleValue,
  };

  const navigate = useNavigate();

  const [telNumberState, setTelNumberState] = useRecoilState(telNumber);

  useEffect(() => {
    const interval = setInterval(() => {
      if (seconds > 0) {
        setSeconds((prevSeconds) => prevSeconds - 1);
      }
    }, 1000);

    return () => clearInterval(interval);
  }, [seconds]);

  useEffect(() => {
    if (seconds === 10) {
      waiting(waitingParams).then((waitingNumber) => {
        setWaitingNumber(waitingNumber);
      });
    }
  }, [seconds]);

  useEffect(() => {
    if (seconds === 0) {
      navigate('/'); // seconds가 0이 되면 다음 화면으로 이동
    }
  }, [seconds, navigate]);

  const handleGoBack = () => {
    setTelNumberState('');
    navigate('/');
  };

  return (
    <div className="back">
      <div className="background">
        <div className="modal">
          <p className="text32">접수가 완료되었습니다.<br />카카오톡으로 실시간 현황을 알려드려요.</p>
          <p className="text48">대기번호</p>
          <p className="text220">{waitingNumber}</p>
          <div className="modalFlex">
            <a className="orderBtn" href='/'>
              <p className="text40">메뉴 선주문하기</p>
            </a>
            <button className="backBtn" onClick={handleGoBack}>
              <p className="text40">처음으로&nbsp;({seconds}초)</p>
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
