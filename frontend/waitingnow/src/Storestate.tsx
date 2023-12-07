import { atom } from "recoil";

export interface UserTypes {
  memberName: string;
  memberPhone: string;
  memberPassword: string;
}

export interface StoreTypes {
  memberStoreName: string;
  memberStorePhone: string; //null 가능
  memberStoreCategory: string;
  memberPreorder: boolean;
}

export interface WaitingData {
  waitingNumber: number;
  waitingCustomerNumber: number;
  waitingPhone: string;
  waitingPeople: number;
  waitingDate: string;
  waitingMinutes: number;
}

export interface TableArrange {
  memberNumber: number;
  deskStoreNumber: number;
  waitingNumber: number;
}

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

export const tableListState = atom({
  key: "tableListKey",
  default: [],
});

// 입장하는 웨이팅 손님
export const enterWaitingState = atom<TableArrange>({
  key: "enterWaitingKey",
  default: {
    memberNumber: 0,
    deskStoreNumber: 0,
    waitingNumber: 0,
  },
});

export const selectedWaitingState = atom<number>({
  key: "testWaitingNumberKey",
  default: 0,
});
