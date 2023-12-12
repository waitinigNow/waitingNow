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
  waitingListState,
} from "Storestate";
import TableModal from "./TableModal";

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

export default function WaitingList() {
  const waitingData: WaitingData[] = useRecoilValue(waitingListState);
  useEffect(() => {
    console.log("data", waitingData);
  }, [waitingData]);
  const setEnterWaiting = useSetRecoilState(enterWaitingState);

  const [timers, setTimers] = useState<Array<NodeJS.Timeout | null>>(
    Array(waitingData.length).fill(null)
  );
  // 각 타이머의 남은 시간을 관리하는 배열
  const [timerSeconds, setTimerSeconds] = useState<Array<number>>(
    Array(waitingData.length).fill(0)
  );

  const startTimer = (index: number) => {
    const timeLimit = 600;

    setTimerSeconds((prev) => {
      const newTimes = [...prev];
      newTimes[index] = timeLimit;
      return newTimes;
    });

    // 타이머 시작
    const timer = setInterval(() => {
      setTimerSeconds((prev) => {
        const newTimes = [...prev];
        newTimes[index] = newTimes[index] > 0 ? newTimes[index] - 1 : 0;
        return newTimes;
      });

      if (timerSeconds[index] === 0) {
        clearInterval(timer);
        setTimers((prev) => {
          const newTimers = [...prev];
          newTimers[index] = null;
          return newTimers;
        });
      }
    }, 1000);

    setTimers((prev) => {
      const newTimers = [...prev];
      newTimers[index] = timer;
      return newTimers;
    });
  };

  // 컴포넌트 언마운트 시 모든 타이머 정리
  // useEffect(() => {
  //   return () =>
  //     timers.forEach((timer) => {
  //       if (timer) clearInterval(timer);
  //     });
  // }, [timers]);

  // const [selectedWaitingNumber, setSelectedWaitingNumber] = useState<
  //   number | null
  // >(null);

  return (
    <>
      <div className="waitingList-wrapper">
        {waitingData.length > 0 ? (
          waitingData.map((data, index) => (
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
                <button className="btn-call" onClick={() => startTimer(index)}>
                  {/* <span
                    className="call-label"
                    onClick={() => startTimer(index)}
                  >
                    호출
                  </span> */}
                  <span className="call-label">
                    {timers[index]
                      ? `남은 시간: ${timerSeconds[index]}초`
                      : "호출"}
                  </span>
                </button>
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
