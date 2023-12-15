// Main.tsx
import React, { useEffect } from 'react';
import { Link } from 'react-router-dom';
import 'styles/Main.css';
import { nowPeople, getMemberNum } from 'api/waitingApi';
import { waitingInfoState, memberNumberState } from 'waitingState';
import { useRecoilState, useRecoilValue } from 'recoil';

export default function Main() {
  const [waitingInfo, setWaitingInfo] = useRecoilState<number | null>(waitingInfoState);
  const memberNumberValue = useRecoilValue<number>(memberNumberState);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const memberNum = localStorage.getItem('memberNumber');
        const waitingData = await nowPeople(Number(memberNum));
        console.log('Fetched data:', waitingData);
        setWaitingInfo(waitingData);
      } catch (error) {
        console.error('Error:', error);
      }
    };
  
    fetchData();
  }, [setWaitingInfo, memberNumberValue]);
  
  return (
    <>
      <div id="back">
        <div id="background">
          <div id="waitingInformation">
            <div id="waitingTime">
              <div className="bottom" id="textBox">
                <p color="#FFFFFF" id="font_small">
                  현재대기
                </p>
                <p color="#FFFFFF" id="font_big">
                  {waitingInfo}
                </p>
                <p color="#FFFFFF" id="font_small">
                  팀
                </p>
              </div>
            </div>
            <Link to="/mainTel" id="goWaiting">
              <p id="font48">웨이팅 접수</p>
            </Link>
          </div>
        </div>
      </div>
    </>
  );
}
