import React from "react";
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
