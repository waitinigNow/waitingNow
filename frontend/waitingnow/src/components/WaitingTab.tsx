import { useState } from "react";
import styled from "styled-components";
import LoginForm from "./LoginForm";
import WaitingList from "./WaitingList";

const TabWrapper = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 1270px;
  margin: auto;
`;

const TabMenu = styled.ul`
  width: 1270px;
  height: 40px;
  background-color: #fff;
  color: rgb(131, 131, 131);
  font-weight: bold;
  display: flex;
  align-items: center;
  list-style: none;
  margin-top: 10px;

  .submenu {
    display: flex;
    justify-content: center;
    width: calc(100% / 2);
    padding: 10px;
    font-size: 22px;
    transition: 0.5s;
    border-radius: 10px 10px 0px 0px;
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

const Desc = styled.div`
  text-align: center;
`;

export default function WaitingTab() {
  const [currentTab, clickTab] = useState(0);

  const menuArr = [
    { name: "대기팀", content: <WaitingList /> },
    { name: "완료", content: "Tab menu TWO" },
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
        <Desc>
          <p>{menuArr[currentTab].content}</p>
        </Desc>
      </TabWrapper>
    </>
  );
}
