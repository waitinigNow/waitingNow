import React, { useEffect } from 'react';
import 'styles/MainNum.css';
import minus from 'assets/minus.png';
import plus from 'assets/plus.png';
import { useRecoilState } from 'recoil';
import { babyNumber, humanNumber, waitingPeople } from 'waitingState';
import { Link } from 'react-router-dom';

export default function MainNum() {
  const [babyNum, setBabyNum] = useRecoilState<number>(babyNumber);
  const [humanNum, setHumanNum] = useRecoilState<number>(humanNumber);

  const [waitingPeopleValue, setWaitingPeopleValue] = useRecoilState(waitingPeople);

  const handleBabyUp = () => {
    setBabyNum(babyNum + 1);
  };

  const handleBabyDown = () => {
    if (babyNum > 0) {
      setBabyNum(babyNum - 1);
    }
  };

  const handleHumanUp = () => {
    setHumanNum(humanNum + 1);
  };

  const handleHumanDown = () => {
    if (humanNum > 0) {
      setHumanNum(humanNum - 1);
    }
  };

  useEffect (() => {
    setWaitingPeopleValue((prevwaitingPeopleValue) => babyNum + humanNum);
  });

  return (
    <>
      <div id="back">
        <div id="MainNumBackground">
          <div id="inputNum">
            <p id="title">입장인원</p>
            <p id="alert">입장 인원을 입력해주세요.</p>
            <div className="flexBetween">
              <p className="number">아동 (8세 이하)</p>
              <div className="flex">
                <button className="btn" id="babyDownbtn" onClick={handleBabyDown}>
                  <img src={minus} alt="minus" width="35px" height="35px" className="btnSet" />
                </button>
                <p id="babyNum" className="number">
                  {babyNum}
                </p>
                <button className="btn" id="babyUpbtn" onClick={handleBabyUp}>
                  <img src={plus} alt="plus" width="35px" height="35px" className="btnSet" />
                </button>
              </div>
            </div>
            <div className="flexBetween">
              <p className="number">성인</p>
              <div className="flex">
                <button className="btn" id="humanDownbtn" onClick={handleHumanDown}>
                  <img src={minus} alt="minus" width="35px" height="35px" className="btnSet" />
                </button>
                <p id="humanNum" className="number">
                  {humanNum}
                </p>
                <button className="btn" id="humanUpbtn" onClick={handleHumanUp}>
                  <img src={plus} alt="plus" width="35px" height="35px" className="btnSet" />
                </button>
              </div>
            </div>
            <div className='btns'>
              <button className="beforeBtn">
                이전
              </button>
              <Link to="/completeModal" className="completeBtn">
                <button id="completeBtn">
                  완료
                </button>
              </Link>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
