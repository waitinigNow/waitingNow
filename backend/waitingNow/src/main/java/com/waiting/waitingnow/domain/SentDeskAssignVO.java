package com.waiting.waitingnow.domain;

import java.util.List;

/**
 * @SEE [DeskAssignVO와의 차이점 : deskStoreNumber : List] / [테이블 배정 해제는 DeskAssignVO 사용]
 */
public class SentDeskAssignVO {
    private int deskAssignKey;
    private int memberNumber;
    private List<Integer> deskStoreNumber;
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

    public List<Integer> getDeskStoreNumber() {
        return deskStoreNumber;
    }

    public void setDeskStoreNumber(List<Integer> deskStoreNumber) {
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
