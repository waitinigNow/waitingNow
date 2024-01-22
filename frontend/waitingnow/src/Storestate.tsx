import { atom, atomFamily, selector, selectorFamily } from "recoil";

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
  waitingAvailable: number;
}

export interface TableArrange {
  memberNumber: number;
  deskStoreNumber: [];
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
    deskStoreNumber: [],
    waitingNumber: 0,
  },
});

//배정 선택받은 웨이팅 손님
export const selectedWaitingState = atom<number>({
  key: "selectedWaitingKey",
  default: 0,
});

//선택된 테이블 리스트 -> 닫기 or 다른 컴포넌트로 넘어가는 경우 reset
//selector써야할듯
export const checkedItemsState = atom<number[]>({
  key: "checkedItemsKey",
  default: [],
});

//기존 deskStoreNumber에서 선택된것만 끌어오는 방식으로 구현 예정
export const testSelector = selector({
  key: "testSelectorKey",
  get: ({ get }) => ({ ...get(checkedItemsState) }),
});

export const timerState = atom<number>({
  key: "timerStateKey",
  default: 0,
});

export const timerControl = selector<number>({
  key: "timerControl",
  get: ({ get }) => get(timerState),
  set: ({ set }, newValue) => {
    if (typeof newValue === "number") {
      set(timerState, newValue);
    }
  },
});

// 각 타이머의 상태 관리
export const timerStateFamily = atomFamily<number, number>({
  key: "timerStateFamily",
  default: 10 * 60,
});

// 각 타이머의 활성화 상태 관리
export const timerActiveStateFamily = atomFamily<boolean, number>({
  key: "timerActiveStateFamily",
  default: false,
});

// 타이머 작동 업데이트
export const timerUpdateSelectorFamily = selectorFamily<number, number>({
  key: "timerUpdateSelectorFamily",
  get:
    (id) =>
    ({ get }) =>
      get(timerStateFamily(id)),
  set:
    (id) =>
    ({ set }, newValue) => {
      set(timerStateFamily(id), newValue);
      if (newValue === 0) {
        set(timerStateFamily(id), 10 * 60);
        set(timerActiveStateFamily(id), false);
      }
    },
});

// 모달 창
export const openModalState = atom<boolean>({
  key: "openModalKey",
  default: false,
});

// 선택된 테이블의 주문내역 옵션 (테이블 번호)
export const selectedOrderState = atom<number>({
  key: "selectedOrderKey",
  default: 0,
});
