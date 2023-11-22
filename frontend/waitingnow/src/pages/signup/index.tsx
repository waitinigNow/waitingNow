import React from "react";
import Stepper from "components/Stepper";
import { RecoilRoot } from "recoil";

export default function SignUpPage() {
  return (
    <>
      <RecoilRoot>
        <Stepper />
      </RecoilRoot>
    </>
  );
}
