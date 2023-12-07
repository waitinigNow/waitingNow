import React, { useState } from "react";
import {
  Button,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
} from "@mui/material";
import { enterWaitingState, testWaitingNumberState } from "Storestate";
import { useRecoilState, useRecoilValue } from "recoil";
import TableList from "./TableList";

interface AlertDialogProps {
  waitingNumber: number;
}

export default function TableModal({ waitingNumber }: AlertDialogProps) {
  const [open, setOpen] = useState(false);
  const selectedWaiting = useRecoilValue(enterWaitingState);
  const [testNumber, setTestNumber] = useRecoilState(testWaitingNumberState);

  const handleClickOpen = () => {
    setOpen(true);
    setTestNumber(waitingNumber);
  };

  const handleClose = () => {
    setOpen(false);
  };

  return (
    <>
      <button className="btn-in" onClick={handleClickOpen}>
        입장
      </button>
      <Dialog
        open={open}
        onClose={handleClose}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
        PaperProps={{ sx: { width: "750px" } }}
      >
        <DialogTitle id="alert-dialog-title">
          {"선택된 입장 번호:" + testNumber}
        </DialogTitle>
        <DialogContent>
          <TableList showCompleted={false} />
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose}>닫기</Button>
          <Button onClick={handleClose} autoFocus>
            배정하기
          </Button>
        </DialogActions>
      </Dialog>
    </>
  );
}
