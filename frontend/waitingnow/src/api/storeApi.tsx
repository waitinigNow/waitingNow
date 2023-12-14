import axios, { Axios, AxiosRequestConfig } from "axios";
import { useRecoilState, useRecoilValue } from "recoil";
import { UserTypes, StoreTypes, memberNumberState } from "Storestate";

const baseURL: string = process.env.REACT_APP_BASEURL || "";

const client: Axios = axios.create({
  baseURL: baseURL,
  withCredentials: true,
});

interface APIResponse<T> {
  statusCode: number; // 상태코드 (보인 서버상태코드)
  errorCode: number; // 에러코드 (본인 서버에러코드)
  message: string; // 메시지
  result: T; // 데이터 내용
}

// 요청을 보내기 전에 실행되는 인터셉터 추가
client.interceptors.request.use(
  (config: AxiosRequestConfig) => {
    const token = localStorage.getItem("token");

    if (token && config.headers) {
      config.headers.Authorization = `Bearer ${token}`;
    }

    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

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
    console.log(response);
    return response.data.code;
  } catch (error) {
    console.log(error);
  }
}

// 로그인
export async function login(formData: {
  memberPhone: string;
  memberPassword: string;
}) {
  try {
    const response = await client.post("/login", formData);
    console.log(response);
    if (response.data.code === 200) {
      localStorage.setItem("token", response.data.message); // 토큰 저장
      localStorage.setItem("memberNumber", response.data.data.memberNumber);
    }
    return response;
  } catch (error) {
    console.log(error);
  }
}

// 토큰 이용
// // 웨이팅 리스트 조회
// export async function getWaitingList() {
//   try {
//     // 서버에 요청 시 토큰이 헤더에 포함되어야 함
//     const response = await client.get("/waiting/now");
//     return response.data;
//   } catch (error) {
//     console.log(error);
//   }
// }

// // 테이블 리스트 조회
// export async function getTableList() {
//   try {
//     // 서버에 요청 시 토큰이 헤더에 포함되어야 함
//     const response = await client.get("/table/now");
//     return response.data;
//   } catch (error) {
//     console.log(error);
//   }
// }

//웨이팅 리스트 조회
export async function getWaitingList(memberNumber: number) {
  try {
    const response = await client.get("/waiting/now", {
      params: { memberNumber: memberNumber },
    });
    return response.data;
  } catch (error) {
    console.log(error);
  }
}

//테이블 리스트 조회
export async function getTableList(memberNumber: number) {
  try {
    const response = await client.get("/desk", {
      params: { memberNumber: memberNumber },
    });
    return response.data;
  } catch (error) {
    console.log(error);
  }
}
