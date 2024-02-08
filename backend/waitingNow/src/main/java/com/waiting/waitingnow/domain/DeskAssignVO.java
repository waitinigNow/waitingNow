package com.waiting.waitingnow.domain;

public class DeskAssignVO {
    private int deskAssignKey;
    private int memberNumber;
    private int deskStoreNumber;
    private int waitingNumber;
    private Boolean preorderExist;

    public int getDeskAssignKey() {
        return deskAssignKey;
    }

    public void setDeskAssignKey(int deskAssignKey) {
        this.deskAssignKey = deskAssignKey;
    }

    public int getMemberNumber() {
        return memberNumber;
    }

    public void setMemberNumber(int memberNumber) {
        this.memberNumber = memberNumber;
    }

    public int getDeskStoreNumber() {
        return deskStoreNumber;
    }

    public void setDeskStoreNumber(int deskStoreNumber) {
        this.deskStoreNumber = deskStoreNumber;
    }

    public int getWaitingNumber() {
        return waitingNumber;
    }

    public void setWaitingNumber(int waitingNumber) {
        this.waitingNumber = waitingNumber;
    }

    public Boolean getPreorderExist() {
        return preorderExist;
    }

    public void setPreorderExist(Boolean preorderExist) {
        this.preorderExist = preorderExist;
    }
}
