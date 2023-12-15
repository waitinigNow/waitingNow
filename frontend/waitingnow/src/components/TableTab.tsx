import { useState, useEffect } from "react";
import TableList from "./TableList";
import { TabWrapper, TabMenu } from "components/WaitingTab";

export default function TableTab() {
  const [currentTab, clickTab] = useState(0);

  const menuArr = [
    { name: "대기중인 테이블", content: <TableList showCompleted={false} /> },
    { name: "배정완료된 테이블", content: <TableList showCompleted={true} /> },
  ];

  const selectMenuHandler = (index: number) => {
    clickTab(index);
  };

  // 테이블 배정 상태 변경
  const handleChangeAvailable = () => {};

  return (
    <>
      <form className="" onSubmit={handleChangeAvailable}>
        <div className="table-text">
          <span>
            {currentTab === 0
              ? "배정상태로 변경할 테이블을 선택해주세요."
              : "대기상태로 변경할 테이블을 선택해주세요."}
          </span>
        </div>
        <TabMenu>
          {menuArr.map((el, index) => (
            <li
              className={index === currentTab ? "submenu focused" : "submenu"}
              onClick={() => selectMenuHandler(index)}
            >
              {el.name}
            </li>
          ))}
        </TabMenu>
        <div>
          <p>{menuArr[currentTab].content}</p>
        </div>
        <div className="form_block">
          <button className="btn-submit" type="button" value="">
            테이블 상태 변경하기
          </button>
        </div>
      </form>
    </>
  );
}
