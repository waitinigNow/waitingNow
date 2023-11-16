import { atom } from "recoil";
import { UserTypes } from "components/UserInfoInputForm";

//recoil state 생성
export const userState = atom<UserTypes>({
  key: "user",
  default: {
    memberName: "",
    memberPhone: "",
    memberPassword: "",
    memberStoreName: "",
    memberStorePhone: "",
    memberStoreCategory: "",
    memberPreorder: false,
  },
});
