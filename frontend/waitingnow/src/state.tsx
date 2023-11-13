import { atom } from "recoil";

export interface UserTypes {
  memberName: string;
  memberPhone: string;
  memberPassword: string;
  memberStoreName: string;
  memberStorePhone: string; //null 가능
  memberStoreCategory: string;
  memberPreorder: boolean;
}

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
