import React from 'react';
import { Link } from 'react-router-dom';
import 'styles/Main.css';

export default function Main() {
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
                  5
                  {/* 여기는 이제 앞에 대기 남은 팀 가져오기 */}
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
