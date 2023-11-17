import * as React from "react";
import Box from "@mui/material/Box";
import Stepper from "@mui/material/Stepper";
import Step from "@mui/material/Step";
import StepLabel from "@mui/material/StepLabel";
import UserInfoInputForm from "./UserInfoInputForm";

const steps = ["사용자 정보 입력", "스토어 등록"];

export default function HorizontalLinearStepper() {
  const [activeStep, setActiveStep] = React.useState(0);
  const [skipped, setSkipped] = React.useState(new Set<number>());

  const handleNext = () => {
    let newSkipped = skipped;

    setActiveStep((prevActiveStep) => prevActiveStep + 1);
    setSkipped(newSkipped);
  };

  const handleBack = () => {
    setActiveStep((prevActiveStep) => prevActiveStep - 1);
  };

  const getStepContent = (step: number): React.ReactNode => {
    switch (step) {
      case 0:
        return <UserInfoInputForm />;
      case 1:
        return <p>Test2</p>;
      default:
        return <p>Default Content</p>;
    }
  };

  return (
    <Box width={1536} height={864}>
      <Stepper activeStep={activeStep}>
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
      </Stepper>
      {activeStep === steps.length ? (
        <React.Fragment>
          Finish!
          <Box sx={{ display: "flex", flexDirection: "row", pt: 2 }}>
            <Box sx={{ flex: "1 1 auto" }} />
          </Box>
        </React.Fragment>
      ) : (
        <React.Fragment>
          <div>{getStepContent(activeStep)}</div>
          <Box sx={{ display: "flex", flexDirection: "row", pt: 2 }}>
            <button
              className="btn-submit"
              type="submit"
              value="next"
              disabled={activeStep === 0}
              onClick={handleBack}
            >
              이전
            </button>
            <Box sx={{ flex: "1 1 auto" }} />
            {/* {activeStep === steps.length - 1 ? "Finish" : "Next"} */}
            <button
              className="btn-submit"
              type="submit"
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
