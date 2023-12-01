import { atom } from "recoil";
import { UserTypes, StoreTypes } from "components/UserInfoInputForm";

//recoil state 생성
export const userState = atom<UserTypes>({
  key: "userStateKey",
  default: {
    memberName: "",
    memberPhone: "",
    memberPassword: "",
  },
});

export const storeState = atom<StoreTypes>({
  key: "storeStateKey",
  default: {
    memberStoreName: "",
    memberStorePhone: "",
    memberStoreCategory: "",
    memberPreorder: false,
  },
});

export const authState = atom<boolean>({
  key: "authStateKey",
  default: true, //추후에 서버에서 테스트할 땐 false로 변경 필요
});

export const memberNumberState = atom<number>({
  key: "memberNumberKey",
  default: 0,
});

export const waitingListState = atom({
  key: "waitingListKey",
  default: [],
});
