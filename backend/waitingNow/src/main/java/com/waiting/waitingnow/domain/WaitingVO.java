package com.waiting.waitingnow.domain;

import java.util.Date;

public class WaitingVO {
    private int waitingNumber;
    private int waitingCustomerNumber;
    private String waitingPhone;
    private int waitingPeople;
    private String waitingDate;
    private String waitingAvailable;
    private int memberNumber;

    public int getWaitingNumber() {
        return waitingNumber;
    }

    public void setWaitingNumber(int waitingNumber) {
        this.waitingNumber = waitingNumber;
    }

    public int getWaitingCustomerNumber() {
        return waitingCustomerNumber;
    }

    public void setWaitingCustomerNumber(int waitingCustomerNumber) {
        this.waitingCustomerNumber = waitingCustomerNumber;
    }

    public String getWaitingPhone() {
        return waitingPhone;
    }

    public void setWaitingPhone(String waitingPhone) {
        this.waitingPhone = waitingPhone;
    }

    public int getWaitingPeople() {
        return waitingPeople;
    }

    public void setWaitingPeople(int waitingPeople) {
        this.waitingPeople = waitingPeople;
    }

    public String getWaitingDate() {
        return waitingDate;
    }

    public void setWaitingDate(String waitingDate) {
        this.waitingDate = waitingDate;
    }

    public String getWaitingAvailable() {
        return waitingAvailable;
    }

    public void setWaitingAvailable(String waitingAvailable) {
        this.waitingAvailable = waitingAvailable;
    }

    public int getMemberNumber() {
        return memberNumber;
    }

    public void setMemberNumber(int memberNumber) {
        this.memberNumber = memberNumber;
    }
}
