import { atom } from 'recoil';

export const telNumber = atom({
  key: 'telNumber',
  default: '',
});

export const babyNumber = atom({
  key: 'babyNumber', 
  default: 0,
});

export const humanNumber = atom({
  key: 'humanNumber', 
  default: 0,
});