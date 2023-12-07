import React, { useEffect, useState } from "react";
import personIcon from "assets/person.png";
import timeIcon from "assets/time.png";
import checkIcon from "assets/checkIcon.png";
import notIcon from "assets/notIcon.png";
import styled from "styled-components";
import { getWaitingList } from "api/storeApi";
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

  // const [currentDateTime, setCurrentDateTime] = useState(new Date());

  // useEffect(() => {
  //   const intervalId = setInterval(() => {
  //     setCurrentDateTime(new Date());
  //   }, 1000);

  //   return () => clearInterval(intervalId); // 컴포넌트 언마운트 시에 clearInterval 호출
  // }, []);

  // useEffect(() => {
  //   const updatedWaitingData = waitingData.map((item: WaitingData) => {
  //     return calWaitingTime(item.waitingDate, item);
  //   });
  // }, [currentDateTime]);

  // const [isModalOpen, setIsModalOpen] = useRecoilState(modalOpenState);
  const [isModalOpen, setIsModalOpen] = useState(false);
  // const [selectedWaitingNumber, setSelectedWaitingNumber] = useState<
  //   number | null
  // >(null);
  const openModal = (waitingNumber: number) => {
    setIsModalOpen(true);
    // setSelectedWaitingNumber(waitingNumber);
    setEnterWaiting((prevEnterWaiting) => ({
      ...prevEnterWaiting,
      waitingNumber: waitingNumber,
    }));
  };

  const closeModal = () => {
    // setSelectedWaitingNumber(null);
    setIsModalOpen(false);
    setEnterWaiting((prevEnterWaiting) => ({
      ...prevEnterWaiting,
      waitingNumber: 0,
    }));
  };

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
                <button className="btn-call">
                  <span className="call-label">호출</span>
                  {/* <span className="time-in">타이머</span> */}
                </button>
                {/* <button
                  className="btn-in"
                  onClick={() => openModal(data.waitingNumber)}
                >
                  입장
                </button>
                {isModalOpen && <Modal closeModal={closeModal} />} */}
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
