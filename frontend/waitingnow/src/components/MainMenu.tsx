import { useState, useEffect } from "react";
import { useRecoilState, useRecoilValue } from "recoil";
import styled from "styled-components";
import WaitingTab from "./WaitingTab";
import TableTab from "./TableTab";
import { getTableList, getWaitingList } from "api/storeApi";
import {
  memberNumberState,
  tableListState,
  waitingListState,
} from "Storestate";

const TabWrapper = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 1520px;
  margin: auto;
`;

const TabMenu = styled.ul`
  width: 1520px;
  height: 75px;
  background-color: #fff;
  color: rgb(175, 175, 175);
  font-weight: bold;
  display: flex;
  align-items: center;
  list-style: none;
  margin-top: 10px;

  .submenu {
    display: flex;
    justify-content: center;
    width: calc(100% / 3);
    padding: 10px;
    font-size: 32px;
    transition: 0.5s;
    border-radius: 10px 10px 0px 0px;
  }

  .focused {
    background-color: rgb(255, 255, 255);
    color: var(--maincolor);
  }

  & div.desc {
    text-align: center;
  }
`;

export default function MainMenu() {
  const [currentTab, clickTab] = useState(0);
  const memberNumber = useRecoilValue(memberNumberState);
  const [waitingList, setWaitingList] = useRecoilState(waitingListState);
  const [tableList, setTableList] = useRecoilState(tableListState);
  const [waitingMinutesList, setWaitingMinutesList] = useState<
    Record<number, number>
  >({});
  const updatedWaitingList: Record<number, number> = {};

  useEffect(() => {
    const fetchData = async () => {
      try {
        const waitingResponse = await getWaitingList(memberNumber);
        const tableResponse = await getTableList(memberNumber);
        setWaitingList(waitingResponse.data);
        setTableList(tableResponse.data);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };
    fetchData();
    console.log(waitingMinutesList);
  }, []);

  const menuArr = [
    { name: "웨이팅", content: <WaitingTab /> },
    { name: "테이블 & 주문", content: <TableTab /> },
    { name: "더보기", content: "Setting" },
  ];

  const selectMenuHandler = (index: number) => {
    clickTab(index);
  };

  return (
    <>
      <TabWrapper>
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
      </TabWrapper>
    </>
  );
}
