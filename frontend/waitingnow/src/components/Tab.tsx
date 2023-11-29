import { useState } from "react";
import styled from "styled-components";
import LoginForm from "./LoginForm";
import TableList from "./TableList";

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
  color: rgb(131, 131, 131);
  font-weight: bold;
  display: flex;
  flex-direction: row;
  align-items: center;
  list-style: none;
  margin-top: 10px;

  .submenu {
    display: flex;
    width: calc(100% / 3);
    padding: 10px;
    font-size: 32px;
    transition: 0.5s;
    border-radius: 10px 10px 0px 0px;
  }

  .focused {
    background-color: rgb(255, 255, 255);
    color: rgb(21, 20, 20);
  }

  & div.desc {
    text-align: center;
  }
`;

const Desc = styled.div`
  text-align: center;
`;

export const Tab = () => {
  const [currentTab, clickTab] = useState(0);

  const menuArr = [
    { name: "웨이팅", content: <TableList /> },
    { name: "테이블 & 주문", content: "Tab menu TWO" },
    { name: "더보기", content: "" },
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
};
