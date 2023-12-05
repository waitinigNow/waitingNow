import * as React from "react";
import personIcon from "assets/person.png";
import FormGroup from "@mui/material/FormGroup";
import FormControlLabel from "@mui/material/FormControlLabel";
import Checkbox from "@mui/material/Checkbox";
import { useEffect } from "react";
import { getTableList } from "api/storeApi";
import { useRecoilState, useRecoilValue } from "recoil";
import { memberNumberState, tableListState } from "Storestate";

export interface TableData {
  deskStoreNumber: number;
  deskPeople: number;
}

export default function CheckboxLabels() {
  const [checkedItems, setCheckedItems] = React.useState<boolean[]>([]);
  const memberNumber = useRecoilValue(memberNumberState);
  const tableList: TableData[] = useRecoilValue(tableListState);

  const testData = [
    {
      tableNumber: 1,
      tablePeople: 3,
      tableSit: false,
    },
    {
      tableNumber: 2,
      tablePeople: 4,
      tableSit: false,
    },
  ];

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
      {tableList.map((data, index) => (
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
            {data ? (
              <p style={{ color: "#808080" }}>배정완료</p>
            ) : (
              <p style={{ color: "var(--maincolor)" }}>대기중</p>
            )}
          </div>
        </div>
      ))}
    </>
  );
}
