import React from "react";
import UserInfoInputForm from "components/UserInfoInputForm";
import Stepper from "components/Stepper";
import { RecoilRoot } from "recoil";

export default function LoginPage() {
  return (
    <>
      <RecoilRoot>
        <Stepper />
      </RecoilRoot>
    </>
  );
}
