import React, { useState, ReactNode } from "react";
import Box from "@mui/material/Box";
import Stepper from "@mui/material/Stepper";
import Step from "@mui/material/Step";
import StepLabel from "@mui/material/StepLabel";
import UserInfoInputForm from "./UserInfoInputForm";
import StoreInfoInputForm from "./StoreInfoInputForm";
import { useRecoilValue } from "recoil";
import { userState, storeState, authState } from "state";
import { styled } from "@mui/system";

const steps = ["사용자 정보 입력", "스토어 등록"];

const CustomStepper = styled(Stepper)({
  "& .MuiStepIcon-root circle": {
    color: "#ff9400",
  },
});

export default function HorizontalLinearStepper() {
  const [activeStep, setActiveStep] = useState<number>(0);
  const userStateValue = useRecoilValue(userState);
  const storeStateValue = useRecoilValue(storeState);
  const isCorrectValue = useRecoilValue(authState);

  const handleNext = () => {
    if (activeStep === 0) {
      const isUserFormValid = Object.values(userStateValue).every(
        (value) => value !== ""
      );
      if (isCorrectValue && isUserFormValid) {
        setActiveStep((prevActiveStep) => prevActiveStep + 1);
      } else if (isCorrectValue === false) {
        alert("인증이 완료되지 않았습니다.");
      } else {
        alert("모든 필수 항목을 입력하세요.");
      }
    } else if (activeStep === 1) {
      const isStoreFormValid = Object.values(storeStateValue).every(
        (value) => value !== ""
      );
      if (isStoreFormValid) {
        setActiveStep((prevActiveStep) => prevActiveStep + 1);
      } else {
        alert("모든 필수 항목을 입력하세요.");
      }
    }
    console.log(userStateValue, storeStateValue);
  };

  const handleBack = () => {
    setActiveStep((prevActiveStep) => prevActiveStep - 1);
  };

  const getStepContent = (step: number): ReactNode => {
    switch (step) {
      case 0:
        return <UserInfoInputForm />;
      case 1:
        return <StoreInfoInputForm />;
      default:
        return <p>Default Content</p>;
    }
  };

  return (
    <Box
      width={1536}
      height={864}
      style={{
        position: "absolute",
        top: "50%",
        left: "50%",
        transform: "translate(-50%, -50%)",
      }}
    >
      <CustomStepper activeStep={activeStep}>
        {steps.map((label, index) => {
          const stepProps: { completed?: boolean } = {};
          const labelProps: {
            optional?: React.ReactNode;
          } = {};

          return (
            <Step key={label} {...stepProps}>
              <StepLabel {...labelProps}>{label}</StepLabel>
            </Step>
          );
        })}
      </CustomStepper>
      {activeStep === steps.length ? (
        <React.Fragment>
          <div className="form_block">
            <div className="finish_text">
              <text>회원가입이 완료되었습니다!</text>
              <br />
              <text>가입한 계정으로 로그인을 진행하세요.</text>
            </div>
          </div>
          <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              pt: 2,
            }}
          >
            <Box sx={{ flex: "1 1 auto" }} />
          </Box>
        </React.Fragment>
      ) : (
        <React.Fragment>
          <div>{getStepContent(activeStep)}</div>
          <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              pt: 2,
              position: "absolute",
              bottom: "0px",
              left: "50%",
              transform: "translateX(-50%)",
            }}
          >
            <button
              className="btn-submit"
              type="button"
              value="next"
              disabled={activeStep === 0}
              onClick={handleBack}
            >
              이전
            </button>
            <Box sx={{ flex: "1 1 auto" }} />
            <button
              className="btn-submit"
              type="button"
              value="next"
              onClick={handleNext}
            >
              다음
            </button>
          </Box>
        </React.Fragment>
      )}
    </Box>
  );
}
