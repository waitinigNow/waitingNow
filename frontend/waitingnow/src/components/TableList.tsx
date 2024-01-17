import * as React from "react";
import personIcon from "assets/person.png";
import FormGroup from "@mui/material/FormGroup";
import FormControlLabel from "@mui/material/FormControlLabel";
import Checkbox from "@mui/material/Checkbox";
import { useEffect, useState } from "react";
import { checkPreorder, getTableList } from "api/storeApi";
import { useRecoilState, useRecoilValue } from "recoil";
import {
  checkedItemsState,
  memberNumberState,
  tableListState,
  openModalState,
} from "Storestate";
import "styles/StoreStyle.css";

export interface TableData {
  deskStoreNumber: number;
  deskPeople: number;
  deskAvailable: boolean;
}

export default function TableList({
  showCompleted,
}: {
  showCompleted: boolean;
}) {
  const [checkedItems, setCheckedItems] = useRecoilState(checkedItemsState);
  const tableList: TableData[] = useRecoilValue(tableListState);

  const [open, setOpen] = useRecoilState(openModalState);

  const filteredTableList = showCompleted
    ? tableList.filter((data) => !data.deskAvailable)
    : tableList.filter((data) => data.deskAvailable);

  const handleCheckboxChange = (deskStoreNumber: number) => {
    setCheckedItems((prevCheckedItems) => {
      // deskStoreNumber가 이미 배열에 있으면 제거, 없으면 추가
      if (prevCheckedItems.includes(deskStoreNumber)) {
        return prevCheckedItems.filter((item) => item !== deskStoreNumber);
      } else {
        return [...prevCheckedItems, deskStoreNumber];
      }
    });
  };

  // 선주문 메뉴 확인
  const handleCheckMenu = (deskStoreNumber: number) => {
    checkPreorder({ deskStoreNumber: deskStoreNumber });
    setOpen(true);
  };

  return (
    <>
      {filteredTableList.map((data, index) => (
        <div
          className="table-list-item"
          key={index}
          style={{
            backgroundColor: checkedItems.includes(data.deskStoreNumber)
              ? "rgba(255, 148, 0, 0.15)"
              : "#fff",
          }}
        >
          <div className="table-info">
            <Checkbox
              checked={checkedItems.includes(data.deskStoreNumber)}
              onChange={() => handleCheckboxChange(data.deskStoreNumber)}
            />
            <span className="table-number">
              {data.deskStoreNumber}번 테이블
            </span>
            <img src={personIcon} />
            <span className="table-people">{data.deskPeople} </span>
          </div>
          <div className="preorder-check">
            <button
              className="btn-preorder-check"
              type="button"
              onClick={() => handleCheckMenu(data.deskStoreNumber)}
            >
              <p>주문 내역</p>
            </button>
          </div>
          {open && <Modal data={data} />}

          <div className="sit-check">
            {data.deskAvailable ? (
              <p style={{ color: "var(--maincolor)" }}>대기중</p>
            ) : (
              <p style={{ color: "#808080" }}>배정완료</p>
            )}
          </div>
        </div>
      ))}
    </>
  );
}

function Modal({ data }) {
  const [open, setOpen] = useRecoilState(openModalState);

  return (
    <div className="modal">
      <h4>{data.title}</h4>
      <button
        type="button"
        onClick={() => {
          setOpen(!open);
        }}
      >
        닫기
      </button>
    </div>
  );
}
