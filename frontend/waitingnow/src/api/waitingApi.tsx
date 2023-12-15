import axios, { Axios, AxiosRequestConfig } from "axios";

const baseURL: string = process.env.REACT_APP_BASEURL || "";

const client: Axios = axios.create({
  baseURL: baseURL,
  withCredentials: true,
});


// 사장님 회원번호 받아오기
export async function getMemberNum(memberPhoneValue: string) {
  try {
    const response = await client.post("/user", {
      memberPhone: memberPhoneValue
    });
    return response.data.data.memberNumber;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

// 현재 대기 손님 수 띄우기 (Main에서)
export async function nowPeople(memberNum: number) {
  try {
    const response = await client.get("/waiting/now/people", {
      params: { memberNumber: memberNum },
    });
    console.log(response.data.data);
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
    return response;
  } catch (error) {
    console.log(error);
  }
}

// 인원수, 웨이팅 고객 전화번호, 사장님 번호 -> 웨이팅 등록
export async function waiting(params: {
  waitingPhone: string, 
  waitingPeople: number,
  memberNumber: number
}) {
  try {
    const response = await client.post('/waiting', params)
    console.log(response)
  } catch(error) {
    console.log(error);
  }
}