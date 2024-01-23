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
  selectedOrderState,
  menuArrayState,
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
  const [selectedOrder, setSelectedOrder] = useRecoilState(selectedOrderState);
  const [menuArray, setMenuArray] = useRecoilState(menuArrayState);

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

  // // 선주문 메뉴 확인
  // const handleCheckMenu = (deskStoreNumber: number) => {
  //   const response = checkPreorder({ deskStoreNumber: deskStoreNumber });
  //   setOpen(true);
  //   setSelectedOrder(deskStoreNumber);
  //   console.log("주문내역", response);
  // };
  const handleCheckMenu = (deskStoreNumber: number) => {
    checkPreorder({ deskStoreNumber: deskStoreNumber })
      .then((response) => {
        setOpen(true);
        setSelectedOrder(deskStoreNumber);
        console.log("주문내역", response.data);
        setMenuArray(response.data);
      })
      .catch((error) => {
        console.error("메뉴 확인 중 오류 발생:", error);
        setMenuArray([]);
      });
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
              <p>{data.deskStoreNumber}의 주문 내역</p>
            </button>
          </div>

          <div className="sit-check">
            {data.deskAvailable ? (
              <p style={{ color: "var(--maincolor)" }}>대기중</p>
            ) : (
              <p style={{ color: "#808080" }}>배정완료</p>
            )}
          </div>
        </div>
      ))}
      {open && <Modal />}
    </>
  );
}

interface MenuItem {
  memberNumber: number;
  menuCategory: string;
  menuCount: number;
  menuFile: string;
  menuName: string;
  menuNumber: number;
  // menuOption: string;
  menuPrice: number;
}

function Modal() {
  const [open, setOpen] = useRecoilState(openModalState);
  const tableNumber = useRecoilValue(selectedOrderState);
  const orderMenus: Array<MenuItem> = useRecoilValue(menuArrayState);

  const formatMenuText = (menu: MenuItem) => {
    return (
      <>
        <span style={{ fontSize: "25px" }}>
          {menu.menuName} X {menu.menuNumber}
        </span>
        <br />
      </>
    );
  };

  return (
    <div className="modal">
      <h3>선주문 내역</h3>
      {tableNumber}번 테이블 &nbsp;
      {orderMenus.map((menu) => (
        <div key={menu.menuNumber}>{formatMenuText(menu)}</div>
      ))}
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
