import React, { useEffect, useState } from 'react';
import 'styles/CompleteModal.css';
import { telNumber, babyNumber, humanNumber } from './RecoilState';
import { useRecoilValue, useRecoilState } from 'recoil';
import { Link, useNavigate } from 'react-router-dom';

export default function CompleteModal() {
  const [seconds, setSeconds] = useState(10);
  const telNumberNum = useRecoilValue(telNumber);
  const babyNumberNum = useRecoilValue(babyNumber);
  const humanNumberNum = useRecoilValue(humanNumber);
  const navigate = useNavigate();

  const [telNumberState, setTelNumberState] = useRecoilState(telNumber);
  const [babyNumberState, setBabyNumberState] = useRecoilState(babyNumber);
  const [humanNumberState, setHumanNumberState] = useRecoilState(humanNumber);

  useEffect(() => {
    const interval = setInterval(() => {
      if (seconds > 0) {
        setSeconds((prevSeconds) => prevSeconds - 1);
      }
    }, 1000);

    return () => clearInterval(interval);
  }, [seconds]);

  const handleGoBack = () => {
    // Recoil 상태를 초기화
    setTelNumberState('');
    setBabyNumberState(0);
    setHumanNumberState(0);
    navigate('/');
  };

  return (
    <div className="back">
      <div className="background">
        <div className="modal">
          <p className="text32">접수가 완료되었습니다.<br />카카오톡으로 실시간 현황을 알려드려요.</p>
          <p className="text32">{`${telNumberNum}, ${babyNumberNum}, ${humanNumberNum}`}</p>
          <p className="text48">대기번호</p>
          <p className="text220">10</p>
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
