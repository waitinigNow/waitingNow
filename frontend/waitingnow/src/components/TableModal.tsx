import React, { useState } from "react";
import {
  Button,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
} from "@mui/material";
import { enterWaitingState, selectedWaitingState } from "Storestate";
import { useRecoilState, useRecoilValue, useSetRecoilState } from "recoil";
import TableList from "./TableList";

interface AlertDialogProps {
  waitingNumber: number;
}

export default function TableModal({ waitingNumber }: AlertDialogProps) {
  const [open, setOpen] = useState(false);
  const [selectedWaiting, setSelectedWaiting] =
    useRecoilState(selectedWaitingState);

  const handleClickOpen = () => {
    setOpen(true);
    setSelectedWaiting(waitingNumber);
  };

  const handleClose = () => {
    setOpen(false);
  };

  //배정하기 클릭
  const handleSubmitTable = () => {};

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
          {"선택된 입장 번호:" + selectedWaiting}
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
