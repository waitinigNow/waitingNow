package com.waiting.waitingnow.domain;

public class PreorderVO {
    private int preorderNumber;
    private int waitingNumber;
    private int menuNumber;
    private int preorderMenuCount;

    public int getPreorderNumber() {
        return preorderNumber;
    }

    public void setPreorderNumber(int preorderNumber) {
        this.preorderNumber = preorderNumber;
    }

    public int getWaitingNumber() {
        return waitingNumber;
    }

    public void setWaitingNumber(int waitingNumber) {
        this.waitingNumber = waitingNumber;
    }

    public int getMenuNumber() {
        return menuNumber;
    }

    public void setMenuNumber(int menuNumber) {
        this.menuNumber = menuNumber;
    }

    public int getPreorderMenuCount() {
        return preorderMenuCount;
    }

    public void setPreorderMenuCount(int preorderMenuCount) {
        this.preorderMenuCount = preorderMenuCount;
    }
}
