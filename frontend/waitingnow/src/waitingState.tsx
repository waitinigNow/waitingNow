import { atom } from "recoil";
import { UserTypes } from "components/WaitingLogin";

// 웨이팅 회원 전화번호
export const telNumber = atom<string>({
  key: 'telNumber',
  default: '',
});

// 웨이팅 회원 아동 인원
export const babyNumber = atom<number>({
  key: 'babyNumber', 
  default: 0,
});

// 웨이팅 회원 성인 인원
export const humanNumber = atom<number>({
  key: 'humanNumber', 
  default: 0,
});

// 웨이팅 회원 인원
export const waitingPeople = atom<number>({
  key: 'waitingPeopleKey',
  default: 0,
});

// 사장님 로그인 정보
export const loginInformation = atom<UserTypes>({
  key: 'loginInformationKey',
  default: {
    memberPhone: "",
    memberPassword: ""
  },
});

// 사장님 가게 번호
export const memberNumberState = atom<number>({
  key: "memberNumberKey",
  default: 0,
});

// 현재 대기 인원
export const waitingInfoState = atom<number | null>({
  key: 'waitingInfoState',
  default: 0,
});