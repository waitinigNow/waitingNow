import React from "react";
import personIcon from "assets/person.png";
import timeIcon from "assets/time.png";
import checkIcon from "assets/checkIcon.png";
import notIcon from "assets/notIcon.png";
import styled from "styled-components";
import { getWaitingList } from "api/api";
import { useRecoilState, useRecoilValue } from "recoil";
import { memberNumberState } from "Storestate";

const StyledButton = styled.button``;

const ContentContainer = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
`;

const Icon = styled.img`
  margin-top: 5px;
`;

const Text = styled.div``;

export default function WaitingList() {
  const waitingData = [
    {
      waitingNumber: 7,
      waitingCustomerNumber: 3,
      waitingPhone: "010-8734-9687",
      waitingPeople: 3,
      waitingDate: "2023-11-24 03:29:13",
      waitingAvailable: "대기",
      memberNumber: 1,
    },
    {
      waitingNumber: 8,
      waitingCustomerNumber: 4,
      waitingPhone: "010-5571-5343",
      waitingPeople: 5,
      waitingDate: "2023-11-24 03:29:13",
      waitingAvailable: "대기",
      memberNumber: 1,
    },
  ];

  function formatPhoneNumber(phoneNumber: string) {
    return (
      phoneNumber.slice(0, 3) +
      "-" +
      phoneNumber.slice(3, 7) +
      "-" +
      phoneNumber.slice(7)
    );
  }

  return (
    <>
      {waitingData.map((data, index) => (
        <div className="list-item" key={index}>
          <div className="waiting-index">
            <span>{index + 1}</span>
          </div>
          <div className="waiting-info">
            <span className="waiting-phone">{data.waitingPhone}</span>
            <div className="waiting-detail">
              <div className="waiting-people">
                <img src={personIcon} alt={`People ${index}`} />
                <span>{data.waitingPeople}</span>
              </div>
              <div className="waiting-time">
                <img src={timeIcon} alt={`Time ${index}`} />
                <span>웨이팅 시간</span>
              </div>
            </div>
          </div>
          <div className="button-block">
            <button className="btn-call">
              <span className="call-label">호출</span>
              {/* <span className="time-in">타이머</span> */}
            </button>
            <button className="btn-in">입장</button>
            <button className="btn-not-in">미입장</button>
          </div>
        </div>
      ))}
    </>
  );
}
