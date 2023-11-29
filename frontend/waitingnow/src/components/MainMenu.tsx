import { useState } from "react";
import styled from "styled-components";
import WaitingTab from "./WaitingTab";

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
    color: #ff9400;
  }

  & div.desc {
    text-align: center;
  }
`;

const Desc = styled.div`
  text-align: center;
`;

export default function MainMenu() {
  const [currentTab, clickTab] = useState(0);

  const menuArr = [
    { name: "웨이팅", content: <WaitingTab /> },
    { name: "테이블 & 주문", content: "테이블 UI" },
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
        <Desc>
          <p>{menuArr[currentTab].content}</p>
        </Desc>
      </TabWrapper>
    </>
  );
}
