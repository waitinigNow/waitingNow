import React, { useEffect, useState } from 'react';
import 'styles/WaitingStyles.css';
import { telNumber, waitingPeople, waitingNumberState, babyNumber, humanNumber } from 'waitingState';
import { useRecoilValue, useRecoilState } from 'recoil';
import { useNavigate } from 'react-router-dom';
import { waiting } from 'api/waitingApi';

interface MemoizedText220Props {
  waitingNumber: number;
}

const MemoizedText220: React.FC<MemoizedText220Props> = React.memo(({ waitingNumber }) => (
  <p className="text220">{waitingNumber}</p>
));

export default function CompleteModal() {
  const [seconds, setSeconds] = useState(10);
  const telNumberValue = useRecoilValue(telNumber);
  const waitingPeopleValue = useRecoilValue(waitingPeople);
  const [telNumberState, setTelNumberState] = useRecoilState(telNumber);

  const [babyNum, setBabyNum] = useRecoilState(babyNumber);
  const [humanNum, setHumanNum] = useRecoilState(humanNumber);

  const waitingParams = {
    waitingPhone: telNumberValue,
    waitingPeople: waitingPeopleValue,
  };

  const navigate = useNavigate();

  useEffect(() => {
    const interval = setInterval(() => {
      if (seconds > 0) {
        setSeconds((prevSeconds) => prevSeconds - 1);
      }
    }, 1000);

    return () => clearInterval(interval);
  }, [seconds]);

  const [waitingNumber, setWaitingNumber] = useRecoilState(waitingNumberState);

  useEffect(() => {
    const fetchData = async () => {
    if (seconds === 10) {
      const waitingNumberValue = await waiting(waitingParams);
      setWaitingNumber(waitingNumberValue);
      }
    }
    fetchData();
  }, [seconds, setWaitingNumber]);
  

  useEffect(() => {
    if (seconds === 0) {
      navigate('/Main');
      setTelNumberState('');
      setBabyNum(0);
      setHumanNum(0);
    }
  }, [seconds, navigate]); 

  const handleGoBack = () => {
    setTelNumberState('');
    setBabyNum(0);
    setHumanNum(0);
    navigate('/Main');
  };

  return (
    <div id="back">
      <div id="modalBackground">
        <div className="modal">
          <p className="text32">접수가 완료되었습니다.<br />카카오톡으로 실시간 현황을 알려드려요.</p>
          <p className="text48">대기번호</p>
          <MemoizedText220 waitingNumber={waitingNumber} />
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
