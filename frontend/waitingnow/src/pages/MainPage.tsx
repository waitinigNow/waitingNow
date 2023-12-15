import React from 'react';
import WaitingLogin from 'components/WaitingLogin';
import { RecoilRoot } from "recoil";

export default function MainPage() {
  return (
    <>
      <RecoilRoot>
        <WaitingLogin />
      </RecoilRoot>
    </>
  );
}
