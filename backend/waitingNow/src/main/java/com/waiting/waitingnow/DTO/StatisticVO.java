package com.waiting.waitingnow.DTO;

import java.text.SimpleDateFormat;
import java.util.Date;

public class StatisticVO {
    private int memberNumber;
    private Date waitingDate;

    public int getMemberNumber() {
        return memberNumber;
    }

    public void setMemberNumber(int memberNumber) {
        this.memberNumber = memberNumber;
    }

    public String getWaitingDate() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return simpleDateFormat.format(waitingDate);
    }

    public void setWaitingDate(Date waitingDate) {
        this.waitingDate = waitingDate;
    }
}
