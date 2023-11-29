import axios, { Axios, AxiosRequestConfig } from "axios";
import { UserTypes, StoreTypes } from "components/UserInfoInputForm";

const baseURL = "http://118.222.85.227:8080";
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
  console.log("전송");
  try {
    const response = await client.post("/user/phone/auth", {
      memberPhone: memberPhoneValue,
    });
    return response.data.data;
  } catch (error) {
    console.log(error);
  }
}

// 회원가입
export interface SignupParams extends UserTypes, StoreTypes {}
export async function signup(params: SignupParams) {
  try {
    const response = await client.post("/signup", params);
    return response.data.code;
  } catch (error) {
    console.log(error);
  }
}

// 로그인
export async function login(formData: { phone: string; password: string }) {
  console.log(formData);
  try {
    const response = await client.post("/login", formData);
    return response;
  } catch (error) {
    console.log(error);
  }
}

//웨이팅 테이블 조회
export async function tableList(memberNumber: string) {
  try {
    const response = await client.get("/waiting", {
      params: { memberNumber: memberNumber },
    });
    return response.data;
  } catch (error) {
    console.log(error);
  }
}
