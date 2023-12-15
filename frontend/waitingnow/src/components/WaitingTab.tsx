import { useState } from "react";
import styled from "styled-components";
import LoginForm from "components/LoginForm";
import WaitingList from "components/WaitingList";
import "styles/StoreStyle.css";

export const TabWrapper = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 1270px;
`;

export const TabMenu = styled.ul`
  width: 1270px;
  height: 40px;
  background-color: #fff;
  color: rgb(131, 131, 131);
  font-weight: bold;
  display: flex;
  align-items: center;
  text-align: center;
  list-style: none;
  margin-top: 10px;

  .submenu {
    display: flex;
    justify-content: center;
    width: calc(100% / 2);
    padding: 10px;
    font-size: 22px;
    transition: 0.5s;
  }

  .focused {
    background-color: rgb(255, 255, 255);
    color: rgb(21, 20, 20);
    border-bottom: 3px solid #000000;
  }

  & div.desc {
    text-align: center;
  }
`;

export default function WaitingTab() {
  const [currentTab, clickTab] = useState(0);

  const menuArr = [
    { name: "대기팀", content: <WaitingList showCompleted={true} /> },
    { name: "완료", content: <WaitingList showCompleted={false} /> },
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
          <span>{menuArr[currentTab].content}</span>
        </div>
      </TabWrapper>
    </>
  );
}
