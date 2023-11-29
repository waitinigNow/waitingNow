import React from "react";
import personIcon from "assets/person.png";
import timeIcon from "assets/time.png";

export default function TableList() {
  const testArray = [[1, "010-1234-5678"]];

  return (
    <>
      <div className="list-item">
        <div className="waiting-index">
          <span className="index-number">1</span>
        </div>
        <div className="waiting-info">
          <span className="waiting-phone">010-1234-5678</span>
          <div className="waiting-detail">
            <div className="waiting-people">
              <img src={personIcon} />
              <span>3</span>
            </div>
            <div className="waiting-time">
              <img src={timeIcon} />
              <span>웨이팅 시간</span>
            </div>
          </div>
        </div>
        <div className="button-block">
          <button className="btn-call">
            <span className="call-label">호출</span>
            <span className="time-in">타이머</span>
          </button>
          <button className="btn-in">입장</button>
          <button className="btn-not-in">미입장</button>
        </div>
      </div>
    </>
  );
}
