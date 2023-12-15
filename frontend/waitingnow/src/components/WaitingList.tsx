import React, { useEffect, useState } from "react";
import personIcon from "assets/person.png";
import timeIcon from "assets/time.png";
import checkIcon from "assets/checkIcon.png";
import notIcon from "assets/notIcon.png";
import styled from "styled-components";
import { getWaitingList } from "api/storeApi";
import { atom } from "recoil";
import { useRecoilState, useRecoilValue, useSetRecoilState } from "recoil";
import {
  WaitingData,
  enterWaitingState,
  memberNumberState,
  timerActiveStateFamily,
  timerControl,
  timerState,
  timerStateFamily,
  timerUpdateSelectorFamily,
  waitingListState,
} from "Storestate";
import TableModal from "./TableModal";
import { Timer } from "./Timer";
import "styles/StoreStyle.css";

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

// 웨이팅 시간 - 분으로 계산
// export function calWaitingTime(
//   waitingDate: string,
//   originalData: WaitingData
// ): WaitingData {
//   const serverDate = new Date(waitingDate);
//   const currentDate = new Date();

//   const timeDifference = currentDate.getTime() - serverDate.getTime();
//   const waitingMinutes = Math.floor(timeDifference / (1000 * 60));

//   return {
//     ...originalData,
//     waitingMinutes,
//   };
// }

//  웨이팅 시간 - 분으로 계산
export function calWaitingTime(waitingDate: string): number {
  const serverDate = new Date(waitingDate);
  const currentDate = new Date();

  const timeDifference = currentDate.getTime() - serverDate.getTime();
  const waitingMinutes = Math.floor(timeDifference / (1000 * 60));

  return waitingMinutes;
}

export function formatPhoneNumber(
  waitingPhone: string,
  originalData: WaitingData
): WaitingData {
  waitingPhone =
    waitingPhone.slice(0, 3) +
    "-" +
    waitingPhone.slice(3, 7) +
    "-" +
    waitingPhone.slice(7);

  return {
    ...originalData,
    waitingPhone,
  };
}

export default function WaitingList({
  showCompleted,
}: {
  showCompleted: boolean;
}) {
  const waitingData: WaitingData[] = useRecoilValue(waitingListState);

  const filteredWaitingList = showCompleted
    ? waitingData.filter(
        (data) => data.waitingAvailable === 2 || data.waitingAvailable === 1
      )
    : waitingData.filter(
        (data) =>
          data.waitingAvailable === 0 ||
          data.waitingAvailable === -1 ||
          data.waitingAvailable === -2
      );
  const setEnterWaiting = useSetRecoilState(enterWaitingState);

  return (
    <>
      <div className="waitingList-wrapper">
        {filteredWaitingList.length > 0 ? (
          filteredWaitingList.map((data, index) => (
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
                    <span>{data.waitingMinutes}분</span>
                  </div>
                </div>
              </div>
              <div className="button-block">
                {/* 호출  */}
                <Timer key={index} id={index} />
                {/* 입장 */}
                <TableModal waitingNumber={data.waitingNumber} />
                <button className="btn-not-in">미입장</button>
              </div>
            </div>
          ))
        ) : (
          <p>현재 웨이팅 목록이 없습니다.</p>
        )}
      </div>
    </>
  );
}
