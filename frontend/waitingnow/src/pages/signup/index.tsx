import React from "react";
import UserInfoInputForm from "components/UserInfoInputForm";
import { RecoilRoot } from "recoil";

export default function LoginPage() {
  return (
    <>
      <RecoilRoot>
        <UserInfoInputForm />
      </RecoilRoot>
    </>
  );
}
