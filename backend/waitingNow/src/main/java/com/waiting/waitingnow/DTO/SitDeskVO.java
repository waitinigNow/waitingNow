package com.waiting.waitingnow.DTO;

@Deprecated
public class SitDeskVO {
    private int memberNumber;
    private int deskStoreNumber;
    private int waitingNumber;

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
}
