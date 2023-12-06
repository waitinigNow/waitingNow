import * as React from "react";
import personIcon from "assets/person.png";
import FormGroup from "@mui/material/FormGroup";
import FormControlLabel from "@mui/material/FormControlLabel";
import Checkbox from "@mui/material/Checkbox";
import { useEffect, useState } from "react";
import { getTableList } from "api/storeApi";
import { useRecoilState, useRecoilValue } from "recoil";
import { memberNumberState, tableListState } from "Storestate";

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
  const [checkedItems, setCheckedItems] = useState<boolean[]>([]);
  const tableList: TableData[] = useRecoilValue(tableListState);

  const filteredTableList = showCompleted
    ? tableList.filter((data) => !data.deskAvailable)
    : tableList.filter((data) => data.deskAvailable);

  const handleCheckboxChange = (index: number) => {
    setCheckedItems((prevCheckedItems) => {
      const updatedCheckedItems = [...prevCheckedItems];
      updatedCheckedItems[index] = !updatedCheckedItems[index];
      return updatedCheckedItems;
    });
  };

  console.log(tableList);

  return (
    <>
      {filteredTableList.map((data, index) => (
        <div
          className="table-list-item"
          key={index}
          style={{
            backgroundColor: checkedItems[index]
              ? "rgba(255, 148, 0, 0.15)"
              : "#fff",
          }}
        >
          <div className="table-info">
            <Checkbox
              checked={checkedItems[index]}
              onChange={() => handleCheckboxChange(index)}
            />
            <span className="table-number">
              {data.deskStoreNumber}번 테이블
            </span>
            <img src={personIcon} />
            <span className="table-people">{data.deskPeople} </span>
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
    </>
  );
}
