import axios, { Axios, AxiosRequestConfig } from "axios";

const baseURL: string = process.env.REACT_APP_BASEURL || "";

const client: Axios = axios.create({
  baseURL: baseURL,
  withCredentials: true,
});

// axios interceptor (헤더 수정, 인증 토큰 추가, 오류 처리, 요청 및 응답 기록)
  // 헤더에 토큰을 싣을때 사용
client.interceptors.request.use(
  (config: AxiosRequestConfig) => {
    const token = localStorage.getItem("token");

    if (token && config.headers) {
      config.headers.Authorization = `${token}`
      
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);


// 사장님 회원번호 받아오기
export async function getMemberNum(memberPhoneValue: string) {
  try {
    const response = await client.post("/user", {
      memberPhone: memberPhoneValue
    });
    localStorage.getItem(response.data.data.memberNumber);
    return response.data.data.memberNumber;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

// 현재 대기 손님 수 띄우기 (Main에서)
export async function nowPeople(memberNum: number) {
  try {
    const token = localStorage.getItem('token');
    console.log("token" + token);
    const response = await client.get("/waiting/now/people", {
      headers: {
        'Authorization': `${token}`,
      },
    },);
    return response.data.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

// 사장님 로그인
export async function login(formData: {
  memberPhone: string,
  memberPassword: string
}) {
  try {
    const response = await client.post('/login', formData);
    if (response.data.code === 200) {
      localStorage.setItem("token", response.data.message); // 토큰 저장
      localStorage.setItem("memberNumber", response.data.data.memberNumber);
    }
    return response;
  } catch (error) {
    console.log(error);
  }
}

// 인원수, 웨이팅 고객 전화번호, 사장님 번호 -> 웨이팅 등록
export async function waiting(params: {
  waitingPhone: string, 
  waitingPeople: number
}) {
  try {
    const response = await client.post('/waiting', params);
    console.log(response);
    return response.data.data.waitingNumber;
  } catch(error) {
    console.log(error);
  }
}

// 사장님 가게에 등록되어있는 메뉴 가져오기
export async function viewMenu(memberNum: number) {
  try {
    const token = localStorage.getItem('token');
    const response = await client.get("/menu", {
      headers: {
        'Authorization': `${token}`,
      },
    },);
    console.log(response.data);
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}