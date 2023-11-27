import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Main from 'components/Main';
import MainTel from 'components/MainTel';
import MainNum from 'components/MainNum';
import CompleteModal from 'components/CompleteModal';
import { RecoilRoot } from "recoil";

export default function MainPage() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Main />} />
        <Route path="/mainTel" element={<MainTel />} />
        <Route path="/mainNum" element={<MainNum />} />
        <Route path="/completeModal" element={<CompleteModal />} />
      </Routes>
    </Router>
  );
}
