import axios, { Axios, AxiosRequestConfig } from "axios";
import { useRecoilState, useRecoilValue } from "recoil";
import { UserTypes, StoreTypes, memberNumberState } from "Storestate";

const baseURL: string = process.env.REACT_APP_BASEURL || "";

interface APIResponse<T> {
  statusCode: number; // 상태코드 (보인 서버상태코드)
  errorCode: number; // 에러코드 (본인 서버에러코드)
  message: string; // 메시지
  result: T; // 데이터 내용
}

const client: Axios = axios.create({
  baseURL: baseURL,
  withCredentials: true,
});

// 요청을 보내기 전에 실행되는 인터셉터 수정
client.interceptors.request.use(
  (config: AxiosRequestConfig) => {
    // 로그인 요청인지 확인
    if (config.url !== "/login") {
      const token = localStorage.getItem("token");
      if (token && config.headers) {
        config.headers.token = token;
      }
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
    if (response.data.code === 200) {
      console.log("토큰", response.data.message);
      localStorage.setItem("token", response.data.message); // 토큰 저장
      localStorage.setItem("memberNumber", response.data.data.memberNumber);
    }
    return response;
  } catch (error) {
    console.log(error);
  }
}

// 토큰 이용
// 웨이팅 리스트 조회
export async function getWaitingList() {
  try {
    const token = localStorage.getItem("token");
    // 서버에 요청 시 토큰이 헤더에 포함되어야 함
    const response = await client.get("/waiting/now", {
      headers: {
        Authorization: `${token}`,
      },
    });
    return response.data;
  } catch (error) {
    console.log(error);
  }
}

// 테이블 리스트 조회
export async function getTableList() {
  try {
    const token = localStorage.getItem("token");
    const response = await client.get("/desk", {
      headers: {
        Authorization: `${token}`,
      },
    });
    console.log(response);
    return response.data;
  } catch (error) {
    console.log(error);
  }
}

// 테이블 상태 변경
export async function updateTableStatus() {
  try {
  } catch {}
}

// 테이블 배정
interface PostSitDeskParams {
  token: string | null;
  deskStoreNumber: number[];
  waitingNumber: number;
}

export async function postSitDesk(params: PostSitDeskParams) {
  try {
    const response = await client.post("/desk/sit", {
      token: params.token,
      deskStoreNumber: params.deskStoreNumber,
      waitingNumber: params.waitingNumber,
    });
    console.log("테이블 배정 api 접근", response);
    if (response.data.code === 200) {
      console.log("Response from server:", response.data);
    }
  } catch (error) {
    console.error("Error during API call:", error);
  }
}

// 웨이팅 입장완료
// interface UpdateWaitingParams {
//   waitingNumber: number;
// }

export async function updateWaitingStatus() {
  try {
    const response = await client.patch("/waiting/status", {
      waitingNumber: Number,
    });
    if (response.data.code === 200) {
      console.log("Response from server:", response.data);
    }
  } catch (error) {
    console.error("Error during API call:", error);
  }
}

interface notWaitingPeople {
  deskStoreNumber: number[];
  enterPeople: number;
}

// 실시간 입장 테이블 배정
export async function notWaitingTable(params: notWaitingPeople) {
  try {
    const token = localStorage.getItem("token");
    const response = await client.post("/desk/sit/nowaiting", {
      headers: {
        Authorization: `${token}`,
      },
      deskStoreNumber: params.deskStoreNumber,
      enterPeople: params.enterPeople,
    });
    console.log("실시간 입장", response);
  } catch (error) {
    console.log(error);
  }
}

// 선주문 메뉴 확인
export async function checkPreorder() {
  try {
    const token = localStorage.getItem("token");
    const response = await client.get("/preorder", {
      // waitingNumber: Number,
    });
    if (response.data.code === 200) {
      console.log("Response from server:", response.data);
    }
  } catch (error) {
    console.log(error);
  }
}
