import React, { useState } from "react";
import { useRecoilState, useRecoilValue, atom } from "recoil";
import { userState, storeState } from "Storestate";
import Switch from "@mui/material/Switch";
import InputLabel from "@mui/material/InputLabel";
import MenuItem from "@mui/material/MenuItem";
import FormControl from "@mui/material/FormControl";
import Select, { SelectChangeEvent } from "@mui/material/Select";

export default function UserInfoInputForm() {
  const [memberStoreName, setMemberStoreName] = useRecoilState(storeState);
  const [memberStorePhone, setMemberStorePhone] = useRecoilState(storeState);
  const [memberStoreCategory, setMemberStoreCategory] =
    useRecoilState(storeState);
  const [memberPreorder, setMemberPreorder] = useRecoilState(storeState);

  const storeValue = useRecoilValue(storeState);
  const [error, setError] = useState<string>("");

  const label = { inputProps: { "aria-label": "선주문 기능 사용" } };

  const onChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const {
      target: { name, value },
    } = e;

    if (name === "store-name") {
      setMemberStoreName((prevStore) => ({
        ...prevStore,
        memberStoreName: value,
      }));
    }

    if (name === "store-phone") {
      setMemberStorePhone((prevStore) => ({
        ...prevStore,
        memberStorePhone: value,
      }));
    }
  };

  const handleChange = (event: SelectChangeEvent) => {
    setMemberStoreCategory((prevStore) => ({
      ...prevStore,
      memberStoreCategory: event.target.value as string,
    }));
  };

  return (
    <form className="form_signup">
      <div className="form_block" style={{ marginTop: "100px" }}>
        <label htmlFor="store-name">업체 이름</label>
        <input
          type="text"
          name="store-name"
          id="store-name"
          required
          onChange={onChange}
        />
      </div>
      <div className="form_block">
        <label htmlFor="store-phone">업체 전화번호</label>
        <input
          type="tel"
          name="store-phone"
          id="store-phone"
          onChange={onChange}
        />
      </div>
      <div className="form_block">
        <label htmlFor="store-category">업체 카테고리</label>
        <FormControl
          variant="standard"
          sx={{ paddingTop: 2, m: 1, width: 600, fontSize: "26px" }}
        >
          <InputLabel>카테고리 선택</InputLabel>
          <Select
            value={storeValue.memberStoreCategory}
            onChange={handleChange}
            label="category"
            sx={{ fontSize: 30 }}
          >
            <MenuItem value="">
              <em>None</em>
            </MenuItem>
            <MenuItem value={"식당"}>식당</MenuItem>
            <MenuItem value={"카페"}>카페</MenuItem>
            <MenuItem value={"팝업스토어"}>팝업스토어</MenuItem>
            <MenuItem value={"기타"}>기타</MenuItem>
          </Select>
        </FormControl>
      </div>
      <div className="form_block">
        <label htmlFor="preorder-check" style={{ width: "400px" }}>
          선주문 기능 사용 여부
        </label>
        <Switch
          {...label}
          onChange={() =>
            setMemberPreorder((prevStore) => ({
              ...prevStore,
              memberPreorder: !prevStore.memberPreorder,
            }))
          }
          sx={{
            transform: "scale(1.8)",
          }}
        />
      </div>
    </form>
  );
}
