import React from "react";
import SignupForm from "components/SignupForm";
import { RecoilRoot } from "recoil";

export default function SignUpPage() {
  return (
    <>
      <RecoilRoot>
        <SignupForm />
      </RecoilRoot>
    </>
  );
}
