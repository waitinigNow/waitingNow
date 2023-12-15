import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useRecoilState, useRecoilValue } from "recoil";
import styled from "styled-components";
import WaitingTab from "./WaitingTab";
import TableTab from "./TableTab";
import LogoutIcon from "assets/icon_logout.png";
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
  height: 864px;
  margin: auto;
`;

const TabMenu = styled.ul`
  width: 1520px;
  height: 75px;
  color: rgb(175, 175, 175);
  font-weight: bold;
  display: flex;
  align-items: center;
  list-style: none;
  margin-top: 10px;
  stroke: transparent;
  box-shadow: 0 4px 10px -4px #878787;

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
    color: var(--maincolor);
  }

  & div.desc {
    text-align: center;
  }
`;

export default function MainMenu() {
  const [currentTab, clickTab] = useState(0);
  const [memberNumber, setMemberNumber] = useRecoilState(memberNumberState);
  const [waitingList, setWaitingList] = useRecoilState(waitingListState);
  const [tableList, setTableList] = useRecoilState(tableListState);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchData = async () => {
      const token = localStorage.getItem("token");
      const storedMemberNumber = localStorage.getItem("memberNumber");

      if (token && storedMemberNumber) {
        const parsedMemberNumber = parseInt(storedMemberNumber, 10);
        if (!isNaN(parsedMemberNumber)) {
          setMemberNumber(parsedMemberNumber);
          try {
            const waitingResponse = await getWaitingList(parsedMemberNumber);
            const tableResponse = await getTableList(parsedMemberNumber);
            setWaitingList(waitingResponse.data);
            setTableList(tableResponse.data);
          } catch (error) {
            console.error("Error fetching data:", error);
          }
        }
      }
    };
    fetchData();
  }, []);

  const handleLogout = () => {
    if (window.confirm("로그아웃을 하시겠습니까?")) {
      alert("로그아웃 되었습니다.");
      localStorage.removeItem("token");
      localStorage.removeItem("memberNumber");
      navigate("/login");
    } else {
    }
  };

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
              key={index}
              className={index === currentTab ? "submenu focused" : "submenu"}
              onClick={() => selectMenuHandler(index)}
            >
              {el.name}
            </li>
          ))}
          <button type="button" className="btn-logout">
            <img src={LogoutIcon} onClick={handleLogout} />
          </button>
        </TabMenu>
        <div>
          <p>{menuArr[currentTab].content}</p>
        </div>
      </TabWrapper>
    </>
  );
}
