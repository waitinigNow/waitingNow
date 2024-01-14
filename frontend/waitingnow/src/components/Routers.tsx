import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import SignUpPage from "pages/signup";
import MainPage from "pages/MainPage";
import Main from "components/Main";
import MainNum from "components/MainNum";
import MainTel from "components/MainTel";
import CompleteModal from "components/CompleteModal";
import MainMenu from "components/MenuMain";
import MenuModal from "components/MenuModal";

interface RouterProps {
  isAuthenticated: boolean;
}

export default function Routers() {
  return (
    <>
      <Router>
        <Routes>
          <Route path="/signup" element={<SignUpPage />} />
          <Route path="/" element={<MainPage />} />
          <Route path="/MainNum" element={<MainNum />} />
          <Route path="/MainTel" element={<MainTel />} />
          <Route path="/CompleteModal" element={<CompleteModal />} />
          <Route path="/main" element={<Main />}></Route>
          <Route path="/MenuMain" element={<MainMenu />}></Route>
          <Route path="/MenuModal" element={<MenuModal />}></Route>
        </Routes>
      </Router>
    </>
  );
}
