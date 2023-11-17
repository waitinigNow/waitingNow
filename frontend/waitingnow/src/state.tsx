import { atom } from "recoil";
import { UserTypes, StoreTypes } from "components/UserInfoInputForm";

//recoil state 생성
export const userState = atom<UserTypes>({
  key: "user",
  default: {
    memberName: "",
    memberPhone: "",
    memberPassword: "",
  },
});

export const storeState = atom<StoreTypes>({
  key: "store",
  default: {
    memberStoreName: "",
    memberStorePhone: "",
    memberStoreCategory: "",
    memberPreorder: false,
  },
});
