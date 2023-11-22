import axios, { Axios, AxiosRequestConfig } from "axios";
import { UserTypes } from "components/UserInfoInputForm";
import { useState } from "react";
import { useRecoilState, useRecoilValue } from "recoil";
import { userState } from "state";

const baseURL = "http://localhost:8080";
const client: Axios = axios.create({
  baseURL: baseURL,
});

interface APIResponse<T> {
  statusCode: number; // 상태코드 (보인 서버상태코드)
  errorCode: number; // 에러코드 (본인 서버에러코드)
  message: string; // 메시지
  result: T; // 데이터 내용
}

//GET 메서드
export const getData = async <T,>(
  url: string,
  config?: AxiosRequestConfig
): Promise<APIResponse<T>> => {
  try {
    const response = await client.get<APIResponse<T>>(url, config);
    return response.data;
  } catch (error) {
    throw new Error();
  }
};

//POST 메서드
export const postData = async <T,>(
  url: string,
  data?: any,
  config?: AxiosRequestConfig
): Promise<APIResponse<T>> => {
  try {
    const response = await client.post<APIResponse<T>>(url, data, config);
    return response.data;
  } catch (error) {
    throw new Error();
  }
};

// 핸드폰 번호 인증
export async function phoneAuth(memberPhoneValue: string) {
  try {
    const response = await axios.post("/user/phone/auth", {
      memberPhone: memberPhoneValue,
    }); //memberphone값 전달
    return response.data.data;
  } catch (error) {
    console.log(error);
  }
}
